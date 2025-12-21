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
#include <optional>
#include <string>
#include <variant>
#include "ncbind.hpp"
#include "kim/KimException.h"

#include <rtc/rtc.hpp>

#define SOCKET_BUFFER_SIZE		1024

#define STUN_SERVER		"stun:stun.l.google.com:19302"

#define TURN_SERVER		""
#define TURN_USERNAME	""
#define TURN_PASSWORD	""


/**/
namespace fis {
	namespace details {
	}
}

/**/
class SocketUDP
{
public:
	typedef char						char_type;
	typedef std::vector<char_type>		buffer_type;

	// 状態を管理するための列挙型（TJS側に返す用）
	enum class ConnectionState {
		Disconnected = 0,
		Connecting = 1,
		Connected = 2,
		Failed = 3
	};

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
		m_Message(TJS_W("")),
		m_Receiving(false),
		m_ConnectState(ConnectionState::Disconnected),
		m_Trigger(nullptr),
		m_StatusChangeTrigger(nullptr),
		m_ErrorTrigger(nullptr)
	{
	};
	/**/
	virtual ~SocketUDP()
	{
	};

	/**/
	void Close()
	{
	}

	/**/
	tjs_int Initialize()
	{
		try {
			rtc::Configuration config;
			config.iceServers.emplace_back(STUN_SERVER);
			rtc::IceServer turn(TURN_SERVER);
			turn.username = TURN_USERNAME;
			turn.password = TURN_PASSWORD;
			config.iceServers.push_back(turn);

			m_PeerConnection = std::make_shared<rtc::PeerConnection>(config);

			// --- コールバック設定 ---

			// 全てのICE候補が集まったら、SDPを確定させる
			m_PeerConnection->onLocalDescription([this](rtc::Description description) {
				std::lock_guard<std::mutex> lock(m_Mutex);
				m_SDP = ttstr(std::string(description).c_str());
				// 通知はまだ保留
			});

			// ICE 候補の収集状態を監視する
			m_PeerConnection->onGatheringStateChange([this](rtc::PeerConnection::GatheringState state) {
				if (state == rtc::PeerConnection::GatheringState::Complete) {
					// 全ての候補が集まった！
					auto description = m_PeerConnection->localDescription();
					if (description) {
						std::lock_guard<std::mutex> lock(m_Mutex);
						m_SDP = ttstr(std::string(*description).c_str());
					}

					// TJSへ通知
					Trigger();
				}
			});

			// ICEの状態変化（デバッグ用）
			m_PeerConnection->onStateChange([](rtc::PeerConnection::State state) {
				// std::cout << "State: " << state << std::endl;
			});

			// 相手からDataChannelが送られてきた場合（受け側）
			m_PeerConnection->onDataChannel([this](std::shared_ptr<rtc::DataChannel> dc) {
				SetupDataChannel(dc);
			});

			// PeerConnectionの接続状態を監視
			m_PeerConnection->onStateChange([this](rtc::PeerConnection::State state) {
				std::lock_guard<std::mutex> lock(m_Mutex);
				switch (state) {
				case rtc::PeerConnection::State::Connected:
					m_ConnectState = ConnectionState::Connected;
					break;
				case rtc::PeerConnection::State::Failed:
				case rtc::PeerConnection::State::Closed:
					m_ConnectState = ConnectionState::Disconnected;
					break;
				default:
					m_ConnectState = ConnectionState::Connecting;
					break;
				}
				// 状態が変わったことをTJSに通知したい場合はここで Trigger() を呼ぶ
				StatusChangeTrigger();
			});

			// 自分からDataChannelを作成（攻め側・Offer側）
			// DataChannelの名前は任意
			auto dc = m_PeerConnection->createDataChannel("SocketUDP");
			SetupDataChannel(dc);

			return 0;
		}
		catch (const std::exception& e) {
			m_Message = ttstr(e.what());
			return -1;
		}
	}

	/**/
	void SetEventTrigger(iTJSDispatch2* obj)
	{
		m_Trigger = obj;
	};
	/**/
	void SetStatusChangeEventTrigger(iTJSDispatch2* obj)
	{
		m_StatusChangeTrigger = obj;
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

	/* TJS側から現在の状態を取得するためのメソッド */
	tjs_int GetConnectionState()
	{
		std::lock_guard<std::mutex> lock(m_Mutex);
		return static_cast<tjs_int>(m_ConnectState);
	}

	/**/
	ttstr GetSDPString()
	{
		std::lock_guard<std::mutex> lock(m_Mutex);
		return m_SDP;
	}

	/**/
	void SetupDataChannel(std::shared_ptr<rtc::DataChannel> dc)
	{
		m_DataChannel = dc;

		m_DataChannel->onMessage([this](rtc::message_variant data) {
			std::lock_guard<std::mutex> lock(m_Mutex);
			if (std::holds_alternative<std::string>(data)) {
				m_ReceivedQueue.push(ttstr(std::get<std::string>(data).c_str()));
			}
			// データが届いたことを通知
			Trigger();
		});

		m_DataChannel->onOpen([this]() {
			m_Message = TJS_W("DataChannel Opened");
		});
	}

	/**/
	tjs_int SetRemoteSDP(ttstr sdp)
	{
		if (!m_PeerConnection) return -1;
		try {
			buffer_type* buf = new buffer_type(sdp.GetNarrowStrLen() + 1);
			sdp.ToNarrowStr(buf->data(), buf->size());
			std::string sdp_str = buf->data();
			m_PeerConnection->setRemoteDescription(rtc::Description(sdp_str));
			return 0;
		}
		catch (const std::exception& e) {
			m_Message = ttstr(e.what());
			return -1;
		}
	}

	/**/
	tjs_int SendData(const ttstr data)
	{
		if (m_DataChannel && m_DataChannel->isOpen()) {
			buffer_type* buf = new buffer_type(data.GetNarrowStrLen() + 1);
			data.ToNarrowStr(buf->data(), buf->size());

			m_DataChannel->send(buf->data());

			return 0;
		}

		return -1; // まだ接続されていない
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

private:
	/**/
	void Trigger()
	{
		if (m_Trigger)
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
	}

	/**/
	void StatusChangeTrigger()
	{
		if (m_StatusChangeTrigger)
		{
			// 受信イベント発射
			tTJSVariant result;
			tjs_error hr = m_StatusChangeTrigger->FuncCall(
				0,						// フラグ (TJS_MEMBERENSURE などは不要、単なる関数呼び出しのため 0)
				TJS_W("trigger"),		// 呼び出すメソッド名
				nullptr,				// ヒント (通常 nullptr)
				&result,				// 戻り値を受け取るバリアント
				0,						// 引数の数
				nullptr,				// 引数配列
				m_StatusChangeTrigger	// objthis
			);

			if (TJS_FAILED(hr))
			{
				m_Message = TJS_W("m_StatusChangeTrigger.trigger() failed.");
			}
		}
	}

	/**/
	void ErrorTrigger()
	{
		if (m_ErrorTrigger)
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
	}

private:
	std::shared_ptr<rtc::PeerConnection> m_PeerConnection;
	std::shared_ptr<rtc::DataChannel> m_DataChannel;

	ConnectionState m_ConnectState;

	std::thread m_ReceiveThread;
	std::mutex m_Mutex;
	std::queue<ttstr> m_ReceivedQueue;	// 受信データを格納するキュー
	volatile bool m_Receiving;			// 受信ループの継続フラグ
	ttstr m_SDP;

	ttstr m_Message;

	iTJSDispatch2* m_Trigger;
	iTJSDispatch2* m_StatusChangeTrigger;
	iTJSDispatch2* m_ErrorTrigger;
};

/**/
NCB_REGISTER_CLASS(SocketUDP)
{
	Constructor();

	Method("initialize", &Class::Initialize);
	Method("close", &Class::Close);

	Method("setEventTrigger", &Class::SetEventTrigger);
	Method("setStatusChangeEventTrigger", &Class::SetStatusChangeEventTrigger);
	Method("setErrorEventTrigger", &Class::SetErrorEventTrigger);

	Method("getSDPString", &Class::GetSDPString);
	Method("setRemoteSDP", &Class::SetRemoteSDP);

	Method("sendData", &Class::SendData);
	Method("popReceivedData", &Class::PopReceivedData);

	Property("message", &Class::GetMessage, 0);
};


