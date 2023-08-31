/**
 * $Revision: 148 $
**/


#ifndef GUARD_NSISPLUGIN_H
#define GUARD_NSISPLUGIN_H

#include"kim/KimSingleton.h"

#include<windows.h>
#include"api/pluginapi.h"

#include<vector>
#include<string>

#pragma comment(lib, "pluginapi-x86-unicode.lib")

#define CLINKAGE	extern "C"
#define EXPORT		__declspec(dllexport)
#define NSISAPI		__cdecl

#define NSISPLUGINFUNCTION	CLINKAGE EXPORT void NSISAPI

/**/
class NSISPluginManager
{
	friend struct kim::details::create_new<NSISPluginManager>;

public:
	typedef kim::kim_int32						int_type;
	typedef TCHAR								char_type;
	typedef std::basic_string<char_type>		string_type;

private:
	NSISPluginManager() :
		module_(NULL), callback_registered_(false)
	{};
	~NSISPluginManager()
	{};

public:
	void SetModuleHandle(HANDLE module)
	{
		module_ = reinterpret_cast<HMODULE>(module);
	};

	void InitializeStackParameters(int string_size, LPTSTR variables, stack_t **stacktop, extra_parameters *extra)
	{
		if(!callback_registered_)
			RegistCallbackFunction(extra);

		EXDLL_INIT();
	};

	void PopString(string_type &str)
	{
		std::vector<TCHAR> buf(g_stringsize);

		if(buf.empty())
			kim::e_internal(KIM_E("内部バッファの確保に失敗しました。"));

		if(popstringn(&buf[0], g_stringsize) != 0)
			kim::e_internal(KIM_E("NSISPluginAPI failed."));

		str = &buf[0];
	};
	void PopInt(int_type &i)
	{
		i = popint();
	};

	void PushString(string_type &str)
	{
		if(str.empty())
			pushstring(KIM_TC(""));
		else
			pushstring(str.c_str());
	};
	void PushInt(int_type i)
	{
		pushint(i);
	};

private:
	void RegistCallbackFunction(extra_parameters *extra)
	{
		if(extra->RegisterPluginCallback(module_, NSISCallback) == 0)
			callback_registered_ = true;
	};

#pragma warning(push)
#pragma warning(disable: 26812 )

	static
	UINT_PTR NSISCallback(enum NSPIM im)
	{
		switch(im)
		{
		case NSPIM_UNLOAD:
			break;

		case NSPIM_GUIUNLOAD:
			break;
		}

		return 0L;
	};

#pragma warning(pop)

private:
	HMODULE	module_;
	bool	callback_registered_;
};

typedef kim::singleton<NSISPluginManager>	SingleNSISPluginManager;
#define CNSISPluginManager					SingleNSISPluginManager::instance()

/* vがb-eの範囲内かどうか調べる */
#define RANGE(v, b, e)		((BOOL)(((int)(v)>=(int)(b))&&((int)(v)<=(int)(e))))
/* シフトJISチェック */
#define IS_SHIFT_JIS_1ST(c)	((BOOL)(RANGE((BYTE)(c),0x81,0x9F)||RANGE((BYTE)(c),0xE0,0xFC)))
#define IS_SHIFT_JIS_2ND(c)	((BOOL)(RANGE((BYTE)(c),0x40,0xFC)&&(BYTE)(c)!=0x7F))

/**/
#define LSRESULT_OK		0
#define LSRESULT_FAIL	1

#endif	/* GUARD_NSISPLUGIN_H */


