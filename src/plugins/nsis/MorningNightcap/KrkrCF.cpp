/**
 * $Revision: 144 $
**/


#include"../NSISPlugin.h"
#include"KrkrCF.h"
#include<stdarg.h>


#define WORKBUFFER_SIZE		1024


namespace details {
}

/**/
void LoadKrkrCFFile(const impl::fchar_type *pathname, KrkrCF &cf)
{
	kim::e_internal(KIM_E("Not implement."));
}

namespace details {

	typedef kim::kim_wchar							char_type;

#if defined(KIM_MSVC_COMPILER)

	/**/
	int mn_swprintf(char_type *wcs, kim::kim_size maxlen, const char_type *format, ...)
	{
		va_list ap;
		int ret;

		va_start(ap, format);

#  if defined(KIM_HAS_SECURE_CRT)
		ret = ::vswprintf_s(wcs, maxlen, format, ap);
#  else
		ret = ::vswprintf(wcs, maxlen, format, ap);
#  endif

		if(ret == -1)
		{
			switch(errno)
			{
			case EINVAL:	kim::e_invalid_parameters(KIM_E("無効な入力パラメータ @ mn_swprintf()")); break;
			default:		kim::e_internal(KIM_E("よくわからんがエラー @ mn_swprintf()")); break;
			}
		}

		va_end(ap);

		return ret;
	};

#elif defined(KIM_GNUC_COMPILER)

	/**/
	int mn_swprintf(char_type *wcs, kim::kim_size maxlen, const char_type *format, ...)
	{
		va_list ap;
		int ret;

		va_start(ap, format);
		ret = ::vswprintf(wcs, format, ap);
		va_end(ap);

		return ret;
	};

#endif

	/**/
	inline
	kim::kim_dword GetUnicodeCodePoint(kim::kim_wchar c)
	{
		return static_cast<kim::kim_dword>(c);
	};

	/**/
	inline
	kim::kim_dword GetUnicodeCodePoint(kim::kim_wchar c1, kim::kim_wchar c2)
	{
		kim::kim_dword cp1 = static_cast<kim::kim_dword>(c1 - 0xD800) << 10;
		kim::kim_dword cp2 = static_cast<kim::kim_dword>(c2 - 0xDC00);

		return (cp1 + cp2) + 0x10000;
	};

	/**/
	kim::kim_wchar* GetKrkrCFString(const kim::kim_wchar *str)
	{
		static std::vector<kim::kim_wchar> buffer;
		kim::kim_wchar work[64];
		kim::kim_wchar c;
		kim::kim_wchar p = 0;

		buffer.clear();
		buffer.push_back(KIM_WT('"'));

		while(c = (*str++))
		{
			// サロゲートペア（１ＳＴ）
			if(c >= 0xD800 && c <= 0xDBFF)
			{
				// 次の文字がサロゲートペアの後半部である事を確認するだけ
				if(*str < 0xDC00 || *str > 0xDFFF)
					kim::e_invalid_parameters(KIM_E("サロゲートペアの前半部が単独で現れました。"));
			}
			else
			// サロゲートペア（２ＮＤ）
			if(c >= 0xDC00 && c <= 0xDFFF)
			{
				// ちゃんとペアになってるか確認
				if(p < 0xD800 || p > 0xDBFF)
					kim::e_invalid_parameters(KIM_E("サロゲートペアの後半部が単独で現れました。"));

				details::mn_swprintf(work, 64, KIM_WT("\\x%X"), GetUnicodeCodePoint(p, c));

				for(kim::kim_native i = 0; work[i]; i++)
					buffer.push_back(work[i]);
			}
			// 通常
			else
			{
				details::mn_swprintf(work, 64, KIM_WT("\\x%X"), GetUnicodeCodePoint(c));

				for(kim::kim_native i = 0; work[i]; i++)
					buffer.push_back(work[i]);
			}

			p = c;
		}

		buffer.push_back(KIM_WT('"'));
		buffer.push_back(KIM_WT('\0'));

		return &buffer[0];
	};

	/**/
	void WriteInSJIS(impl::file_type &file, KrkrCF::buffer_type &buffer)
	{
		NSISPluginManager::string_type mb(buffer);

		file.write(mb.c_str(), mb.size());
	};

	/**/
	void SaveSystemConfigure(impl::file_type &file, KrkrCF::record_type &rec)
	{
		KrkrCF::buffer_type work;

		for(kim::kim_size i = 0; i < rec.size(); i++)
		{
			const kim::kim_native type = i;

			switch(type)
			{
			case KrkrCF::KRKRCF_DATAPATH:
				work = KIM_WT("datapath=");
				work += GetKrkrCFString(rec[i]);
				break;
			default:
				kim::e_internal(KIM_E("「システム全般」不明な設定タイプです。"));
			}

			work += KIM_WT("\n");

			WriteInSJIS(file, work);
		}
	};

	/**/
	void SaveDebugConfigure(impl::file_type &file, KrkrCF::record_type &rec)
	{
		KrkrCF::buffer_type work;

		for(kim::kim_size i = 0; i < rec.size(); i++)
		{
			const kim::kim_native type = i + 600;

			switch(type)
			{
			case KrkrCF::KRKRCF_LOGERROR:
				work = KIM_WT("logerror=");
				work += GetKrkrCFString(rec[i]);
				break;
			case KrkrCF::KRKRCF_DEBUGWIN:
				work = KIM_WT("debugwin=");
				work += GetKrkrCFString(rec[i]);
				break;
			default:
				kim::e_internal(KIM_E("「デバッグ」不明な設定タイプです。"));
			}

			work += KIM_WT("\n");

			WriteInSJIS(file, work);
		}
	};

	/**/
	void SaveHotKeyConfigure(impl::file_type &file, KrkrCF::record_type &rec)
	{
		KrkrCF::buffer_type work;

		for(kim::kim_size i = 0; i < rec.size(); i++)
		{
			const kim::kim_native type = i + 700;

			switch(type)
			{
			case KrkrCF::KRKRCF_HKCONTROLLER:
				work = KIM_WT("hkcontroller=");
				work += GetKrkrCFString(rec[i]);
				break;
			case KrkrCF::KRKRCF_HKEDITOR:
				work = KIM_WT("hkeditor=");
				work += GetKrkrCFString(rec[i]);
				break;
			case KrkrCF::KRKRCF_HKWATCH:
				work = KIM_WT("hkwatch=");
				work += GetKrkrCFString(rec[i]);
				break;
			case KrkrCF::KRKRCF_HKCONSOLE:
				work = KIM_WT("hkconsole=");
				work += GetKrkrCFString(rec[i]);
				break;
			case KrkrCF::KRKRCF_HKUPDATERECT:
				work = KIM_WT("hkupdaterect=");
				work += GetKrkrCFString(rec[i]);
				break;
			case KrkrCF::KRKRCF_HKDUMPLAYER:
				work = KIM_WT("hkdumplayer=");
				work += GetKrkrCFString(rec[i]);
				break;
			default:
				kim::e_internal(KIM_E("「ホットキー」不明な設定タイプです。"));
			}

			work += KIM_WT("\n");

			WriteInSJIS(file, work);
		}
	};

}

/**/
void SaveKrkrCFFile(const impl::fchar_type *pathname, KrkrCF &cf)
{
	impl::file_type file(pathname);

	file.terminate();

	details::SaveSystemConfigure(file, cf.table_[0]);
	details::SaveDebugConfigure(file, cf.table_[6]);
	details::SaveHotKeyConfigure(file, cf.table_[7]);
}


