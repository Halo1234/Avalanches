/*
*/


#include"ncbind.hpp"
#include"kim/KimException.h"


/**/
namespace bm88 {
	namespace details {
	}
}

/**/
class PuzzleINetSocket
{
public:
	/**/
	PuzzleINetSocket()
	{
	};
	/**/
	virtual ~PuzzleINetSocket()
	{
	};

	/**/
	void CallbackTest(iTJSDispatch2* obj)
	{
		tTJSVariant result;

		tjs_error hr = obj->FuncCall(
			0,						// フラグ (TJS_MEMBERENSURE などは不要、単なる関数呼び出しのため 0)
			TJS_W("trigger"),		// 呼び出すメソッド名
			nullptr,				// ヒント (通常 nullptr)
			&result,				// 戻り値を受け取るバリアント
			0,						// 引数の数
			nullptr,				// 引数配列
			obj						// objthis
		);

		if (TJS_FAILED(hr))
		{
			TVPThrowExceptionMessage(TJS_W("obj.trigger() の呼び出しに失敗しました。"));
		}
	};

private:
};

/**/
NCB_REGISTER_CLASS(PuzzleINetSocket)
{
	Constructor();

	Method("callbackTest", &Class::CallbackTest);
};


