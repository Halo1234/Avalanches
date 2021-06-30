/**
 * $Revision: 148 $
**/


#ifndef GUARD_TEXTBASEDFILE_H
#define GUARD_TEXTBASEDFILE_H


#include"kim/KimFile.h"
#include<string>
#include<vector>

namespace impl {

	typedef kim::kim_achar							fchar_type;
	typedef std::basic_string<fchar_type>			fname_type;
	typedef kim::details::file_methods<fchar_type>	fmethods;
	typedef kim::file<fmethods>						file_type;

	/**/
	class CharacterConvertor
	{
	public:
		typedef kim::kim_wchar				char_type;
		typedef std::vector<char_type>		buffer_type;

		typedef kim::kim_achar				mbchar_type;
		typedef std::vector<mbchar_type>	mbbuffer_type;

	public:
		static
		const mbchar_type* ToSJIS(const buffer_type &wide, mbbuffer_type &mb);
		static
		const mbchar_type* ToSJIS(const buffer_type::value_type *wide, buffer_type::size_type size, mbbuffer_type &mb);

		static
		const char_type* JISTo(const mbbuffer_type &mb, buffer_type &wide);
		static
		const char_type* JISTo(const mbbuffer_type::value_type *mb, mbbuffer_type::size_type size, buffer_type &wide);
		static
		const char_type* EUCJPTo(const mbbuffer_type &mb, buffer_type &wide);
		static
		const char_type* EUCJPTo(const mbbuffer_type::value_type *mb, mbbuffer_type::size_type size, buffer_type &wide);
		static
		const char_type* SJISTo(const mbbuffer_type &mb, buffer_type &wide);
		static
		const char_type* SJISTo(const mbbuffer_type::value_type *mb, mbbuffer_type::size_type size, buffer_type &wide);
		static
		const char_type* UTF8To(const mbbuffer_type &mb, buffer_type &wide);
		static
		const char_type* UTF8To(const mbbuffer_type::value_type *mb, mbbuffer_type::size_type size, buffer_type &wide);
		static
		const char_type* UTF16To(const buffer_type &src, buffer_type &dest);
		static
		const char_type* UTF16To(const buffer_type::value_type *mb, buffer_type::size_type size, buffer_type &wide);
		static
		const char_type* UTF16BETo(const buffer_type &be, buffer_type &le);
		static
		const char_type* UTF16BETo(const buffer_type::value_type *be, buffer_type::size_type size, buffer_type &le);
	};

	namespace details {

		/**/
		void LoadUTF16(file_type &file, CharacterConvertor::buffer_type &buffer);

	}

	/**/
	class LineBuffer
	{
	public:
		typedef CharacterConvertor::char_type		char_type;
		typedef CharacterConvertor::buffer_type		buffer_type;

		typedef CharacterConvertor::mbchar_type		mbchar_type;
		typedef CharacterConvertor::mbbuffer_type	mbbuffer_type;

	public:
		LineBuffer()
		{};
		LineBuffer(const LineBuffer &rhs)
		{
			Assign(rhs);
		};
		LineBuffer(const char_type *rhs)
		{
			Assign(rhs);
		};
		LineBuffer(const mbchar_type *rhs)
		{
			Assign(rhs);
		};
		~LineBuffer()
		{};

		void Clear()
		{
			buffer_.clear();
		};

		template<class TIter>
		void Trim(const TIter &s, const TIter &e)
		{
			buffer_.clear();
			buffer_.insert(buffer_.begin(), s, e);
			if(buffer_.back() != KIM_WT('\0'))
				buffer_.push_back(KIM_WT('\0'));
		};
		LineBuffer& Assign(const LineBuffer &rhs)
		{
			buffer_ = rhs.buffer_;
			return (*this);
		};
		LineBuffer& Assign(const char_type *rhs);
		LineBuffer& Assign(const mbchar_type *rhs);

		LineBuffer& Append(const LineBuffer &rhs)
		{
			buffer_.pop_back();
			buffer_.insert(
				buffer_.end(),
				rhs.buffer_.begin(),
				rhs.buffer_.end()
			);
			return (*this);
		};
		LineBuffer& Append(const char_type *rhs)
		{
			return Append(LineBuffer(rhs));
		};
		LineBuffer& Append(const mbchar_type *rhs)
		{
			return Append(LineBuffer(rhs));
		};

		kim::kim_int32 Compara(const LineBuffer &rhs);
		kim::kim_int32 Compara(const char_type *rhs);
		kim::kim_int32 Compara(const mbchar_type *rhs);

		template<class T>
		LineBuffer& operator=(const T &rhs)
		{
			return Assign(rhs);
		};

		operator const char_type*() const
		{
			if(buffer_.empty())
				return KIM_WT("");
			return &buffer_[0];
		};
		operator const mbchar_type*() const
		{
			static mbbuffer_type buf;
			return CharacterConvertor::ToSJIS(buffer_, buf);
		};

	private:
		buffer_type	buffer_;
	};

	inline
	LineBuffer operator+(const LineBuffer &lhs, const LineBuffer &rhs)
	{
		return LineBuffer(lhs).Append(rhs);
	};
	inline
	LineBuffer& operator+=(LineBuffer &lhs, const LineBuffer &rhs)
	{
		return lhs.Append(rhs);
	};

}

#endif	/* GUARD_TEXTBASEDFILE_H */


