/*
*/


#include"MagicNumber.h"
#include"Kim/KimConfig.h"


namespace bm88 {

	inline
	kim::kim_int32 GetMajorVersion()
	{
		return MN_BM88MAJORVERSION;
	};

	inline
	kim::kim_int32 GetMinorVersion()
	{
		return MN_BM88MINORVERSION;
	};

	inline
	kim::kim_int32 GetVersion()
	{
		return ((GetMajorVersion() << 16) | GetMinorVersion());
	};

};


