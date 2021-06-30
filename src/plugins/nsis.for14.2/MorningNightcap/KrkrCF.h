/**
 * $Revision: 148 $
**/


#ifndef GUARD_KRKRCF_H
#define GUARD_KRKRCF_H

#include"TextBasedFile.h"
#include<vector>

/*
 今日は眠いので、あまりまじめに考えてない。
 暇つぶしがしたいならここを最適化するとよい。
*/
class KrkrCF
{
public:
	typedef enum KIM_TAG(field_name)
	{
		// システム全般
		KRKRCF_DATAPATH = 0,

		// デバッグ
		KRKRCF_LOGERROR = 600,
		KRKRCF_DEBUGWIN,

		// ホットキー
		KRKRCF_HKCONTROLLER = 700,
		KRKRCF_HKEDITOR,
		KRKRCF_HKWATCH,
		KRKRCF_HKCONSOLE,
		KRKRCF_HKUPDATERECT,
		KRKRCF_HKDUMPLAYER
	} field_name;

	typedef enum KIM_TAG(record_count)
	{
		SIZE_OF_TABLE = 7
	} record_count;

	typedef impl::LineBuffer			buffer_type;
	typedef std::vector<buffer_type>	record_type;

	typedef buffer_type::char_type		char_type;

	friend void LoadKrkrCFFile(const impl::fchar_type *pathname, KrkrCF &cf);
	friend void SaveKrkrCFFile(const impl::fchar_type *pathname, KrkrCF &cf);

public:
	KrkrCF()
	{};
	~KrkrCF()
	{};

	void SetValue(field_name field, const buffer_type &value)
	{
		GetItem(field) = value;
	};
	void GetValue(field_name field, buffer_type &value)
	{
		value = GetItem(field);
	};

private:
	record_type& GetRecord(field_name field)
	{
		if(field < 0)
			kim::e_access_underrun();
		if(field >= ((SIZE_OF_TABLE + 1) * 100))
			kim::e_access_overrun();
		return table_[(kim::kim_size)(field / 100.0)];
	};
	buffer_type& GetItem(field_name field)
	{
		record_type &rec = GetRecord(field);
		kim::kim_size idx = field % 100;

		if(idx >= rec.size())
			rec.resize(idx + 1);

		return rec[idx];
	};

private:
	record_type	table_[SIZE_OF_TABLE];
};

/**/
void LoadKrkrCFFile(const impl::fchar_type *pathname, KrkrCF &cf);
void SaveKrkrCFFile(const impl::fchar_type *pathname, KrkrCF &cf);


#endif	/* GUARD_KRKRCF_H */


