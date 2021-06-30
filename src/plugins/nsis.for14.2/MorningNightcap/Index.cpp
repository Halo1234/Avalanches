/**
 * $Revision: 148 $
**/


#include"Index.h"

#include<functional>

/**/
namespace impl {

	namespace details {

		/**/
		struct pred_lineend :
			std::unary_function<bool, IndexFile::char_type>
		{
			bool operator()(const IndexFile::char_type &c) const
			{
				switch(c)
				{
				case KIM_WT('\r'): case KIM_WT('\n'): case KIM_WT('\0'):
					return true;
				}
				return false;
			};
		};

		/**/
		struct pred_linetop :
			std::unary_function<bool, IndexFile::char_type>
		{
			bool operator()(const IndexFile::char_type &c) const
			{
				switch(c)
				{
				case KIM_WT('\r'): case KIM_WT('\n'): case KIM_WT('\0'):
					return false;
				}
				return true;
			};
		};

		/**/
		inline
		bool IsBadPathSegment(const kim::kim_wchar *pathname)
		{
			// NOTE:
			// まぁないよりかはマシということでやっつけ実装。
			static const kim::kim_wchar bad1[] = KIM_WT("..\\");
			static const kim::kim_wchar bad2[] = KIM_WT("../");
			kim::kim_wchar c;
			const kim::kim_wchar *p = pathname;

			if(*p == bad1[0] || *p == bad2[0])
			{
				if(::wcsncmp(p, bad1, KIM_ARRAY_COUNT(bad1) - 1) == 0)
					return true;
				if(::wcsncmp(p, bad2, KIM_ARRAY_COUNT(bad2) - 1) == 0)
					return true;
			}

			while(c = *(p++))
			{
				if(c == KIM_WT('\\') || c == KIM_WT('/'))
				{
					if(::wcsncmp(p, bad1, KIM_ARRAY_COUNT(bad1) - 1) == 0)
						return true;
					if(::wcsncmp(p, bad2, KIM_ARRAY_COUNT(bad2) - 1) == 0)
						return true;
				}
			}

			return false;
		};

	}

	/**/
	void IndexFile::Load(const fchar_type *pathname)
	{
		Free();

		buffer_type work;
		file_type file(pathname);

		pathname_ = pathname;
		details::LoadUTF16(file, work);

		buffer_type::const_iterator end = work.end();
		buffer_type::const_iterator s = std::find_if(work.begin(), work.end(), details::pred_linetop());
		buffer_type::const_iterator e = std::find_if(s, end, details::pred_lineend());
		linebuffer_type line;

		while(s != end)
		{
			line.Trim(s, e);

			if(line != KIM_WT("") && !details::IsBadPathSegment(line))
				indexes_.push_back(line);

			s = std::find_if(e, end, details::pred_linetop());
			e = std::find_if(s, end, details::pred_lineend());
		}
	}

	/**/
	void IndexFile::Save()
	{
		index_list::const_iterator ite = indexes_.begin();
		index_list::const_iterator end = indexes_.end();
		file_type file(pathname_.c_str());
		std::basic_string<linebuffer_type::char_type> work;

		file.seek(0);

		{
			kim::kim_wchar bom = 0xFEFF;
			file.write(&bom, 2);
		}

		for(; ite != end; ite++)
		{
			work = *ite;
			work += KIM_WT("\r\n");

			file.write(reinterpret_cast<const void*>(work.c_str()), work.size() << 1);
		}

		file.terminate();

		modified_ = false;
	}

	/**/
	void IndexFile::SaveAs(const fchar_type *pathname)
	{
		index_list::const_iterator ite = indexes_.begin();
		index_list::const_iterator end = indexes_.end();
		file_type file(pathname);
		std::basic_string<linebuffer_type::char_type> work;

		file.seek(0);

		{
			kim::kim_wchar bom = 0xFEFF;
			file.write(&bom, 2);
		}

		for(; ite != end; ite++)
		{
			work = *ite;
			work += KIM_WT("\r\n");

			file.write(reinterpret_cast<const void*>(work.c_str()), work.size() << 1);
		}

		file.terminate();

		modified_ = false;
		pathname_ = pathname;
	}

	/**/
	void IndexFile::Free()
	{
		if(child_ != NULL)
		{
			delete child_;
			child_ = NULL;
		}
		indexes_.clear();
		offset_ = 0;
		modified_ = false;
	}

	/**/
	void IndexFile::NextLine(linebuffer_type &line)
	{
		line.Clear();

		if(indexes_.empty() || offset_ >= indexes_.size())
			return;

		line = indexes_[offset_++];
	}

	/**/
	void IndexFile::PrevLine(linebuffer_type &line)
	{
		line.Clear();

		if(indexes_.empty() || offset_ >= indexes_.size())
			return;

		line = indexes_[indexes_.size() - (offset_++) - 1];
	}

}


// NOTE:
// 以下、例外発生時の動作についてあまり真面目に考えていない。
// ぱっと見るだけでもいくつか問題点はあるが今は気にしない。
// （例えば、スタックの状態が例外発生時に未定義になる点など）
#define INDEXFILE_MAX	32

namespace details {

	static
	Index *s_list[INDEXFILE_MAX] = {NULL, };

	inline
	kim::kim_int32 GetBlankIndex()
	{
		for(kim::kim_int32 i = 0; i < INDEXFILE_MAX; i++)
		{
			if(s_list[i] == NULL)
				return i;
		}

		kim::e_internal(KIM_E("これ以上インデックスファイルを開けません。"));
	};

	inline
	bool IndexFileIDCheck(const kim::kim_int32 id)
	{
		if(id < 0 || id >= INDEXFILE_MAX)
		{
			kim::e_invalid_parameters(KIM_E("無効な IndexFile-ID が入力されました。"));
			return false;
		}

		return true;
	};

}

kim::kim_int32 CreateIndexFile(const char *pathname, char mode, Index **p)
{
	const kim::kim_int32 id = details::GetBlankIndex();

	details::s_list[id] = new Index(pathname, mode);

	if(p != NULL)
		*p = details::s_list[id];

	return id;
}

bool GetIndexFile(kim::kim_int32 id, Index **p)
{
	if(!details::IndexFileIDCheck(id))
		return false;

	if(p == NULL)
		kim::e_invalid_parameters(KIM_E("ぬるぽ"));

	*p = details::s_list[id];
	if(*p == NULL)
		kim::e_bad_access(KIM_E("指定された ID のインデックスファイルは開かれていません。"));

	return true;
}

void DeleteIndexFile(kim::kim_int32 id)
{
	if(details::IndexFileIDCheck(id))
	{
		if(details::s_list[id] != NULL)
		{
			delete details::s_list[id];
			details::s_list[id] = NULL;
		}
	}
}


