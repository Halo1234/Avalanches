/*
*/

#pragma warning(disable:4312)

#include<windows.h>
#include"ncbind.hpp"

/**/
tjs_int TJS_INTF_METHOD IsKeyDown(tjs_int vk_key)
{
	if (GetAsyncKeyState(vk_key) & 0x8000)
	{
		return true;
	}
	else
	{
		return false;
	}
}

NCB_REGISTER_FUNCTION(isKeyDown, IsKeyDown);


