/**
 * $Revision: 161 $
**/


#if !defined(GUARD_KIMASSERT_H)
#define GUARD_KIMASSERT_H

#include"KimConfig.h"
#include<assert.h>

namespace kim {

	template<bool> struct compile_time_assertion;
	template<> struct compile_time_assertion<true>	{};

};

#define KIM_STATIC_ASSERT(expr)		KIM_UNUSED(sizeof(kim::compile_time_assertion<(expr) != 0>));
#define KIM_STATIC_ASSERT2(expr, msg)						\
	kim::compile_time_assertion<(expr) != 0> ERROR_##msg;	\
	KIM_UNUSED(ERROR_##msg)

#define KIM_ASSERT(expr)			assert(expr)


#endif	/* GUARD_KIMASSERT_H */


