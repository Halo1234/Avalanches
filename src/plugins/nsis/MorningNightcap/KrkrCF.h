/**
 * $Revision: 148 $
**/


#ifndef GUARD_KRKRCF_H
#define GUARD_KRKRCF_H

#include"TextBasedFile.h"
#include<vector>

// システム全般
#define KRKRCF_DATAPATH		0

// デバッグ
#define KRKRCF_LOGERROR		600
#define KRKRCF_DEBUGWIN		601

// ホットキー
#define KRKRCF_HKCONTROLLER	700
#define KRKRCF_HKEDITOR		701
#define KRKRCF_HKWATCH		702
#define KRKRCF_HKCONSOLE	703
#define KRKRCF_HKUPDATERECT	704
#define KRKRCF_HKDUMPLAYER	705

#define SIZE_OF_TABLE		7

/*
 今日は眠いので、あまりまじめに考えてない。
 暇つぶしがしたいならここを最適化するとよい。
*/
class KrkrCF
{
public:
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

	void SetValue(int field, const buffer_type &value)
	{
		GetItem(field) = value;
	};
	void GetValue(int field, buffer_type &value)
	{
		value = GetItem(field);
	};

private:
	record_type& GetRecord(int field)
	{
		if(field < 0)
			kim::e_access_underrun();
		if(field >= ((SIZE_OF_TABLE + 1) * 100))
			kim::e_access_overrun();
		return table_[(kim::kim_size)(field / 100.0)];
	};
	buffer_type& GetItem(int field)
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


