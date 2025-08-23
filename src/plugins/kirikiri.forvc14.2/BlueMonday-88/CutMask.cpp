/*
 $Author: halo $
 $Revision: 22 $
*/

#pragma warning(disable:4312)

#include<windows.h>
#include"ncbind.hpp"
#include"CutMask.h"

/**/
void TJS_INTF_METHOD CutMask(
	iTJSDispatch2 *dest,
	tjs_int dx,
	tjs_int dy,
	iTJSDispatch2 *src,
	tjs_int sx,
	tjs_int sy,
	tjs_int sw,
	tjs_int sh)
{
	// 本来ならクリッピングする必要があるが
	// どうせ俺しか使わない＆今回のみしか利用しないので余計な事はしない

	static tTJSVariant t;
	const tjs_int size = sizeof(tjs_uint32);
	const tjs_int dpitch = bm88::helper::GetMainImageBufferPitch(dest, t);
	const tjs_int spitch = bm88::helper::GetMainImageBufferPitch(src, t);
	tjs_uint8 *pd = bm88::helper::GetMainImageBufferForWrite(dest, t) + (dpitch * dy) + (size * dx);
	tjs_uint8 *ps = bm88::helper::GetMainImageBufferForWrite(src, t) + (spitch * sy) + (size * sx);

	for(; sh != 0; sh--, pd += dpitch, ps += spitch)
		bm88::details::CutMask(reinterpret_cast<tjs_uint32*>(pd), reinterpret_cast<tjs_uint32*>(ps), sw);
}

NCB_REGISTER_FUNCTION(cutMask, CutMask);


