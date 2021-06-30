/**
 * $Revision: 148 $
**/


#if !defined(GUARD_EXTERNALINSTALLERINDEX_H)
#define GUARD_EXTERNALINSTALLERINDEX_H

#include"../NSISPlugin.h"
#include"TextBasedFile.h"
#include<algorithm>


namespace impl {

	namespace details {

	};

	/**/
	class ExternalInstallerIndexFile
	{
	public:
		typedef impl::fchar_type				fchar_type;
		typedef impl::fname_type				fname_type;
		typedef impl::file_type					file_type;

		typedef kim::kim_achar					char_type;
		typedef std::vector<char_type>			buffer_type;

		typedef struct KIM_TAG(record_type)
		{
			char_type		type;
			buffer_type		data;

			bool operator==(const KIM_TAG(record_type)& rhs) const
			{
				return type == rhs.type && (strncmp(&data[0], &rhs.data[0], data.size()) == 0);
			};
		} record_type;
		typedef std::vector<record_type>		table_type;

	private:
		ExternalInstallerIndexFile();

	public:
		explicit
		ExternalInstallerIndexFile(const fchar_type *pathname) :
			modified_(false)
		{
			Load(pathname);
		};
		~ExternalInstallerIndexFile()
		{
			try {
				Free();
			} catch(...) {
				// ‚â‚Î‚¢‚¯‚Ç‰½‚à‚µ‚È‚¢
			};
		};

		void Load(const fchar_type *pathname);
		void Save();
		void SaveAs(const fchar_type *pathname);
		void Free();

		void AddLine(const record_type &record)
		{
			if(std::find(indexes_.begin(), indexes_.end(), record) == indexes_.end())
			{
				indexes_.push_back(record);
				modified_ = true;
			}
		};

		bool IsModified() const
		{
			return modified_;
		};

	private:
		fname_type		pathname_;
		buffer_type		header_;
		table_type		indexes_;
		bool			modified_;
	};

};

class ExternalInstallerIndex
{
public:
	typedef NSISPluginManager::string_type			string_type;
	typedef NSISPluginManager::int_type				int_type;

private:
	typedef impl::ExternalInstallerIndexFile		index_type;
	typedef index_type::record_type					record_type;
	typedef index_type::fchar_type					fchar_type;
	typedef index_type::fname_type					fname_type;

private:
	ExternalInstallerIndex();

public:
	explicit
	ExternalInstallerIndex(const fchar_type *pathname) :
		file_(pathname)
	{};
	~ExternalInstallerIndex()
	{
		if(file_.IsModified())
			file_.Save();
	};

	inline
	void Add(string_type &type, string_type &buffer)
	{
		record_type record;

		record.type = type[0];
		record.data.insert(record.data.begin(), buffer.begin(), buffer.end());
		record.data.push_back('\0');

		file_.AddLine(record);
	};

private:
	index_type		file_;			// ƒtƒ@ƒCƒ‹
};


kim::kim_int32 OpenExternalInstallerIndexFile(const char *pathname, ExternalInstallerIndex **p);
bool GetExternalInstallerIndexFile(kim::kim_int32 id, ExternalInstallerIndex **p);
void CloseExternalInstallerIndexFile(kim::kim_int32 id);


#endif	/* GUARD_EXTERNALINSTALLERINDEX_H */

