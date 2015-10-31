/**
 * $Revision: 144 $
**/


#include"ncbind.hpp"
#include"Kim/KimException.h"
#include<vector>


/**/
namespace bm88 {
	namespace helper {

		/**/
		inline
		tjs_nchar* ToLegacyString(const ttstr &str, std::vector<tjs_nchar> &buf)
		{
			if(str.IsEmpty())
				return "";
			buf.resize(str.GetNarrowStrLen() + 1);
			str.ToNarrowStr(&buf[0], buf.size());
			return &buf[0];
		};

	};

	namespace details {

		/**/
		template<class T> inline
		void RegistGlobalValue(iTJSDispatch2 *global_ptr, tjs_char* member_name, T value)
		{
			tTJSVariant val = value;

			global_ptr->PropSet(
				TJS_MEMBERENSURE,	// メンバがなかった場合には作成するようにするフラグ
				member_name,		// メンバ名 ( かならず TJS_W( ) で囲む )
				NULL,				// ヒント ( 本来はメンバ名のハッシュ値だが、NULL でもよい )
				&val,				// 登録する値
				global_ptr			// コンテキスト ( global でよい )
			);
			val.Clear();
		};

		/**/
		inline
		DWORD RegValueType(HKEY key, const ttstr &name)
		{
			DWORD type;
			LONG res = RegQueryValueEx(key, name.c_str(), NULL, &type, NULL, NULL);
			switch(res)
			{
			case ERROR_SUCCESS:			break;
			case ERROR_FILE_NOT_FOUND:	return REG_NONE;
			default:
				ttstr msg(TJS_W("RegValueType(\""));
				msg += name;
				msg += TJS_W("\")");
				TVPThrowExceptionMessage(msg.c_str());
				break;
			}
			return type;
		}

		/**/
		inline
		DWORD RegReadValue(HKEY key, const ttstr &name, BYTE *buffer, DWORD size)
		{
			LONG res = RegQueryValueEx(key, name.c_str(), NULL, NULL, buffer, &size);
			switch(res)
			{
			case ERROR_SUCCESS:			break;
			case ERROR_FILE_NOT_FOUND:	return 0;
			case ERROR_MORE_DATA:
			default:
				ttstr msg(TJS_W("RegReadValue(\""));
				msg += name;
				msg += TJS_W("\")");
				TVPThrowExceptionMessage(msg.c_str());
				break;
			}
			return size;
		};

		/**/
		inline
		void RegReadValueDoubleWord(HKEY key, const ttstr &name, tTJSVariant &var)
		{
			DWORD data = 0;

			if(RegReadValue(key, name, reinterpret_cast<BYTE*>(&data), sizeof(DWORD)) == sizeof(DWORD))
				var = static_cast<tjs_int32>(data);
			else
				var.Clear();
		};

		/**/
		inline
		void RegReadValueString(HKEY key, const ttstr &name, tTJSVariant &var, tjs_uint maxsize)
		{
			std::vector<tjs_nchar> buf(maxsize + 1);

			if(RegReadValue(key, name, reinterpret_cast<BYTE*>(&buf[0]), maxsize + 1) == 0)
				var.Clear();
			else
				var = ttstr(&buf[0]);
		};

		/**/
		inline
		void RegWriteValue(HKEY key, const ttstr &name, const BYTE *buffer, DWORD type, DWORD size)
		{
			if(RegSetValueEx(key, name.c_str(), 0, type, buffer, size) != ERROR_SUCCESS)
				TVPThrowExceptionMessage(TJS_W("RegSetValueEx() 失敗。"));
		};

		/**/
		inline
		void RegWriteValueDoubleWord(HKEY key, const ttstr &name, const DWORD buffer)
		{
			RegWriteValue(key, name, reinterpret_cast<BYTE*>(buffer), REG_DWORD, sizeof(DWORD));
		};

		/**/
		inline
		void RegWriteValueString(HKEY key, const ttstr &name, const ttstr &buffer)
		{
			RegWriteValue(
				key,
				name,
				reinterpret_cast<const BYTE*>(buffer.c_str()),
				REG_SZ,
				buffer.GetNarrowStrLen()
			);
		};

	};
};

/**/
void RegistRegistoryClassConstantValue()
{
	iTJSDispatch2* p = TVPGetScriptDispatch();

	bm88::details::RegistGlobalValue(p, TJS_W("HKLM"), reinterpret_cast<tjs_int32>(HKEY_LOCAL_MACHINE));
	bm88::details::RegistGlobalValue(p, TJS_W("HKCR"), reinterpret_cast<tjs_int32>(HKEY_CLASSES_ROOT));
	bm88::details::RegistGlobalValue(p, TJS_W("HKUR"), reinterpret_cast<tjs_int32>(HKEY_USERS));
	bm88::details::RegistGlobalValue(p, TJS_W("HKCU"), reinterpret_cast<tjs_int32>(HKEY_CURRENT_USER));
	bm88::details::RegistGlobalValue(p, TJS_W("HKCC"), reinterpret_cast<tjs_int32>(HKEY_CURRENT_CONFIG));

	p->Release();
}

/**/
class RegistoryKey
{
	typedef std::vector<tjs_nchar>	buffer_type;

public:
	RegistoryKey(tjs_int root, ttstr SubkeyPath) :
		m_root(reinterpret_cast<HKEY>(root)),
		m_path(SubkeyPath),
		m_key(NULL)
	{
		NCB_LOG_2(SubkeyPath, TJS_W(" RegistoryKey initialized."));
	};
	virtual
	~RegistoryKey()
	{
		Close();
	};

	tTJSVariant Read(ttstr ValueName);
	void Write(ttstr ValueName, tTJSVariant Value);

	ttstr GetSubkeyPath() const
	{
		return m_path;
	};

private:
	/**/
	void Open()
	{
		if(Opened())
			return;

		if(RegOpenKeyEx(m_root, m_path.c_str(), /* reserved */0, KEY_ALL_ACCESS, &m_key) == ERROR_SUCCESS)
			InitKeyInfo();
	};
	/**/
	bool Create()
	{
		if(Opened())
			return false;

		DWORD disp;
		LONG res = RegCreateKeyEx(
			m_root,
			m_path.c_str(),
			0, /* reserved */
			NULL,
			REG_OPTION_NON_VOLATILE,
			KEY_ALL_ACCESS,
			NULL,
			&m_key,
			&disp
		);
		if(res != ERROR_SUCCESS)
		{
			TVPThrowExceptionMessage(TJS_W("RegCreateKeyEx() failed."));
			return false;
		}

		InitKeyInfo();

		return static_cast<bool>(disp == REG_CREATED_NEW_KEY);
	};
	/**/
	void Close()
	{
		if(Opened())
		{
			RegCloseKey(m_key);
			m_key = NULL;
		}
	};
	void InitKeyInfo()
	{
		DWORD keys, values, size;
		RegQueryInfoKey(
			m_key, NULL, NULL, NULL, &keys, NULL,
			NULL, &values, NULL, &size, NULL, NULL
		);
		m_subkeys = keys;
		m_values = values;
		m_bufsize = size << 1;
	};

	bool Opened()
	{
		return static_cast<bool>(m_key != NULL);
	};

private:
	HKEY		m_root;
	ttstr		m_path;

	HKEY		m_key;
	tjs_uint	m_subkeys;
	tjs_uint	m_values;
	tjs_uint	m_bufsize;
};

/**/
tTJSVariant RegistoryKey::Read(ttstr ValueName)
{
	tTJSVariant v;

	Open();

	if(Opened())
	{
		try {
			switch(bm88::details::RegValueType(m_key, ValueName))
			{
			//case REG_DWORD_LITTLE_ENDIAN:
			case REG_DWORD:				bm88::details::RegReadValueDoubleWord(m_key, ValueName, v); break;
			case REG_SZ:				bm88::details::RegReadValueString(m_key, ValueName, v, m_bufsize); break;
			case REG_EXPAND_SZ:
			case REG_DWORD_BIG_ENDIAN:	TVPThrowExceptionMessage(TJS_W("Not supported value type.")); break;
			case REG_NONE:				v.Clear(); break;
			}
		} catch(KIM_E_TYPE(e_kim) e) {
			TVPThrowExceptionMessage(e.what());
		}
	}

	return v;
}

/**/
void RegistoryKey::Write(ttstr ValueName, tTJSVariant Value)
{
	Create();

	if(Opened())
	{
		try {
			switch(Value.Type())
			{
			case tvtVoid:		bm88::details::RegWriteValueString(m_key, ValueName, ttstr()); break;
			case tvtObject:		TVPThrowExceptionMessage(TJS_W("Object writing not supported.")); break;
			case tvtString:		bm88::details::RegWriteValueString(m_key, ValueName, ttstr(Value)); break;
			case tvtOctet:		TVPThrowExceptionMessage(TJS_W("Octet writing not supported.")); break;
			case tvtInteger:	bm88::details::RegWriteValueDoubleWord(m_key, ValueName, static_cast<DWORD>(Value.AsInteger())); break;
			case tvtReal:		break;
			}
		} catch(KIM_E_TYPE(e_kim) e) {
			TVPThrowExceptionMessage(e.what());
		}
	}
}

/**/
NCB_PRE_REGIST_CALLBACK(RegistRegistoryClassConstantValue);
NCB_REGISTER_CLASS(RegistoryKey)
{
	Constructor<tjs_int, ttstr>(0);

	Method("read", &Class::Read);
	Method("write", &Class::Write);

	Property("subkey", &Class::GetSubkeyPath, 0);
};


