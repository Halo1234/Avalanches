/**
 * $Revision: 148 $
**/


#if !defined(GUARD_INDEXFILE_H)
#define GUARD_INDEXFILE_H

#include"../NSISPlugin.h"
#include"TextBasedFile.h"
#include<algorithm>

/**/
namespace impl {

	/**/
	class IndexFile
	{
	public:
		typedef impl::fchar_type				fchar_type;
		typedef impl::fname_type				fname_type;
		typedef impl::file_type					file_type;

		typedef LineBuffer						linebuffer_type;
		typedef linebuffer_type::char_type		char_type;
		typedef linebuffer_type::buffer_type	buffer_type;

		typedef std::vector<linebuffer_type>	index_list;

	private:
		IndexFile();

	public:
		explicit
		IndexFile(const fchar_type *pathname) :
			child_(NULL), offset_(0), modified_(false)
		{
			Load(pathname);
		};
		~IndexFile()
		{
			try {
				Free();
			} catch(...) {
				// やばいけど何もしない
			};
		};

		void Load(const fchar_type *pathname);
		void Save();
		void SaveAs(const fchar_type *pathname);
		void Free();

		void Reset()
		{
			offset_ = 0;
		};

		void NextLine(linebuffer_type &line);
		void PrevLine(linebuffer_type &line);

		void AddLine(const linebuffer_type &line)
		{
			modified_ = true;
			indexes_.push_back(line);
		};
		void InsertLine(kim::kim_int32 index, const linebuffer_type &line)
		{
			modified_ = true;
			indexes_.insert(indexes_.begin() + index, line);
		};

		bool IsModified() const
		{
			return modified_;
		};

	private:
		fname_type				pathname_;
		IndexFile				*child_;
		index_list				indexes_;
		index_list::size_type	offset_;
		bool					modified_;
	};
}

/**/
class Index
{
public:
	typedef NSISPluginManager::string_type	string_type;
	typedef NSISPluginManager::int_type		int_type;

private:
	typedef impl::IndexFile				index_type;
	typedef index_type::linebuffer_type	linebuffer_type;
	typedef index_type::fchar_type		fchar_type;
	typedef index_type::fname_type		fname_type;

private:
	Index();

public:
	// NOTE:
	// mode には 's' か 'r' を指定
	//
	// 's' ならば Next() はファイル先頭から順番に返す。
	// 'r' ならば Next() は逆順で返す。
	// デフォルトは 's' です。
	explicit
	Index(const fchar_type *pathname, const fchar_type mode = KIM_TC('s')) :
		file_(pathname),
		mode_(GetValidMode(mode))
	{};
	~Index()
	{
		if(file_.IsModified())
			file_.Save();
	};

	/**/
	inline
	void Next(string_type &buffer)
	{
		static linebuffer_type buf;

		switch(mode_)
		{
		case KIM_TC('s'):	file_.NextLine(buf); break;
		case KIM_TC('r'):	file_.PrevLine(buf); break;
		}

		buffer = buf;
	};

	inline
	void Add(string_type &buffer)
	{
		file_.AddLine(linebuffer_type(buffer.c_str()));
	};
	inline
	void Insert(int_type index, string_type &buffer)
	{
		file_.InsertLine(index, linebuffer_type(buffer.c_str()));
	};

	inline
	void Reset()
	{
		file_.Reset();
	};

private:
	/**/
	inline
	const fchar_type GetValidMode(const fchar_type mode) const
	{
		switch(mode)
		{
		case KIM_TC('s'): case KIM_TC('r'):
			return mode;
		default:	kim::e_invalid_parameters(KIM_E("無効なモードが指定されました。モードには 's' または 'r' を指定してください。"));
		}
	}

private:
	index_type			file_;			// ファイル
	const fchar_type	mode_;			// 処理モード 's' か 'r'
};


kim::kim_int32 CreateIndexFile(LPCTSTR pathname, TCHAR mode, Index **p);
bool GetIndexFile(kim::kim_int32 id, Index **p);
void DeleteIndexFile(kim::kim_int32 id);


#endif	/* GUARD_INDEXFILE_H */


