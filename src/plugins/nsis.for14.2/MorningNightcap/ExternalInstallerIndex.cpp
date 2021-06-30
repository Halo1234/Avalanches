/**
 * $Revision: 148 $
**/


#include"ExternalInstallerIndex.h"

#include<functional>

/**/
namespace impl {

	namespace details {

	}

	/**/
	void ExternalInstallerIndexFile::Load(const fchar_type *pathname)
	{
		Free();

		file_type file(pathname);
		const file_type::size_type size = (file_type::size_type)file.size();

		pathname_ = pathname;

		if(size == 0)
			return;

		buffer_type buffer(size);

		if(file.read(&buffer[0], size) != size)
			kim::e_internal(KIM_E("�C���f�b�N�X�t�@�C���ǂݍ��݂Ɏ��s���܂����B"));

		// NOTE: �ŏ��̈�s�̓w�b�_
		buffer_type::const_iterator b = buffer.begin();
		buffer_type::const_iterator e = buffer.end();
		char_type prev = '\0';
		for(; b != e; ++b)
		{
			if(!(IS_SHIFT_JIS_1ST(prev) && IS_SHIFT_JIS_2ND(*b)))
			{
				if(prev == '\r' && (*b) == '\n')
				{
					// NOTE: size() == 0 �͂��肦�Ȃ��B
					header_[header_.size() - 1] = '\0';
					++b;
					break;
				}
			}

			header_.push_back(prev = *b);
		}

		buffer_type work;
		for(prev = '\0'; b != e; ++b)
		{
			if(!(IS_SHIFT_JIS_1ST(prev) && IS_SHIFT_JIS_2ND(*b)))
			{
				if(prev == '\r' && (*b) == '\n')
				{
					record_type record;

					// NOTE: size() == 0 �͂��肦�Ȃ��B
					work[work.size() - 1] = '\0';

					if(work.size() <= 2)
						kim::e_internal(KIM_E("�Q�o�C�g�ȉ��̍s������܂����B�d�l�ᔽ�ł��B"));

					record.type = work[0];
					record.data.insert(record.data.begin(), work.begin() + 2, work.end());

					indexes_.push_back(record);

					work.clear();
					continue;
				}
			}

			work.push_back(prev = *b);
		}
	}

	/**/
	void ExternalInstallerIndexFile::Save()
	{
		table_type::const_iterator ite = indexes_.begin();
		table_type::const_iterator end = indexes_.end();
		file_type file(pathname_.c_str());
		buffer_type work;
		buffer_type::size_type size;

		file.seek(0);
		file.terminate();

		// �w�b�_
		if(!header_.empty())
		{
			file.write(&header_[0], header_.size() - 1);
			file.write("\r\n", 2);
		}

		// �C���f�b�N�X
		for(; ite != end; ++ite)
		{
			size = ite->data.size() - 1;
			// type(1byte) + separator(1byte) + size + CRLF(2byte)
			work.resize(2 + size + 2);
			work[0] = ite->type;
			work[1] = 0x09;
			memcpy(reinterpret_cast<void*>(&work[2]), &ite->data[0], size);
			work[2 + size + 0] = '\r';
			work[2 + size + 1] = '\n';
			file.write(reinterpret_cast<const void*>(&work[0]), work.size());
		}

		file.terminate();
		modified_ = false;
	}

	/**/
	void ExternalInstallerIndexFile::SaveAs(const fchar_type *pathname)
	{
		// ����K�v�Ȃ��̂Ŗ�����
	}

	/**/
	void ExternalInstallerIndexFile::Free()
	{
		indexes_.clear();
		header_.clear();
		modified_ = false;
	}

}


// NOTE:
// �ȉ��A��O�������̓���ɂ��Ă��܂�^�ʖڂɍl���Ă��Ȃ��B
// �ς��ƌ��邾���ł����������_�͂��邪���͋C�ɂ��Ȃ��B
// �i�Ⴆ�΁A�X�^�b�N�̏�Ԃ���O�������ɖ���`�ɂȂ�_�Ȃǁj
#define EXTERNALINSTALLER_INDEXFILE_MAX	4

namespace details {

	static
	ExternalInstallerIndex *s_external_installer_list[EXTERNALINSTALLER_INDEXFILE_MAX] = {NULL, };

	inline
	kim::kim_int32 GetBlankExternalInstallerIndex()
	{
		for(kim::kim_int32 i = 0; i < EXTERNALINSTALLER_INDEXFILE_MAX; i++)
		{
			if(s_external_installer_list[i] == NULL)
				return i;
		}

		kim::e_internal(KIM_E("����ȏ�C���f�b�N�X�t�@�C�����J���܂���B"));
	};

	inline
	bool ExternalInstallerIndexFileIDCheck(const kim::kim_int32 id)
	{
		if(id < 0 || id >= EXTERNALINSTALLER_INDEXFILE_MAX)
		{
			kim::e_invalid_parameters(KIM_E("������ ExternalInstallerIndexFile-ID �����͂���܂����B"));
			return false;
		}

		return true;
	};

}

kim::kim_int32 OpenExternalInstallerIndexFile(const char *pathname, ExternalInstallerIndex **p)
{
	const kim::kim_int32 id = details::GetBlankExternalInstallerIndex();

	details::s_external_installer_list[id] = new ExternalInstallerIndex(pathname);

	if(p != NULL)
		*p = details::s_external_installer_list[id];

	return id;
}

bool GetExternalInstallerIndexFile(kim::kim_int32 id, ExternalInstallerIndex **p)
{
	if(!details::ExternalInstallerIndexFileIDCheck(id))
		return false;

	if(p == NULL)
		kim::e_invalid_parameters(KIM_E("�ʂ��"));

	*p = details::s_external_installer_list[id];
	if(*p == NULL)
		kim::e_bad_access(KIM_E("�w�肳�ꂽ ID �̃C���f�b�N�X�t�@�C���͊J����Ă��܂���B"));

	return true;
}

void CloseExternalInstallerIndexFile(kim::kim_int32 id)
{
	if(details::ExternalInstallerIndexFileIDCheck(id))
	{
		if(details::s_external_installer_list[id] != NULL)
		{
			delete details::s_external_installer_list[id];
			details::s_external_installer_list[id] = NULL;
		}
	}
}


