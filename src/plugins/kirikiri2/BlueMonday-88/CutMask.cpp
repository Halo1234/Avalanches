/**
 * $Revision: 144 $
**/


#include"ncbind.hpp"


namespace bm88 {
	namespace details {

		/**/
		inline
		void CutMask(tjs_uint32 *dest, tjs_uint32 *src, tjs_int len)
		{
			// dest == src な状況は考えない
			len--;
			for(; len >= (8 - 1); len -= 8)
			{
				if(!(src[len - 0] & 0xFF000000))
					dest[len - 0] = (dest[len - 0] & 0xFFFFFF);
				if(!(src[len - 1] & 0xFF000000))
					dest[len - 1] = (dest[len - 1] & 0xFFFFFF);
				if(!(src[len - 2] & 0xFF000000))
					dest[len - 2] = (dest[len - 2] & 0xFFFFFF);
				if(!(src[len - 3] & 0xFF000000))
					dest[len - 3] = (dest[len - 3] & 0xFFFFFF);
				if(!(src[len - 4] & 0xFF000000))
					dest[len - 4] = (dest[len - 4] & 0xFFFFFF);
				if(!(src[len - 5] & 0xFF000000))
					dest[len - 5] = (dest[len - 5] & 0xFFFFFF);
				if(!(src[len - 6] & 0xFF000000))
					dest[len - 6] = (dest[len - 6] & 0xFFFFFF);
				if(!(src[len - 7] & 0xFF000000))
					dest[len - 7] = (dest[len - 7] & 0xFFFFFF);
			}

			// 余り
			for(; len >= 0; len--)
			{
				if(!(src[len] & 0xFF000000))
					dest[len] = (dest[len] & 0xFFFFFF);
			}
		}

	};

	namespace helper {

		tjs_int GetLayerImageWidth(iTJSDispatch2 *layer, tTJSVariant &var)
		{
			static tjs_uint32 Hash = 0;
			if(TJS_FAILED(layer->PropGet(0, TJS_W("imageWidth"), &Hash, &var, layer)))
				TVPThrowExceptionMessage(TJS_W("imageWidth が存在しないオブジェクト。"));
			return static_cast<tjs_int>(var);
		}

		tjs_int GetLayerImageHeight(iTJSDispatch2 *layer, tTJSVariant &var)
		{
			static tjs_uint32 Hash = 0;
			if(TJS_FAILED(layer->PropGet(0, TJS_W("imageHeight"), &Hash, &var, layer)))
				TVPThrowExceptionMessage(TJS_W("imageHeight が存在しないオブジェクト。"));
			return static_cast<tjs_int>(var);
		}

		tjs_uint8* GetMainImageBufferForWrite(iTJSDispatch2 *layer, tTJSVariant &var)
		{
			static tjs_uint32 Hash = 0;
			if(TJS_FAILED(layer->PropGet(0, TJS_W("mainImageBufferForWrite"), &Hash, &var, layer)))
				TVPThrowExceptionMessage(TJS_W("mainImageBufferForWrite が存在しないオブジェクト。"));
			return reinterpret_cast<tjs_uint8*>(static_cast<tjs_int>(var));
		}

		const tjs_int GetMainImageBufferPitch(iTJSDispatch2 *layer, tTJSVariant &var)
		{
			static tjs_uint32 Hash = 0;
			if(TJS_FAILED(layer->PropGet(0, TJS_W("mainImageBufferPitch"), &Hash, &var, layer)))
				TVPThrowExceptionMessage(TJS_W("mainImageBufferPitch が存在しないオブジェクト。"));
			return static_cast<tjs_int>(var);
		}

	};
};

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


