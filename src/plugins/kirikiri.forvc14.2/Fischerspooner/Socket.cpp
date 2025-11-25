/*
*/

#include <winsock2.h>
#include <ws2tcpip.h>
#include <iphlpapi.h>
#include <thread>
#include <mutex>
#include <functional>
#include <vector>
#include <queue>
#include <iostream>
#include <sstream>
#include "ncbind.hpp"
#include "kim/KimException.h"

#include <glib.h>
#include <nice/nice.h>

#pragma comment(lib, "ws2_32.lib")

#define SOCKET_BUFFER_SIZE		1024

#define STUN_SERVER "74.125.250.129"	// stun.l.google.com
#define STUN_PORT 19302


/**/
namespace fis {
	namespace details {

		/**/
		const char* CandidateTypeToString(NiceCandidateType type)
		{
			switch (type)
			{
			case NICE_CANDIDATE_TYPE_HOST:				return "host";
			case NICE_CANDIDATE_TYPE_SERVER_REFLEXIVE:	return "srflx";
			case NICE_CANDIDATE_TYPE_PEER_REFLEXIVE:	return "prflx";
			case NICE_CANDIDATE_TYPE_RELAYED:			return "relay";
			default:									return "unknown";
			}
		}

		/**/
		gchar* CandidateToStringManual(NiceCandidate* c)
		{
			gchar ipbuf[NICE_ADDRESS_STRING_LEN];
			nice_address_to_string(&c->addr, ipbuf);

			guint port = nice_address_get_port(&c->addr);

			return g_strdup_printf(
				"%s %u %s %u %s %u typ %s",
				c->foundation,
				c->component_id,
				nice_candidate_transport_to_string(c->transport),
				c->priority,
				ipbuf,
				port,
				nice_candidate_type_to_string(c->type)
			);
		}

		/**/
		std::string SockaddrToIPv4String(const sockaddr* sa)
		{
			char buf[INET_ADDRSTRLEN] = { 0 };
			if (sa && sa->sa_family == AF_INET) {
				const sockaddr_in* sin = reinterpret_cast<const sockaddr_in*>(sa);
				inet_ntop(AF_INET, &sin->sin_addr, buf, sizeof(buf));
				return std::string(buf);
			}
			return {};
		}

		/**/
		bool IsAdapterUsable(const IP_ADAPTER_ADDRESSES* aa)
		{
			if (aa->OperStatus != IfOperStatusUp)
			{
				return false;
			}
			if (aa->IfType == IF_TYPE_SOFTWARE_LOOPBACK)
			{
				return false;
			}
			// Skip tunnel/ppp if you want:
			// if (aa->IfType == IF_TYPE_PPP || aa->IfType == IF_TYPE_TUNNEL) return false;
			return true;
		}

		/**/
		bool IsUnicastUsable(const IP_ADAPTER_UNICAST_ADDRESS* ua)
		{
			if (!ua || !ua->Address.lpSockaddr)
			{
				return false;
			}

			const sockaddr* sa = ua->Address.lpSockaddr;
			if (sa->sa_family != AF_INET)
			{
				return false; // IPv4 only
			}

			const sockaddr_in* sin = reinterpret_cast<const sockaddr_in*>(sa);
			// Skip 127.0.0.0/8
			const uint8_t first = (ntohl(sin->sin_addr.s_addr) >> 24) & 0xFF;
			if (first == 127)
			{
				return false;
			}

			return true;
		}

		/**/
		std::vector<std::string> EnumerateLocalIPv4()
		{
			std::vector<std::string> result;

			ULONG flags = GAA_FLAG_SKIP_ANYCAST |
				GAA_FLAG_SKIP_MULTICAST |
				GAA_FLAG_SKIP_DNS_SERVER |
				GAA_FLAG_INCLUDE_PREFIX;
			ULONG family = AF_UNSPEC; // we will filter to AF_INET ourselves

			ULONG bufLen = 16 * 1024;
			std::unique_ptr<uint8_t[]> buffer(new uint8_t[bufLen]);

			DWORD ret = GetAdaptersAddresses(family, flags, nullptr,
				reinterpret_cast<IP_ADAPTER_ADDRESSES*>(buffer.get()), &bufLen);
			if (ret == ERROR_BUFFER_OVERFLOW)
			{
				buffer.reset(new uint8_t[bufLen]);
				ret = GetAdaptersAddresses(family, flags, nullptr,
					reinterpret_cast<IP_ADAPTER_ADDRESSES*>(buffer.get()), &bufLen);
			}
			if (ret != NO_ERROR)
			{
				std::cerr << "GetAdaptersAddresses failed: " << ret << std::endl;
				return result;
			}

			IP_ADAPTER_ADDRESSES* aa = reinterpret_cast<IP_ADAPTER_ADDRESSES*>(buffer.get());
			for (; aa; aa = aa->Next)
			{
				if (!IsAdapterUsable(aa))
				{
					continue;
				}

				for (IP_ADAPTER_UNICAST_ADDRESS* ua = aa->FirstUnicastAddress; ua; ua = ua->Next)
				{
					if (!IsUnicastUsable(ua))
					{
						continue;
					}

					std::string ip = SockaddrToIPv4String(ua->Address.lpSockaddr);
					if (!ip.empty())
					{
						result.push_back(ip);
					}
				}
			}

			return result;
		}

		/**/
		void AddLocalIPv4ToNice(NiceAgent* agent)
		{
			std::vector<std::string> ips = EnumerateLocalIPv4();
			if (ips.empty())
			{
				return;
			}

			for (const auto& ip : ips)
			{
				NiceAddress* addr = nice_address_new();
				struct in_addr ipv4_addr;

				if (inet_pton(AF_INET, ip.c_str(), &ipv4_addr) == 1)
				{
					nice_address_set_ipv4(addr, ntohl(ipv4_addr.s_addr));
					nice_agent_add_local_address(agent, addr);
				}
				else
				{
					g_warning("IPアドレスの変換に失敗しました");
				}
				nice_address_free(addr);
			}
		}

		/**/
		static gboolean QuitLoopIdle(gpointer data)
		{
			GMainLoop* loop = static_cast<GMainLoop*>(data);

			g_main_loop_quit(loop);
			return G_SOURCE_REMOVE;
		}
	}
}

/**/
class SocketUDP
{
public:
	typedef char						char_type;
	typedef std::vector<char_type>		buffer_type;

private:
	// GMainLoopスレッドに渡すためのデータを保持する構造体
	struct ApplyRemoteSDPData {
		SocketUDP* pThis;
		std::string* sdp_str;
	};

	// 送信データを保持する構造体
	struct SendDataData {
		SocketUDP* pThis;
		buffer_type* data_buf; // 送信データ
	};

public:
	/**/
	SocketUDP() :
		m_Agent(nullptr),
		m_StreamID(0),
		m_Gloop(nullptr),
		m_IsReady(FALSE),
		m_Tiebreaker(0),
		m_IsControlling(FALSE),
		m_Message(TJS_W("")),
		m_Receiving(false),
		m_Trigger(nullptr),
		m_ErrorTrigger(nullptr)
	{
		WSADATA wsaData;
		if (WSAStartup(MAKEWORD(2, 2), &wsaData) != 0) {
			// エラー処理 (致命的)
		}

		InitializeLibnice();
	};
	/**/
	virtual ~SocketUDP()
	{
		StopReceiveThread();

		if (m_Trigger)
		{
			m_Trigger->Release();
		}
		if (m_ErrorTrigger)
		{
			m_ErrorTrigger->Release();
		}

		Close();

		// Winsock の終了処理
		WSACleanup();
	};

	/**/
	void Close()
	{
		if (m_Gloop)
		{
			g_main_loop_unref(m_Gloop);
			m_Gloop = nullptr;
		}
		if (m_Agent)
		{
			g_object_unref(m_Agent);
			m_Agent = nullptr;
		}
	}

	/**/
	tjs_int Initialize()
	{
		// 候補収集開始
		if (!nice_agent_gather_candidates(m_Agent, m_StreamID)) {
			m_Message = "候補収集の開始に失敗しました。";
			return 1;
		}

		g_main_loop_run(m_Gloop);

		Trigger();

		return 0;
	}

	/**/
	void SetEventTrigger(iTJSDispatch2* obj)
	{
		m_Trigger = obj;
	};
	/**/
	void SetErrorEventTrigger(iTJSDispatch2* obj)
	{
		m_ErrorTrigger = obj;
	};

	/**/
	ttstr GetMessage() const
	{
		return m_Message;
	};

	/**/
	ttstr GetSDPString()
	{
		std::lock_guard<std::mutex> lock(m_Mutex);
		return m_SDP;
	}

	/**/
	tjs_int IsControlling() const
	{
		return m_IsControlling;
	}

	/*
	* GMainLoopスレッドで実行される静的コールバック
	*/
	static gboolean SendDataInvoke(gpointer user_data)
	{
		SendDataData* data = reinterpret_cast<SendDataData*>(user_data);
		SocketUDP* pThis = data->pThis;
		const buffer_type* buf = data->data_buf;

		gint sent_bytes = nice_agent_send(pThis->m_Agent, pThis->m_StreamID, 1, buf->size(), (const gchar*)buf->data());

		if (sent_bytes == -1)
		{
			// エラー処理（必要に応じて pThis->ErrorTrigger() を呼び出す）
			// ただし、ErrorTrigger() は GMainLoopスレッドから TJSスレッドへの呼び出しになるため、
			// 厳密なエラー通知設計が必要
		}

		// 後処理
		delete data->data_buf;
		delete data;

		return G_SOURCE_REMOVE;
	}

	/**/
	tjs_int SendData(const ttstr data)
	{
		// データの準備
		buffer_type* buf = new buffer_type(data.GetNarrowStrLen() + 1);
		data.ToNarrowStr(buf->data(), buf->size());

		// 構造体の準備
		SendDataData* send_data = new SendDataData();
		send_data->pThis = this;
		send_data->data_buf = buf;

		// GMainLoopが動作するスレッドへ処理を移譲
		g_main_context_invoke(
			g_main_loop_get_context(m_Gloop),
			SocketUDP::SendDataInvoke,
			send_data
		);

		return 0; // 送信要求は成功として即時リターン
	}

	/*
	* 受信データの取得
	*/
	ttstr PopReceivedData()
	{
		std::lock_guard<std::mutex> lock(m_Mutex); // 排他制御
		if (m_ReceivedQueue.empty())
		{
			return TJS_W("");
		}

		ttstr data = m_ReceivedQueue.front();
		m_ReceivedQueue.pop();
		return data;
	}

	/**/
	void ApplyRemoteSDP(const ttstr sdp_text)
	{
		buffer_type buf(sdp_text.GetNarrowStrLen() + 1);
		sdp_text.ToNarrowStr(buf.data(), buf.size());
		std::istringstream sdp_stream(buf.data());
		std::string line;
		gchar* ufrag = nullptr;
		gchar* pwd = nullptr;
		GSList* remote_candidates = nullptr;
		guint64 remote_tiebreaker = 0;

		// SDPの解析
		while (std::getline(sdp_stream, line))
		{
			if (line.find("ufrag=") == 0)
			{
				ufrag = g_strdup(line.substr(6).c_str());
			}
			else if (line.find("pwd=") == 0)
			{
				pwd = g_strdup(line.substr(4).c_str());
			}
			else if (line.find("tiebreaker=") == 0)
			{
				std::string val = line.substr(11);
				std::istringstream iss(val);
				iss >> remote_tiebreaker;
			}
			else if (line.find("candidate=") == 0)
			{
				std::istringstream cand_stream(line.substr(10));
				std::string foundation, transport_str, ip_str, type_str;
				guint component_id, priority, port;

				cand_stream >> foundation >> component_id >> transport_str >> priority >> ip_str >> port >> std::ws;
				std::string typ_label;
				cand_stream >> typ_label >> type_str;

				NiceCandidateType type = NICE_CANDIDATE_TYPE_HOST;
				if (type_str == "srflx")
				{
					type = NICE_CANDIDATE_TYPE_SERVER_REFLEXIVE;
				}
				else if (type_str == "prflx")
				{
					type = NICE_CANDIDATE_TYPE_PEER_REFLEXIVE;
				}
				else if (type_str == "relay")
				{
					type = NICE_CANDIDATE_TYPE_RELAYED;
				}


				NiceCandidateTransport transport = NICE_CANDIDATE_TRANSPORT_UDP;
				if (transport_str == "tcp-act")
				{
					transport = NICE_CANDIDATE_TRANSPORT_TCP_ACTIVE;
				}
				else if (transport_str == "tcp-pass")
				{
					transport = NICE_CANDIDATE_TRANSPORT_TCP_PASSIVE;
				}

				NiceCandidate* rcand = nice_candidate_new(type);
				rcand->component_id = component_id;
				rcand->stream_id = m_StreamID;
				rcand->transport = transport;
				rcand->priority = priority;
				strncpy_s(rcand->foundation, NICE_CANDIDATE_MAX_FOUNDATION, foundation.c_str(), _TRUNCATE);
				rcand->foundation[NICE_CANDIDATE_MAX_FOUNDATION - 1] = '\0';

				NiceAddress addr;
				if (nice_address_set_from_string(&addr, ip_str.c_str()))
				{
					nice_address_set_port(&addr, port);
					rcand->addr = addr;
					remote_candidates = g_slist_prepend(remote_candidates, rcand);
				}
				else
				{
					g_warning("IPアドレスのパースに失敗しました: %s", ip_str.c_str());
					nice_candidate_free(rcand);
				}
			}
		}

		bool is_controlling = (m_Tiebreaker > remote_tiebreaker);
		g_object_set(G_OBJECT(m_Agent), "controlling-mode", is_controlling ? TRUE : FALSE, nullptr);
		m_IsControlling = is_controlling;

		remote_candidates = g_slist_reverse(remote_candidates);

		// libnice APIの呼び出しを GMainLoopスレッドで行う (スレッドセーフ)
		if (ufrag && pwd) {
			nice_agent_set_remote_credentials(m_Agent, m_StreamID, ufrag, pwd);
		}

		if (remote_candidates) {
			gint accepted = nice_agent_set_remote_candidates(m_Agent, m_StreamID, 1, remote_candidates);
			if (!accepted)
			{
				TVPThrowExceptionMessage(TJS_W("nice_agent_set_remote_candidatesがfalseを返しました。"));
			}
			g_print("リモート候補を %d 件設定しました。\n", accepted);
		}

		// 後処理
		g_slist_free_full(remote_candidates, (GDestroyNotify)nice_candidate_free);
		g_free(ufrag);
		g_free(pwd);

		g_main_loop_run(m_Gloop);

		Trigger();
	}

	/*
	* 受信スレッドの開始
	*/
	tjs_int StartReceiveThread()
	{
		if (m_Receiving)
		{
			return 1;
		}

		m_Receiving = true;
		m_ReceiveThread = std::thread(&SocketUDP::ReceiveLoop, this);

		return 0;
	}

	/*
	* 受信スレッドの停止
	*/
	void StopReceiveThread()
	{
		if (m_Receiving)
		{
			m_Receiving = false; // ループ終了フラグを設定

			// GMainLoopを停止させる（スレッドの正常終了のため）
			if (m_Gloop)
			{
				// 別スレッドから g_main_loop_quit を呼び出すのはスレッドセーフ
				g_main_loop_quit(m_Gloop);
			}

			// スレッドが有効な場合、joinして終了を待つ
			if (m_ReceiveThread.joinable())
			{
				m_ReceiveThread.join();
			}
		}
	}

	/**/
	static void NiceComponentStateChangedCB(NiceAgent* agent,
		guint stream_id,
		guint component_id,
		guint state,
		gpointer user_data)
	{
		SocketUDP* pThis = reinterpret_cast<SocketUDP*>(user_data);
		NiceComponentState comp_state = (NiceComponentState)state;
		GMainContext* ctx = g_main_loop_get_context(pThis->m_Gloop);
		tjs_char buf[256];

		switch (comp_state) {
		case NICE_COMPONENT_STATE_DISCONNECTED: break;
		case NICE_COMPONENT_STATE_GATHERING: break;
		case NICE_COMPONENT_STATE_CONNECTING: break;
		case NICE_COMPONENT_STATE_READY:
			pThis->m_IsReady = TRUE;

			// コンテキストに quit をスケジュール
			g_main_context_invoke(ctx, fis::details::QuitLoopIdle, pThis->m_Gloop);
			g_main_loop_quit(pThis->m_Gloop);
			break;
		case NICE_COMPONENT_STATE_FAILED:
			pThis->m_IsReady = FALSE;
			pThis->m_Message = TJS_W("状態がFAILEDになりました。");
			g_main_loop_quit(pThis->m_Gloop);
			// エラーイベント発射
			pThis->ErrorTrigger();
			break;
		}
	}

	/**/
	static void NiceRecvCB(NiceAgent* agent, guint stream_id, guint component_id, guint len, gchar* buf, gpointer user_data)
	{
		SocketUDP* pThis = reinterpret_cast<SocketUDP*>(user_data);
		ttstr received_msg(buf, len);

		{
			std::lock_guard<std::mutex> lock(pThis->m_Mutex);
			pThis->m_ReceivedQueue.push(received_msg);
		}

		// 受信イベント発射
		pThis->Trigger();
	}

	/**/
	static void NiceGatheringDone(NiceAgent* agent, guint stream_id, gpointer user_data)
	{
		SocketUDP* pThis = reinterpret_cast<SocketUDP*>(user_data);
		// 資格情報（ufrag/pwd）
		gchar* ufrag = NULL, * pwd = NULL;
		nice_agent_get_local_credentials(agent, stream_id, &ufrag, &pwd);

		// ローカル候補一覧を取得
		GSList* cands = nice_agent_get_local_candidates(agent, stream_id, 1); // component=1

		// 送信用ペイロードを組み立て（テキストでOK）
		GString* payload = g_string_new(NULL);
		g_string_append_printf(payload, "ufrag=%s\npwd=%s\n", ufrag, pwd);

		g_string_append_printf(payload, "tiebreaker=%" G_GUINT64_FORMAT "\n", pThis->m_Tiebreaker);

		for (GSList* l = cands; l; l = l->next) {
			NiceCandidate* c = (NiceCandidate*)l->data;
			gchar* cand_str = fis::details::CandidateToStringManual(c);
			g_string_append_printf(payload, "candidate=%s\n", cand_str);
			g_free(cand_str);
		}

		{
			std::lock_guard<std::mutex> lock(pThis->m_Mutex);
			pThis->m_SDP = ttstr(payload->str);
		}

		g_string_free(payload, TRUE);
		g_slist_free_full(cands, (GDestroyNotify)nice_candidate_free);
		g_free(ufrag);
		g_free(pwd);

		g_main_loop_quit(pThis->m_Gloop);
	}

private:
	/**/
	tjs_int InitializeLibnice()
	{
		m_Gloop = g_main_loop_new(nullptr, FALSE);

		m_Agent = nice_agent_new(g_main_loop_get_context(m_Gloop), NICE_COMPATIBILITY_RFC5245);
		if (!m_Agent) {
			m_Message = "NiceAgent の作成に失敗しました。";
			return 1;
		}

		// ローカルIPをlibniceに伝える
		fis::details::AddLocalIPv4ToNice(m_Agent);

		// STUNサーバー設定
		g_object_set(G_OBJECT(m_Agent), "stun-server", STUN_SERVER, "stun-server-port", STUN_PORT, nullptr);

		// tiebreaker をランダムに生成
		guint64 tiebreaker = ((guint64)g_random_int() << 32) | g_random_int();
		m_Tiebreaker = tiebreaker;

		// controlling-mode は仮に TRUE（後で上書きする）
		g_object_set(G_OBJECT(m_Agent), "controlling-mode", TRUE, "ice-tiebreaker", tiebreaker, nullptr);

		// シグナル接続
		g_signal_connect(m_Agent, "component-state-changed", G_CALLBACK(SocketUDP::NiceComponentStateChangedCB), this);
		g_signal_connect(m_Agent, "candidate-gathering-done", G_CALLBACK(SocketUDP::NiceGatheringDone), this);

		// ストリーム追加
		m_StreamID = nice_agent_add_stream(m_Agent, 1);
		nice_agent_set_stream_name(m_Agent, m_StreamID, "application");

		// 受信コールバック
		nice_agent_attach_recv(m_Agent, m_StreamID, 1, g_main_loop_get_context(m_Gloop), SocketUDP::NiceRecvCB, this);

		return 0;
	}

	/*
	* 受信ループ
	*/
	void ReceiveLoop()
	{
		// g_main_loop_run はブロッキング処理
		g_main_loop_run(m_Gloop);
		// ループが終了（g_main_loop_quitが呼ばれた）場合、スレッドはここで終了する
	}

	/**/
	void Trigger()
	{
		// 受信イベント発射
		tTJSVariant result;
		tjs_error hr = m_Trigger->FuncCall(
			0,						// フラグ (TJS_MEMBERENSURE などは不要、単なる関数呼び出しのため 0)
			TJS_W("trigger"),		// 呼び出すメソッド名
			nullptr,				// ヒント (通常 nullptr)
			&result,				// 戻り値を受け取るバリアント
			0,						// 引数の数
			nullptr,				// 引数配列
			m_Trigger				// objthis
		);

		if (TJS_FAILED(hr))
		{
			m_Message = TJS_W("m_Trigger.trigger() failed.");
		}
	}

	/**/
	void ErrorTrigger()
	{
		tTJSVariant result;
		tjs_error hr = m_ErrorTrigger->FuncCall(
			0,						// フラグ (TJS_MEMBERENSURE などは不要、単なる関数呼び出しのため 0)
			TJS_W("trigger"),		// 呼び出すメソッド名
			nullptr,				// ヒント (通常 nullptr)
			&result,				// 戻り値を受け取るバリアント
			0,						// 引数の数
			nullptr,				// 引数配列
			m_ErrorTrigger	// objthis
		);

		if (TJS_FAILED(hr))
		{
			m_Message = TJS_W("m_ErrorTrigger.trigger() failed.");
		}
	}

private:
	NiceAgent* m_Agent;
	guint m_StreamID;
	GMainLoop* m_Gloop;
	gboolean m_IsReady;

	guint64 m_Tiebreaker;
	gboolean m_IsControlling;

	std::thread m_ReceiveThread;
	std::mutex m_Mutex;
	std::queue<ttstr> m_ReceivedQueue;	// 受信データを格納するキュー
	volatile bool m_Receiving;			// 受信ループの継続フラグ
	ttstr m_SDP;

	ttstr m_Message;

	iTJSDispatch2* m_Trigger;
	iTJSDispatch2* m_ErrorTrigger;
};

/**/
NCB_REGISTER_CLASS(SocketUDP)
{
	Constructor();

	Method("initialize", &Class::Initialize);
	Method("close", &Class::Close);

	Method("setEventTrigger", &Class::SetEventTrigger);
	Method("setErrorEventTrigger", &Class::SetErrorEventTrigger);

	Method("getSDPString", &Class::GetSDPString);
	Method("applyRemoteSDP", &Class::ApplyRemoteSDP);

	Method("startReceiveThread", &Class::StartReceiveThread);
	Method("stopReceiveThread", &Class::StopReceiveThread);

	Method("sendData", &Class::SendData);
	Method("popReceivedData", &Class::PopReceivedData);

	Property("message", &Class::GetMessage, 0);
	Property("isControlling", &Class::IsControlling, 0);
};


