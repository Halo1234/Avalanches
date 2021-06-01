/**
 * $Revision: 161 $
**/


#if !defined(GUARD_KIMEXCEPTION_H)
#define GUARD_KIMEXCEPTION_H

#include"KimAssert.h"
#include<string>


#define KIM_DEF_EXCEPTION(name, type, code, msg)							\
	namespace details {														\
		class KIM_TAG_NAME(name) : public ExceptionBase<type> {				\
		public:																\
			typedef ExceptionBase<type>		inherited;						\
			enum { error_code = code };										\
		public:																\
			KIM_TAG_NAME(name)(const inherited::char_type *message = msg) :	\
				ExceptionBase<type>(message) {};							\
			kim_error type_of_error() const									\
				{ return static_cast<kim_error>(error_code); };				\
		};}
#define KIM_DEF_EXCEPTION_HELPER(name)												\
	inline KIM_NORETURN name(														\
		const details::KIM_TAG_NAME(name)::inherited::char_type *message = NULL) {	\
		if(message == NULL)															\
			throw details::KIM_TAG_NAME(name)();									\
		else																		\
			throw details::KIM_TAG_NAME(name)(message);								\
	};
#define KIM_DEF_EXCEPTION_A(name, code, msg)				\
	KIM_DEF_EXCEPTION(name, kim_achar, code, KIM_E(msg));	\
	KIM_DEF_EXCEPTION_HELPER(name)
#define KIM_DEF_EXCEPTION_W(name, code, msg)				\
	KIM_DEF_EXCEPTION(name, kim_wchar, code, KIM_E(msg));	\
	KIM_DEF_EXCEPTION_HELPER(name)

#if defined(KIM_UNICODE)
#  define KIM_E(msg)						KIM_WT(msg)
#  define KIM_TAG_NAME(name)				KIM_TAG_W(name)
#  define KIM_DEF_ERROR(name, code, msg)	KIM_DEF_EXCEPTION_W(name, code, msg)
#else
#  define KIM_E(msg)						KIM_AT(msg)
#  define KIM_TAG_NAME(name)				KIM_TAG_A(name)
#  define KIM_DEF_ERROR(name, code, msg)	KIM_DEF_EXCEPTION_A(name, code, msg)
#endif

#define KIM_E_TYPE(name)					const kim::details::KIM_TAG_NAME(name) &
#define KIM_E_TYPE_E(name)					KIM_E_TYPE(name) e
#define KIM_E_WARNING_SHUTOUT				KIM_UNUSED(e)

#define KIM_RAISE							throw
#define KIM_RAISE_(e)						throw (e)
#define KIM_RAISE_E							KIM_RAISE_(e)

namespace kim {

	// Type of error.
	typedef kim_int32				kim_error;

#define KIM_SUCCESSED(err)				(((kim_error)(err)) >= 0)
#define KIM_FAILED(err)					(((kim_error)(err)) < 0)

#define KIM_E_OK						0

#define KIM_E_UNKNOWN					0x80000000
#define KIM_E_INTERNAL					0x80000001

#define KIM_E_STL_TROUBLE				0x80001FFF

#define KIM_E_INVALID_PARAMETERS		0x80008001
#define KIM_E_BUFFER_TOO_SMALL			0x80008002
#define KIM_E_BAD_ACCESS				0x80008003
#define KIM_E_ACCESS_OVERRUN			0x80008004
#define KIM_E_ACCESS_UNDERRUN			0x80008005
#define KIM_E_NOT_SUPPORTED				0x80008006
#define KIM_E_NO_DISK_SPACE				0x80008007
#define KIM_E_NO_MEMORY					0x80008008

#define KIM_E_NOT_FOUND					0x80010011
#define KIM_E_ALREADY_EXIST				0x80010012

#define KIM_E_OPEN_FAILED				0x80011001
#define KIM_E_TOO_MANY_OPEN_FILES		0x80011002

	namespace details {

		/**/
		template<class TChar, class TTraits = std::char_traits<tjs_char> >
		class ExceptionBase
		{
		public:
			typedef TChar										char_type;
			typedef TTraits										char_traits;
			typedef std::basic_string<char_type, char_traits>	message_type;

		public:
			explicit
			ExceptionBase(const char_type *message) :
				message_(message)
			{
			};
			virtual
			~ExceptionBase()
			{
			};

			virtual
			const tjs_char* what() const
			{
				return message_.c_str();
			};
			virtual
			kim_error type_of_error() const
			{
				return KIM_E_OK;
			};

			inline
			bool is_error() const
			{
				return KIM_FAILED(type_of_error());
			};

		private:
			message_type	message_;
		};

		typedef ExceptionBase<kim_achar>	KIM_TAG_A(e_kim);
		typedef ExceptionBase<kim_wchar>	KIM_TAG_W(e_kim);

	};

	KIM_DEF_ERROR(e_ok, KIM_E_OK, "Not a error.");

	KIM_DEF_ERROR(e_unknown, KIM_E_UNKNOWN, "Unknown error.");
	KIM_DEF_ERROR(e_internal, KIM_E_INTERNAL, "Internal error.");

	KIM_DEF_ERROR(e_stl_trouble, KIM_E_STL_TROUBLE, "A STL trouble.");

	KIM_DEF_ERROR(e_invalid_parameters, KIM_E_INVALID_PARAMETERS, "Invalid parameters.");
	KIM_DEF_ERROR(e_buffer_too_small, KIM_E_BUFFER_TOO_SMALL, "Buffer too small.");
	KIM_DEF_ERROR(e_bad_access, KIM_E_BAD_ACCESS, "Bad access.");
	KIM_DEF_ERROR(e_access_overrun, KIM_E_ACCESS_OVERRUN, "Access over-run.");
	KIM_DEF_ERROR(e_access_underrun, KIM_E_ACCESS_UNDERRUN, "Access under-run.");
	KIM_DEF_ERROR(e_not_supported, KIM_E_NOT_SUPPORTED, "Not supported.");
	KIM_DEF_ERROR(e_no_disk_space, KIM_E_NO_DISK_SPACE, "No disk space.");
	KIM_DEF_ERROR(e_no_memory, KIM_E_NO_MEMORY, "Not enough memory.");

	KIM_DEF_ERROR(e_not_found, KIM_E_NOT_FOUND, "Not found.");
	KIM_DEF_ERROR(e_already_exist, KIM_E_ALREADY_EXIST, "Already existed.");

	KIM_DEF_ERROR(e_too_many_open_files, KIM_E_TOO_MANY_OPEN_FILES, "There are a lot of open files.");

};


#endif	/* GUARD_KIMEXCEPTION_H */


