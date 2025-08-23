/*
 $Author: halo $
 $Revision: 22 $
*/


#include"ncbind.hpp"
#include"Version.h"


tjs_int TJS_INTF_METHOD TJSInterfaceBM88MajorVersion()
{
	return static_cast<tjs_int>(bm88::GetMajorVersion());
}

tjs_int TJS_INTF_METHOD TJSInterfaceBM88MinorVersion()
{
	return static_cast<tjs_int>(bm88::GetMinorVersion());
}

tjs_int TJS_INTF_METHOD TJSInterfaceBM88Version()
{
	return static_cast<tjs_int>(bm88::GetVersion());
}

tjs_int TJS_INTF_METHOD TJSInterfaceBM88CheckVersionOrLater(tjs_int major, tjs_int minor)
{
	if(bm88::GetMajorVersion() >= major && bm88::GetMinorVersion() >= minor)
		return true;
	return false;
}

NCB_REGISTER_FUNCTION(bm88MajorVersion, TJSInterfaceBM88MajorVersion);
NCB_REGISTER_FUNCTION(bm88MinorVersion, TJSInterfaceBM88MinorVersion);
NCB_REGISTER_FUNCTION(bm88Version, TJSInterfaceBM88Version);
NCB_REGISTER_FUNCTION(bm88CheckVersionOrLater, TJSInterfaceBM88CheckVersionOrLater);



