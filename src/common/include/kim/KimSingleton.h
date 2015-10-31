/**
 * $Revision: 157 $
**/


#if !defined(GUARD_KIMSINGLETON_H)
#define GUARD_KIMSINGLETON_H

#include"KimException.h"

namespace kim {
	namespace details {

		/**/
		template <class T>
		struct create_new
		{
			static
			T* create()
			{
				return new T;
			};
			static
			void destroy(T *p)
			{
				delete p;
			}
		};

		/**/
		template <class T>
		struct create_static
		{
			static
			T* create()
			{
				static kim_int8 _t[sizeof(T)];
				return new(_t) T;
			};
			static
			void destroy(T *p)
			{
				p->~T();
			};
		};

#define LIFE_DESTRUCTOR_METHOD	__cdecl

		/**/
		template <class T>
		struct life_normal
		{
			typedef void (LIFE_DESTRUCTOR_METHOD *destructor)(void);

			static
			void set_life(T* /*p*/, destructor fn)
			{
				::atexit(fn);
			};
			static
			void visit_grave()
			{
				e_internal(KIM_E("life_normal::visit_grave() called. The logical error."));
			};
		};

		/**/
		template <class T>
		struct life_no_dead
		{
			typedef void (LIFE_DESTRUCTOR_METHOD *destructor)(void);

			static
			void set_life(T* /*p*/, destructor /*fn*/)
			{};
			static
			void visit_grave()
			{};
		};
	};

	/**/
	template<
		typename T,

#if defined KIM_POSSIBLE_TEMPLATE_PARAMETERS_IN_TEMPLATE
		template <class> class TCreator = details::create_new,
		template <class> class TLife = details::life_normal
#else
		class TCreator = details::create_new<T>,
		class TLife = details::life_normal<T>
#endif

	>
	class singleton
	{

#if defined KIM_POSSIBLE_TEMPLATE_PARAMETERS_IN_TEMPLATE
		typedef TCreator<T>	TCreator_;
		typedef TLife<T>	TLife_;
#else
		typedef TCreator	TCreator_;
		typedef TLife		TLife_;
#endif

		typedef T			value_type;
		typedef T			*pointer_type;

		singleton();

	public:
		static
		T& instance()
		{
			// 一見して常に create() 呼び出しでも良さそうに見えるが
			// 後でマルチスレッドに対応する必要が出た場合に create() の実装はスレッドセーフな
			// 形になるので以下の行は書きかえないこと
			return *(instance_ == NULL ? create() : instance_);
		};

	private:
		static
		pointer_type create()
		{
			if(instance_ == NULL)
			{
				instance_ = TCreator_::create();
				TLife_::set_life(instance_, destroy);
			}
			return instance_;
		};
		static
		void LIFE_DESTRUCTOR_METHOD destroy()
		{
			TCreator_::destroy(instance_);
			instance_ = NULL;
		};

		static
		pointer_type	instance_;
	};
}

#if defined KIM_POSSIBLE_TEMPLATE_PARAMETERS_IN_TEMPLATE
	template<typename T1, template <class> class T2, template <class> class T3>
#else
	template<typename T1, class T2, class T3>
#endif
	typename kim::singleton<T1, T2, T3>::pointer_type kim::singleton<T1, T2, T3>::instance_ = NULL;

#endif	/* GUARD_KIMSINGLETON_H */


