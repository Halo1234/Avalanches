/**
 * $Revision: 148 $
**/

#include"../NSISPlugin.h"


/**/
BOOL WINAPI DllMain(HANDLE Instance, DWORD Action, LPVOID NotUsed)
{
	CNSISPluginManager.SetModuleHandle(Instance);

	switch(Action)
	{
	case DLL_PROCESS_ATTACH:	break;
	case DLL_PROCESS_DETACH:	break;
	case DLL_THREAD_ATTACH:		break;
	case DLL_THREAD_DETACH:		break;
	}

	return TRUE;
}


