/*
*/

#include <winsock2.h>
#include <ws2tcpip.h>
#include <thread>
#include <mutex>
#include <functional>
#include <vector>
#include <queue>
#include "ncbind.hpp"
#include "kim/KimException.h"

#pragma comment(lib, "ws2_32.lib")

#define SOCKET_BUFFER_SIZE		1024


/**/
namespace bm88 {
	namespace details {
	}
}

/**/
class SocketUDP
{
public:
	typedef char						char_type;
	typedef std::vector<char_type>		buffer_type;

public:
	/**/
	SocketUDP() :
		m_Socket(INVALID_SOCKET),
		m_Message(TJS_W("")),
		m_Receiving(false),
		m_Trigger(nullptr),
		m_ErrorTrigger(nullptr)
	{
		InitializeWinsock();
	};
	/**/
	virtual ~SocketUDP()
	{
		StopReceiveThread();
		Close();
		CleanupWinsock();
	};

	/*
	* ソケットのクローズ
	*/
	void Close()
	{
		if (m_Socket != INVALID_SOCKET)
		{
			closesocket(m_Socket);
			m_Socket = INVALID_SOCKET;
		}
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
	ttstr GetOpponentIP() const
	{
		return m_OpponentIP;
	};

	/**/
	tjs_int GetOpponentPort() const
	{
		return m_OpponentPort;
	};

	/*
	* 接続待機用ソケットを作成する
	*/
	tjs_int BindSocket(tjs_int port)
	{
		// ソケットの作成
		m_Socket = socket(AF_INET, SOCK_DGRAM, IPPROTO_UDP);
		if (m_Socket == INVALID_SOCKET)
		{
			m_Message = TJS_W("socker() failed. last error : ");
			m_Message += std::to_wstring(WSAGetLastError()).c_str();

			return 1;
		}

		// アドレス構造体の設定
		m_LocalAddr.sin_family = AF_INET;
		m_LocalAddr.sin_port = htons(port);
		m_LocalAddr.sin_addr.s_addr = INADDR_ANY; // すべてのインターフェースからの接続を許可

		// ソケットをアドレスにバインド
		if (bind(m_Socket, (SOCKADDR*)&m_LocalAddr, sizeof(m_LocalAddr)) == SOCKET_ERROR)
		{
			m_Message = TJS_W("bind() failed. last error : ");
			m_Message += std::to_wstring(WSAGetLastError()).c_str();

			Close();

			return 1;
		}

		return 0;
	}

	/*
	* 対戦相手のアドレスを設定
	*/
	tjs_int SetRemoteAddress(const ttstr ip, tjs_int port)
	{
		buffer_type buf(ip.GetNarrowStrLen());

		ip.ToNarrowStr(buf.data(), buf.size());

		m_RemoteAddr.sin_family = AF_INET;
		m_RemoteAddr.sin_port = htons(port);

		// IPアドレスを文字列からバイナリ形式に変換
		int result = inet_pton(AF_INET, buf.data(), &m_RemoteAddr.sin_addr);
		// 1が成功
		if (result != 1)
		{
			m_Message = TJS_W("inet_pton() failed.");
			return 1;
		}

		return 0;
	}

	/*
	* データの送信
	*/
	tjs_int SendData(const ttstr data)
	{
		buffer_type buf(data.GetNarrowStrLen());

		data.ToNarrowStr(buf.data(), buf.size());

		int bytesSent = sendto(
			m_Socket,
			buf.data(),
			(int)buf.size(),
			0,
			(SOCKADDR*)&m_RemoteAddr,
			sizeof(m_RemoteAddr)
		);

		if (bytesSent == SOCKET_ERROR)
		{
			m_Message = TJS_W("sendto() failed. last error : ");
			m_Message += std::to_wstring(WSAGetLastError()).c_str();

			return 1;
		}

		return 0;
	}

	/*
	* データの受信
	*/
	ttstr ReceiveData(int timeout_ms = 0)
	{
		buffer_type buf(SOCKET_BUFFER_SIZE);
		sockaddr_in senderAddr;
		int senderAddrSize = sizeof(senderAddr);

		// 受信タイムアウトの設定
		if (timeout_ms > 0)
		{
			DWORD timeout = timeout_ms;
			setsockopt(m_Socket, SOL_SOCKET, SO_RCVTIMEO, (const char*)&timeout, sizeof(timeout));
		}

		int bytesReceived = recvfrom(
			m_Socket,
			buf.data(),
			SOCKET_BUFFER_SIZE - 1,
			0,
			(SOCKADDR*)&senderAddr,
			&senderAddrSize
		);

		// タイムアウト設定をクリアするかどうかは環境によるが、ここではスレッドループ用に残す
		// setsockopt(m_Socket, SOL_SOCKET, SO_RCVTIMEO, nullptr, 0);

		if (bytesReceived == SOCKET_ERROR)
		{
			int error = WSAGetLastError();
			if (error == WSAETIMEDOUT)
			{
				// タイムアウト
				return "";
			}

			m_Message = TJS_W("recvfrom failed. last error : ");
			m_Message += std::to_wstring(error).c_str();

			return "";
		}

		buf.push_back('\0');

		return ttstr(buf.data());
	}

	/*
	* 受信スレッドの開始
	*/
	tjs_int StartReceiveThread()
	{
		if (m_Socket == INVALID_SOCKET || m_Receiving)
		{
			return 1;
		}

		// 受信ループを抜けるためのタイムアウトを設定（ポーリング的に動作させる）
		DWORD timeout = 100; // 100ms
		if (setsockopt(m_Socket, SOL_SOCKET, SO_RCVTIMEO, (const char*)&timeout, sizeof(timeout)) == SOCKET_ERROR)
		{
			m_Message = TJS_W("setsockopt failed for SO_RCVTIMEO. last error : ");
			m_Message += std::to_wstring(WSAGetLastError()).c_str();
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

			// スレッドが有効な場合、joinして終了を待つ
			if (m_ReceiveThread.joinable())
			{
				m_ReceiveThread.join();
			}
		}
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
	/*
	* Winsock の初期化処理
	*/
	bool InitializeWinsock()
	{
		WSADATA wsaData;
		int result = WSAStartup(MAKEWORD(2, 2), &wsaData);

		if (result != 0)
		{
			m_Message = TJS_W("WSAStartup failed. result : ");
			m_Message += std::to_wstring(result).c_str();

			return false;
		}

		return true;
	}

	/*
	* 受信ループ
	*/
	void ReceiveLoop()
	{
		// IPアドレス変換用バッファ
		char ipStringBuffer[INET_ADDRSTRLEN];

		while (m_Receiving)
		{
			// ReceiveData (同期処理) とほぼ同じ処理
			buffer_type buf(SOCKET_BUFFER_SIZE);
			sockaddr_in senderAddr;
			int senderAddrSize = sizeof(senderAddr);

			int bytesReceived = recvfrom(
				m_Socket,
				buf.data(),
				SOCKET_BUFFER_SIZE - 1,
				0,
				(SOCKADDR*)&senderAddr,
				&senderAddrSize
			);

			if (bytesReceived > 0)
			{
				// IPアドレスをバイナリ形式から文字列形式に変換
				const char* ipResult = inet_ntop(
					AF_INET,
					&senderAddr.sin_addr,
					ipStringBuffer,
					INET_ADDRSTRLEN
				);

				// ポート番号を取得 (ネットワークバイトオーダーからホストバイトオーダーへ変換)
				tjs_int port = ntohs(senderAddr.sin_port);

				ttstr senderIpStr;
				if (ipResult != nullptr) {
					senderIpStr = ttstr(ipResult);
				}
				else {
					senderIpStr = TJS_W("Unknown IP");
				}

				// データを受信
				buf.resize(bytesReceived);
				buf.push_back('\0'); // ヌル終端

				// 受信キューにデータを格納（排他制御が必要）
				std::lock_guard<std::mutex> lock(m_Mutex);
				m_ReceivedQueue.push(ttstr(buf.data()));

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
			else if (bytesReceived == SOCKET_ERROR)
			{
				int error = WSAGetLastError();
				if (error != WSAETIMEDOUT && error != WSAEINTR)
				{
					// タイムアウト以外のエラーが発生
					// エラー処理（ログ記録など）を行い、ループを抜ける
					m_Message = TJS_W("receiveLoop failed. last error : ");
					m_Message += std::to_wstring(error).c_str();
					m_Receiving = false;

					// エラーイベント発射
					tTJSVariant result;
					tjs_error hr = m_ErrorTrigger->FuncCall(
						0,						// フラグ (TJS_MEMBERENSURE などは不要、単なる関数呼び出しのため 0)
						TJS_W("trigger"),		// 呼び出すメソッド名
						nullptr,				// ヒント (通常 nullptr)
						&result,				// 戻り値を受け取るバリアント
						0,						// 引数の数
						nullptr,				// 引数配列
						m_ErrorTrigger			// objthis
					);

					if (TJS_FAILED(hr))
					{
						m_Message = TJS_W("m_ErrorTrigger.trigger() failed.");
					}
				}
				// タイムアウト(WSAETIMEDOUT)または中断(WSAEINTR)の場合はループを継続
			}
		}
	}

	/*
	* Winsock のクリーンアップ処理
	*/
	void CleanupWinsock()
	{
		WSACleanup();
	}

private:
	SOCKET m_Socket;
	sockaddr_in m_LocalAddr;
	sockaddr_in m_RemoteAddr;			// 対戦相手のアドレス

	std::thread m_ReceiveThread;
	std::mutex m_Mutex;
	std::queue<ttstr> m_ReceivedQueue;	// 受信データを格納するキュー
	volatile bool m_Receiving;			// 受信ループの継続フラグ

	ttstr m_OpponentIP;					// データを送信してきた相手のIP
	tjs_int m_OpponentPort;				// 同ポート番号

	ttstr m_Message;

	iTJSDispatch2* m_Trigger;
	iTJSDispatch2* m_ErrorTrigger;
};

/**/
NCB_REGISTER_CLASS(SocketUDP)
{
	Constructor();

	Method("close", &Class::Close);

	Method("setEventTrigger", &Class::SetEventTrigger);
	Method("setErrorEventTrigger", &Class::SetErrorEventTrigger);

	Method("bindSocket", &Class::BindSocket);
	Method("setRemoteAddress", &Class::SetRemoteAddress);

	Method("sendData", &Class::SendData);
	Method("receiveData", &Class::ReceiveData);

	Method("startReceiveThread", &Class::StartReceiveThread);
	Method("stopReceiveThread", &Class::StopReceiveThread);

	Method("popReceivedData", &Class::PopReceivedData);

	Property("message", &Class::GetMessage, 0);

	Property("opponentIP", &Class::GetOpponentIP, 0);
	Property("opponentPort", &Class::GetOpponentPort, 0);
};


