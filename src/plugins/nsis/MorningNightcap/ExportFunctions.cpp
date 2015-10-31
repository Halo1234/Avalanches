/**
 * $Revision: 144 $
**/


#include"../NSISPlugin.h"
#include"ExternalInstallerIndex.h"
#include"Index.h"
#include"KrkrCF.h"


static KrkrCF	krkrcf;


/**
 * OpenExternalIndex "external_index_file_pathname"
**/
NSISPLUGINFUNCTION OpenExternalIndex(
	HWND ParentWindow, int StringSize, char *Variables, stack_t **StackTop, extra_parameters *Extra
	)
{
	kim::kim_int32 id = -1;
	NSISPluginManager::string_type pathname;
	ExternalInstallerIndex *p = NULL;

	try {

		CNSISPluginManager.InitializeStackParameters(StringSize, Variables, StackTop, Extra);
		CNSISPluginManager.PopString(pathname);

		id = OpenExternalInstallerIndexFile(pathname.c_str(), &p);

	} catch(KIM_E_TYPE(e_kim) e) {
		MessageBox(ParentWindow, e.what(), KIM_E("Harry KIM"), MB_ICONERROR | MB_OK);
	}

	CNSISPluginManager.PushInt(id);
}

/**
 * AddExternalIndex external_index_file_id "type" "index"
**/
NSISPLUGINFUNCTION AddExternalIndex(
	HWND ParentWindow, int StringSize, char *Variables, stack_t **StackTop, extra_parameters *Extra
	)
{
	NSISPluginManager::int_type id;
	NSISPluginManager::string_type type;
	NSISPluginManager::string_type index;
	ExternalInstallerIndex *p = NULL;

	try {

		CNSISPluginManager.InitializeStackParameters(StringSize, Variables, StackTop, Extra);
		CNSISPluginManager.PopInt(id);
		CNSISPluginManager.PopString(type);
		CNSISPluginManager.PopString(index);

		GetExternalInstallerIndexFile(id, &p);
		p->Add(type, index);

	} catch(KIM_E_TYPE(e_kim) e) {
		MessageBox(ParentWindow, e.what(), KIM_E("Harry KIM"), MB_ICONERROR | MB_OK);
	}
}

/**
 * CloseExternalIndex external_index_file_id
**/
NSISPLUGINFUNCTION CloseExternalIndex(
	HWND ParentWindow, int StringSize, char *Variables, stack_t **StackTop, extra_parameters *Extra
	)
{
	NSISPluginManager::int_type id;

	try {

		CNSISPluginManager.InitializeStackParameters(StringSize, Variables, StackTop, Extra);
		CNSISPluginManager.PopInt(id);

		CloseExternalInstallerIndexFile(id);

	} catch(KIM_E_TYPE(e_kim) e) {
		MessageBox(ParentWindow, e.what(), KIM_E("Harry KIM"), MB_ICONERROR | MB_OK);
	}
}

/*
 OpenIndex "index_file_pathname" "mode"
*/
NSISPLUGINFUNCTION OpenIndex(
	HWND ParentWindow, int StringSize, char *Variables, stack_t **StackTop, extra_parameters *Extra
	)
{
	kim::kim_int32 id = -1;
	NSISPluginManager::string_type pathname;
	NSISPluginManager::string_type mode;
	Index *p = NULL;

	try {

		CNSISPluginManager.InitializeStackParameters(StringSize, Variables, StackTop, Extra);
		CNSISPluginManager.PopString(pathname);
		CNSISPluginManager.PopString(mode);

		id = CreateIndexFile(pathname.c_str(), mode[0], &p);
		p->Reset();

	} catch(KIM_E_TYPE(e_kim) e) {
		MessageBox(ParentWindow, e.what(), KIM_E("Harry KIM"), MB_ICONERROR | MB_OK);
	}

	CNSISPluginManager.PushInt(id);
}

/*
 GetNextIndex index_file_id
*/
NSISPLUGINFUNCTION GetNextIndex(
	HWND ParentWindow, int StringSize, char *Variables, stack_t **StackTop, extra_parameters *Extra
	)
{
	NSISPluginManager::int_type id;
	NSISPluginManager::string_type index;
	Index *p = NULL;

	try {

		CNSISPluginManager.InitializeStackParameters(StringSize, Variables, StackTop, Extra);
		CNSISPluginManager.PopInt(id);

		GetIndexFile(id, &p);
		p->Next(index);

	} catch(KIM_E_TYPE(e_kim) e) {
		MessageBox(ParentWindow, e.what(), KIM_E("Harry KIM"), MB_ICONERROR | MB_OK);
	}

	CNSISPluginManager.PushString(index);
}

/*
 AddIndex index_file_id "index"
*/
NSISPLUGINFUNCTION AddIndex(
	HWND ParentWindow, int StringSize, char *Variables, stack_t **StackTop, extra_parameters *Extra
	)
{
	NSISPluginManager::int_type id;
	NSISPluginManager::string_type index;
	Index *p = NULL;

	try {

		CNSISPluginManager.InitializeStackParameters(StringSize, Variables, StackTop, Extra);
		CNSISPluginManager.PopInt(id);
		CNSISPluginManager.PopString(index);

		GetIndexFile(id, &p);
		p->Add(index);

	} catch(KIM_E_TYPE(e_kim) e) {
		MessageBox(ParentWindow, e.what(), KIM_E("Harry KIM"), MB_ICONERROR | MB_OK);
	}
}

/*
 InsertIndex index_file_id index_number "index"
*/
NSISPLUGINFUNCTION InsertIndex(
	HWND ParentWindow, int StringSize, char *Variables, stack_t **StackTop, extra_parameters *Extra
	)
{
	NSISPluginManager::int_type id;
	NSISPluginManager::int_type index_number;
	NSISPluginManager::string_type index;
	Index *p = NULL;

	try {

		CNSISPluginManager.InitializeStackParameters(StringSize, Variables, StackTop, Extra);
		CNSISPluginManager.PopInt(id);
		CNSISPluginManager.PopInt(index_number);
		CNSISPluginManager.PopString(index);

		GetIndexFile(id, &p);
		p->Insert(index_number, index);

	} catch(KIM_E_TYPE(e_kim) e) {
		MessageBox(ParentWindow, e.what(), KIM_E("Harry KIM"), MB_ICONERROR | MB_OK);
	}
}

/*
 CloseIndex index_file_id
*/
NSISPLUGINFUNCTION CloseIndex(
	HWND ParentWindow, int StringSize, char *Variables, stack_t **StackTop, extra_parameters *Extra
	)
{
	NSISPluginManager::int_type id;

	try {

		CNSISPluginManager.InitializeStackParameters(StringSize, Variables, StackTop, Extra);
		CNSISPluginManager.PopInt(id);

		DeleteIndexFile(id);

	} catch(KIM_E_TYPE(e_kim) e) {
		MessageBox(ParentWindow, e.what(), KIM_E("Harry KIM"), MB_ICONERROR | MB_OK);
	}
}

/*
 InitializeKrkrCF
*/
NSISPLUGINFUNCTION InitializeKrkrCF(
	HWND ParentWindow, int StringSize, char *Variables, stack_t **StackTop, extra_parameters *Extra
	)
{
	try {

		CNSISPluginManager.InitializeStackParameters(StringSize, Variables, StackTop, Extra);

		// デバッグ機能潰し
		krkrcf.SetValue(KrkrCF::KRKRCF_LOGERROR, KIM_WT("no"));
		krkrcf.SetValue(KrkrCF::KRKRCF_DEBUGWIN, KIM_WT("no"));

		// ホットキー潰し
		krkrcf.SetValue(KrkrCF::KRKRCF_HKCONTROLLER, KIM_WT(""));
		krkrcf.SetValue(KrkrCF::KRKRCF_HKEDITOR, KIM_WT(""));
		krkrcf.SetValue(KrkrCF::KRKRCF_HKWATCH, KIM_WT(""));
		krkrcf.SetValue(KrkrCF::KRKRCF_HKCONSOLE, KIM_WT(""));
		krkrcf.SetValue(KrkrCF::KRKRCF_HKUPDATERECT, KIM_WT(""));
		krkrcf.SetValue(KrkrCF::KRKRCF_HKDUMPLAYER, KIM_WT(""));

	} catch(KIM_E_TYPE(e_kim) e) {
		MessageBox(ParentWindow, e.what(), KIM_E("Harry KIM"), MB_ICONERROR | MB_OK);
	}
}

/*
 SetDataPath "pathname"
*/
NSISPLUGINFUNCTION SetDataPath(
	HWND ParentWindow, int StringSize, char *Variables, stack_t **StackTop, extra_parameters *Extra
	)
{
	NSISPluginManager::string_type pathname;

	try {

		CNSISPluginManager.InitializeStackParameters(StringSize, Variables, StackTop, Extra);
		CNSISPluginManager.PopString(pathname);

		krkrcf.SetValue(KrkrCF::KRKRCF_DATAPATH, pathname.c_str());

	} catch(KIM_E_TYPE(e_kim) e) {
		MessageBox(ParentWindow, e.what(), KIM_E("Harry KIM"), MB_ICONERROR | MB_OK);
	}
}

/*
 SaveKrkrCFFile "pathname"
*/
NSISPLUGINFUNCTION SaveKrkrCFFile(
	HWND ParentWindow, int StringSize, char *Variables, stack_t **StackTop, extra_parameters *Extra
	)
{
	NSISPluginManager::string_type pathname;

	try {

		CNSISPluginManager.InitializeStackParameters(StringSize, Variables, StackTop, Extra);
		CNSISPluginManager.PopString(pathname);

		SaveKrkrCFFile(pathname.c_str(), krkrcf);

	} catch(KIM_E_TYPE(e_kim) e) {
		MessageBox(ParentWindow, e.what(), KIM_E("Harry KIM"), MB_ICONERROR | MB_OK);
	}
}



