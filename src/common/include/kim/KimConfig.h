/**
 * $Revision: 161 $
**/


#if !defined(GUARD_KIMCONFIG_H)
#define GUARD_KIMCONFIG_H

#if defined(DEBUG) || defined(_DEBUG)
#  if defined(NDEBUG)
#    undef NDEBUG
#  endif
#else
#  if !defined(NDEBUG)
#    define NDEBUG
#  endif
#endif

#if defined(UNICODE) || defined(_UNICODE)
#  define KIM_UNICODE
#endif

#if !defined(WIN32) && !defined(WINDOWS) && !defined(_WINDOWS)
#  error "-DWIN32 should be employed."
#endif

#if defined(_MSC_VER)	// For MicroSoft Visual C++
#  if(_MSC_VER < 1300)
#    error "VC++ 7.0 or later is necessary to compile"
#  endif

#  define KIM_MSVC_COMPILER

#  define KIM_HAS_INT64
#  define KIM_NORETURN	__declspec(noreturn) void

#  if(_MSC_VER < 1310)
#    define KIM_W64
#  endif	// _MSC_VER < 1310

#  if(_MSC_VER >= 1300)	// VC7 or later
#  endif	// _MSC_VER >= 1300

#  if(_MSC_VER >= 1310)	// VC7.1 or later
#    define KIM_POSSIBLE_TEMPLATE_PARAMETERS_IN_TEMPLATE
#    define KIM_HAS_ISO_CPLUS2_CRT
#    define KIM_W64		__w64
#  endif	// _MSC_VER >= 1310

#  if(_MSC_VER >= 1400)	// VC8.0 or later
#    define KIM_HAS_SECURE_CRT
#  endif	// _MSC_VER >= 1400

#  if defined(_MT)		// Using Multi-Thread liblary.
#    define KIM_USING_MT_LIBLARY
#  endif	// _MT
// End of MSVC++ configure.

#elif defined(__GNUC__)	// For GNU C
#  if(__GNUC__ < 3)
#    error "gcc 3.x or later is necessary to compile."
#  endif

#  define KIM_POSSIBLE_TEMPLATE_PARAMETERS_IN_TEMPLATE

#  if(_FILE_OFFSET_BITS < 64)
#    error "-D_FILE_OFFSET_BITS=64 should be employed."
#  endif

#  define KIM_GNUC_COMPILER

#  define KIM_HAS_LONGLONG
#  define KIM_PACK1			__attribute__((__packed__, __aligned__(1)))
#  define KIM_PACK2			__attribute__((__packed__, __aligned__(2)))
#  define KIM_PACK4			__attribute__((__packed__, __aligned__(4)))
#  define KIM_PACK8			__attribute__((__packed__, __aligned__(8)))
// End of GNU-C configure.

#else	// other compiler
#  error "Sorry. Not wrote config for your compiler."
#endif

#if !defined(KIM_NORETURN)
#  define KIM_NORETURN void
#endif
#if !defined(KIM_W64)
#  define KIM_W64
#endif
#if !defined(KIM_PACK1)
#  define KIM_PACK1
#endif
#if !defined(KIM_PACK2)
#  define KIM_PACK2
#endif
#if !defined(KIM_PACK4)
#  define KIM_PACK4
#endif
#if !defined(KIM_PACK8)
#  define KIM_PACK8
#endif

namespace kim {

#if defined(KIM_MSVC_COMPILER)
	typedef __int8				kim_int8;
	typedef __int16				kim_int16;
	typedef __int32				kim_int32;
	typedef unsigned __int8		kim_uint8;
	typedef unsigned __int16	kim_uint16;
	typedef unsigned __int32	kim_uint32;
	typedef __wchar_t			kim_wchar;	// __wchar_t is always built-in type.
#elif defined(__GNUC__)
	typedef char				kim_int8;
	typedef short				kim_int16;
	typedef int					kim_int32;
	typedef unsigned char		kim_uint8;
	typedef unsigned short		kim_uint16;
	typedef unsigned int		kim_uint32;
	typedef wchar_t				kim_wchar;
#endif

typedef char					kim_achar;

#if defined(KIM_HAS_INT64)
	typedef __int64				kim_int64;
	typedef unsigned __int64	kim_uint64;
#elif defined(KIM_HAS_LONGLONG)
	typedef long long			kim_int64;
	typedef unsigned long long	kim_uint64;
#else
#  error "It doesn't have a 64-bit variable in your compiler."
#endif

#if defined(_WIN64)
	typedef kim_int64				kim_w64int;
	typedef kim_int64				kim_w64long;
	typedef kim_uint64				kim_w64uint;
	typedef kim_uint64				kim_w64ulong;
	typedef kim_int64				kim_native;
#else
	typedef int KIM_W64				kim_w64int;
	typedef long KIM_W64			kim_w64long;
	typedef unsigned int KIM_W64	kim_w64uint;
	typedef unsigned long KIM_W64	kim_w64ulong;
	typedef kim_int32 KIM_W64		kim_native;
#endif	/* _WIN64 */

	typedef kim_uint8				kim_byte;
	typedef kim_uint16				kim_word;
	typedef kim_uint32				kim_dword;
	typedef kim_uint64				kim_qword;

#if defined(KIM_MSVC_COMPILER)
	typedef kim_w64uint				kim_size;
	typedef kim_w64int				kim_off;
#elif defined(KIM_GNUC_COMPILER)
	typedef kim_w64uint				kim_size;
	typedef kim_int64				kim_off;
#endif

#define KIM_STRDUMP16(ptr)		((kim_word)(*(kim_word*)(ptr)))
#define KIM_STRDUMP32(ptr)		((kim_dword)(*(kim_dword*)(ptr)))
#define KIM_STRDUMP64(ptr)		((kim_qword)(*(kim_qword*)(ptr)))

#define KIM_TAG(name)			tag_##name
#define KIM_TAG_A(name)			tag_##name##_a
#define KIM_TAG_W(name)			tag_##name##_w

#define KIM_WT(text)			L##text
#define KIM_AT(text)			text

#define KIM_UNUSED(v)			(void)v

#define KIM_ARRAY_COUNT(a)		(kim::kim_size)(sizeof(a)/sizeof(a[0]))

}


#endif	/* GUARD_KIMCONFIG_H */


