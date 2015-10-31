/**
 * $Revision: 144 $
**/


#include"Index.h"
#include<windows.h>

/**/
namespace impl {

	/**/
	CharacterConvertor::mbchar_type* CharacterConvertor::ToSJIS(const buffer_type &wide, mbbuffer_type &mb)
	{
		if(wide.empty())
			return KIM_AT("");
		return CharacterConvertor::ToSJIS(&wide[0], wide.size(), mb);
	}

	/**/
	CharacterConvertor::mbchar_type* CharacterConvertor::ToSJIS(
		const buffer_type::value_type *wide, buffer_type::size_type size, mbbuffer_type &mb)
	{
		if(size == 0)
			return KIM_AT("");

		kim::kim_native length = ::WideCharToMultiByte(
			CP_ACP, WC_COMPOSITECHECK | WC_SEPCHARS,
			wide, size,
			NULL, 0, NULL, NULL);

		if(length == 0)
			length = size >> 1;
		mb.resize(length);

		if(WideCharToMultiByte(
			CP_ACP, WC_COMPOSITECHECK | WC_SEPCHARS,
			wide, size,
			&mb[0], mb.size(),
			NULL, NULL) == 0)
		{
			kim::e_internal(KIM_E("UTF16 から S-JIS への変換に失敗しました。"));
		}

		// きちんとしまっちゃおうね
		if(mb.back() != KIM_AT('\0'))
			mb.push_back(KIM_AT('\0'));

		return &mb[0];
	}

	/**/
	CharacterConvertor::char_type* CharacterConvertor::JISTo(const mbbuffer_type &mb, buffer_type &wide)
	{
		if(mb.empty())
			return KIM_WT("");
		return CharacterConvertor::JISTo(&mb[0], mb.size(), wide);
	}

	/**/
	CharacterConvertor::char_type* CharacterConvertor::JISTo(
		const mbbuffer_type::value_type *mb, mbbuffer_type::size_type size, buffer_type &wide)
	{
		kim::e_not_supported(KIM_E("サポートできない文字エンコーディングです。（ＪＩＳ）"));
		return NULL;
	}

	/**/
	CharacterConvertor::char_type* CharacterConvertor::EUCJPTo(const mbbuffer_type &mb, buffer_type &wide)
	{
		if(mb.empty())
			return KIM_WT("");
		return CharacterConvertor::EUCJPTo(&mb[0], mb.size(), wide);
	}

	/**/
	CharacterConvertor::char_type* CharacterConvertor::EUCJPTo(
		const mbbuffer_type::value_type *mb, mbbuffer_type::size_type size, buffer_type &wide)
	{
		kim::e_not_supported(KIM_E("サポートできない文字エンコーディングです。（ＥＵＣ－ＪＰ）"));
		return NULL;
	}

	/**/
	CharacterConvertor::char_type* CharacterConvertor::SJISTo(const mbbuffer_type &mb, buffer_type &wide)
	{
		if(mb.empty())
			return KIM_WT("");
		return CharacterConvertor::SJISTo(&mb[0], mb.size(), wide);
	}

	/**/
	CharacterConvertor::char_type* CharacterConvertor::SJISTo(
		const mbbuffer_type::value_type *mb, mbbuffer_type::size_type size, buffer_type &wide)
	{
		if(size == 0)
			return KIM_WT("");

		kim::kim_native length = ::MultiByteToWideChar(
			CP_ACP, MB_PRECOMPOSED | MB_ERR_INVALID_CHARS,
			mb, size, NULL, 0
		);

		if(length == 0)
			length = size << 1;

		wide.resize(length);
		if(::MultiByteToWideChar(
			CP_ACP, MB_PRECOMPOSED | MB_ERR_INVALID_CHARS,
			mb, size, &wide[0], length) == 0)
		{
			kim::e_internal(KIM_E("S-JIS から UTF16 への変換に失敗しました。"));
		}

		// きちんとしまっちゃおうね
		if(wide.back() != KIM_WT('\0'))
			wide.push_back(KIM_WT('\0'));

		return &wide[0];
	}

	/**/
	CharacterConvertor::char_type* CharacterConvertor::UTF8To(const mbbuffer_type &mb, buffer_type &wide)
	{
		if(mb.empty())
			return KIM_WT("");
		return CharacterConvertor::UTF8To(&mb[0], mb.size(), wide);
	}

	/**/
	CharacterConvertor::char_type* CharacterConvertor::UTF8To(
		const mbbuffer_type::value_type *mb, mbbuffer_type::size_type size, buffer_type &wide)
	{
		kim::e_not_supported(KIM_E("サポートできない文字エンコーディングです。（ＵＴＦ－８）"));
		return NULL;
	}

	/**/
	CharacterConvertor::char_type* CharacterConvertor::UTF16To(const buffer_type &src, buffer_type &dest)
	{
		if(src.empty())
			return KIM_WT("");
		return CharacterConvertor::UTF16To(&src[0], src.size(), dest);
	}

	/**/
	CharacterConvertor::char_type* CharacterConvertor::UTF16To(
		const buffer_type::value_type *mb, buffer_type::size_type size, buffer_type &wide)
	{
		// BOM があれば無視する
		if(size >= 1 && mb[0] == 0xFEFF)
			mb += 1, size -= 1;

		wide.clear();
		wide.insert(
			wide.begin(),
			reinterpret_cast<const buffer_type::value_type*>(mb),
			reinterpret_cast<const buffer_type::value_type*>(mb + size)
		);
		if(wide.back() != KIM_WT('\0'))
			wide.push_back(KIM_WT('\0'));

		return &wide[0];
	}

	/**/
	CharacterConvertor::char_type* CharacterConvertor::UTF16BETo(const buffer_type &be, buffer_type &le)
	{
		if(be.empty())
			kim::e_invalid_parameters(KIM_E("変換元バッファが空です。"));
		return CharacterConvertor::UTF16BETo(&be[0], be.size(), le);
	}

	/**/
	CharacterConvertor::char_type* CharacterConvertor::UTF16BETo(
		const buffer_type::value_type *be, buffer_type::size_type size, buffer_type &le)
	{
		kim::e_not_supported(KIM_E("現在エンディアン変換処理は未実装です。"));
		return NULL;
	}

	namespace details {

		typedef enum character_encoding_t
		{
			CE_UNKNOWN = 0,
			CE_JIS,
			CE_EUC_JP,
			CE_SHIFT_JIS,
			CE_UTF8,
			CE_UTF16,
			CE_UTF16BE,
			CE_UTF32,
			CE_UTF32BE
		} CharacterEncoding;

		/**/
		inline
		CharacterEncoding CheckBOM(kim::kim_byte first, kim::kim_byte second)
		{
			// ビッグエンディアン
			if(first == 0xFE && second == 0xFF)
				return CE_UTF16BE;
			else
			// リトルエンディアン
			if(first == 0xFF && second == 0xFE)
				return CE_UTF16;

			return CE_UNKNOWN;
		}

		inline
		CharacterEncoding CheckBOM(kim::kim_byte first, kim::kim_byte second, kim::kim_byte third)
		{
			if(first == 0xEF && second == 0xBB && third == 0xBF)
				return CE_UTF8;

			return CE_UNKNOWN;
		}

		inline
		CharacterEncoding CheckBOM(kim::kim_byte first, kim::kim_byte second, kim::kim_byte third, kim::kim_byte fourth)
		{
			if(first == 0x00 && second == 0x00 && third == 0xFE && fourth == 0xFF)
				return CE_UTF32BE;
			else
			// リトルエンディアン
			if(first == 0xFF && second == 0xFE && third == 0x00 && fourth == 0x00)
				return CE_UTF32;

			return CE_UNKNOWN;
		}

		/**/
		CharacterEncoding CharacterEncodingType(const void *buffer, kim::kim_size size)
		{
			const kim::kim_byte *p = reinterpret_cast<const kim::kim_byte*>(buffer);
			CharacterEncoding type = CE_UNKNOWN;

			if(size >= 4)
			{
				type = CheckBOM(p[0], p[1], p[2], p[3]);
				if(type != CE_UNKNOWN)
					return type;
			}

			if(size >= 3)
			{
				type = CheckBOM(p[0], p[1], p[2]);
				if(type != CE_UNKNOWN)
					return type;
			}

			if(size >= 2)
			{
				type = CheckBOM(p[0], p[1]);
				if(type != CE_UNKNOWN)
					return type;
			}

			// NOTE:
			// 当たり前だが実際には S-JIS かどうかは不明。
			// 実装がめんどくさいので後回し。
			return CE_SHIFT_JIS;
		}

		/**/
		void LoadUTF16(IndexFile::file_type &file, IndexFile::buffer_type &buffer)
		{
			const IndexFile::file_type::size_type size = (IndexFile::file_type::size_type)file.size();
			LineBuffer::mbbuffer_type work;

			if(size == 0)
				return;

			work.resize(size);
			if(file.read(&work[0], size) != size)
				kim::e_internal(KIM_E("インデックスファイル読み込みに失敗しました。"));

			switch(CharacterEncodingType(&work[0], work.size()))
			{
			case CE_JIS:		CharacterConvertor::JISTo(work, buffer); break;
			case CE_EUC_JP:		CharacterConvertor::EUCJPTo(work, buffer); break;
			case CE_SHIFT_JIS:	CharacterConvertor::SJISTo(work, buffer); break;
			case CE_UTF8:		CharacterConvertor::UTF8To(work, buffer); break;
			case CE_UTF16:
				CharacterConvertor::UTF16To(
					reinterpret_cast<LineBuffer::char_type*>(&work[0]),
					work.size() >> 1,
					buffer);
				break;
			case CE_UTF16BE:
				CharacterConvertor::UTF16BETo(
					reinterpret_cast<LineBuffer::char_type*>(&work[0]),
					work.size() >> 1,
					buffer);
				break;
			default:			kim::e_not_supported(KIM_E("サポートできない文字エンコーディングです。（未知のエンコーディング）"));
			}
		};

	}

	/**/
	LineBuffer& LineBuffer::Assign(const char_type *rhs)
	{
		const char_type *s = rhs;
		int i = 0;

		while(rhs[i++])
			;
		Trim(s, s + i);

		return (*this);
	}

	/**/
	LineBuffer& LineBuffer::Assign(const mbchar_type *rhs)
	{
		const mbchar_type *s = rhs;
		int i = 0;

		while(rhs[i++])
			;
		Trim(s, s + i);

		return (*this);
	}

	/**/
	kim::kim_int32 LineBuffer::Compara(const LineBuffer &rhs)
	{
		kim::e_not_supported(KIM_E("Not implemented."));
		return 0;
	}

	/**/
	kim::kim_int32 LineBuffer::Compara(const char_type *rhs)
	{
		kim::e_not_supported(KIM_E("Not implemented."));
		return 0;
	}

	/**/
	kim::kim_int32 LineBuffer::Compara(const kim::kim_achar *rhs)
	{
		kim::e_not_supported(KIM_E("Not implemented."));
		return 0;
	}

}


