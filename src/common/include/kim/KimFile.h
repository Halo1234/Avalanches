/**
 * $Revision: 157 $
**/


#if !defined(GUARD_KIMFILE_H)
#define GUARD_KIMFILE_H

#include"KimException.h"
#include<string>

#include<io.h>
#include<fcntl.h>
#include<sys/stat.h>

#if defined(KIM_MSVC_COMPILER)
#  include<errno.h>
#  include<share.h>
#endif

#define FILE_ERROR_(e)								\
	switch((e)) {
#define FILE_ERROR									FILE_ERROR_(errno)
#define FILE_END_OF_ERROR_(unknown_error_message)	\
	FILE_E_UNKNOWN_(unknown_error_message);			\
	}
#define FILE_END_OF_ERROR							FILE_END_OF_ERROR_(NULL)

#define FILE_E_UNKNOWN_(msg)			\
	default: kim::e_unknown(msg)
#define FILE_E_EXCPT(code, excpt, msg)	\
	case (code): kim::excpt(msg)

#define FILE_EACCES__(excpt, msg)		FILE_E_EXCPT(EACCES, excpt, msg)
#define FILE_ENOENT__(excpt, msg)		FILE_E_EXCPT(ENOENT, excpt, msg)
#define FILE_EINVAL__(excpt, msg)		FILE_E_EXCPT(EINVAL, excpt, msg)
#define FILE_EEXIST__(excpt, msg)		FILE_E_EXCPT(EEXIST, excpt, msg)
#define FILE_EMFILE__(excpt, msg)		FILE_E_EXCPT(EMFILE, excpt, msg)
#define FILE_EBADF__(excpt, msg)		FILE_E_EXCPT(EBADF, excpt, msg)
#define FILE_ENOSPC__(excpt, msg)		FILE_E_EXCPT(ENOSPC, excpt, msg)
#define FILE_EFAULT__(excpt, msg)		FILE_E_EXCPT(EFAULT, excpt, msg)
#define FILE_ENAMETOOLONG__(excpt, msg)	FILE_E_EXCPT(ENAMETOOLONG, excpt, msg)
#define FILE_ENOMEM__(excpt, msg)		FILE_E_EXCPT(ENOMEM, excpt, msg)
#define FILE_ENOTDIR__(excpt, msg)		FILE_E_EXCPT(ENOTDIR, excpt, msg)
#define FILE_EISDIR__(excpt, msg)		FILE_E_EXCPT(EISDIR, excpt, msg)
#define FILE_ENFILE__(excpt, msg)		FILE_E_EXCPT(ENFILE, excpt, msg)
#define FILE_ENXIO__(excpt, msg)		FILE_E_EXCPT(ENXIO, excpt, msg)
#define FILE_EPERM__(excpt, msg)		FILE_E_EXCPT(EPERM, excpt, msg)
#define FILE_EROFS__(excpt, msg)		FILE_E_EXCPT(EROFS, excpt, msg)

#define FILE_EACCES_(msg)				FILE_EACCES__(e_bad_access, msg)
#define FILE_ENOENT_(msg)				FILE_ENOENT__(e_not_found, msg)
#define FILE_EINVAL_(msg)				FILE_EINVAL__(e_invalid_parameters, msg)
#define FILE_EEXIST_(msg)				FILE_EEXIST__(e_already_exist, msg)
#define FILE_EMFILE_(msg)				FILE_EMFILE__(e_too_many_open_files, msg)
#define FILE_EBADF_(msg)				FILE_EBADF__(e_invalid_parameters, msg)
#define FILE_ENOSPC_(msg)				FILE_ENOSPC__(e_no_disk_space, msg)
#define FILE_EFAULT_(msg)				FILE_EFAULT__(e_bad_access, msg)
#define FILE_ENAMETOOLONG_(msg)			FILE_ENAMETOOLONG__(e_invalid_parameters, msg)
#define FILE_ENOMEM_(msg)				FILE_ENOMEM__(e_no_memory, msg)
#define FILE_ENOTDIR_(msg)				FILE_ENOTDIR__(e_not_found, msg)
#define FILE_EISDIR_(msg)				FILE_EISDIR__(e_bad_access, msg)
#define FILE_ENFILE_(msg)				FILE_ENFILE__(e_too_many_open_files, msg)
#define FILE_ENXIO_(msg)				FILE_ENXIO__(e_not_found, msg)
#define FILE_EPERM_(msg)				FILE_EPERM__(e_bad_access, msg)
#define FILE_EROFS_(msg)				FILE_EROFS__(e_bad_access, msg)

#define FILE_EACCES						FILE_EACCES_(NULL)
#define FILE_ENOENT						FILE_ENOENT_(NULL)
#define FILE_EINVAL						FILE_EINVAL_(NULL)
#define FILE_EEXIST						FILE_EEXIST_(NULL)
#define FILE_EMFILE						FILE_EMFILE_(NULL)
#define FILE_EBADF						FILE_EBADF_(KIM_E("Invalid file descriptor."))
#define FILE_ENOSPC						FILE_ENOSPC_(NULL)
#define FILE_EFAULT						FILE_EFAULT_(KIM_E("Bad address."))
#define FILE_ENAMETOOLONG				FILE_ENAMETOOLONG_(KIM_E("File name too long."))
#define FILE_ENOMEM						FILE_ENOMEM_(NULL)
#define FILE_ENOTDIR					FILE_ENOTDIR_(KIM_E("Not a directory."))
#define FILE_EISDIR						FILE_EISDIR_(KIM_E("Is a directory."))
#define FILE_ENFILE						FILE_ENFILE_(KIM_E("Too many files open in system."))
#define FILE_ENXIO						FILE_ENXIO_(KIM_E("No such device or address."))
#define FILE_EPERM						FILE_EPERM_(KIM_E("Operation not permmitted."))
#define FILE_EROFS						FILE_EROFS_(KIM_E("Read only file system."))

#if defined(KIM_MSVC_COMPILER)
#  define S_IRUSR	S_IREAD
#  define S_IWUSR	S_IWRITE
#  define S_IXUSR	S_IEXEC
#  define S_IRWXU	((S_IRUSR) | (S_IWRITE) | (S_IEXEC))
#endif

namespace kim {
	namespace details {

#if defined(KIM_MSVC_COMPILER)
		typedef kim_size		fsize_type;
		typedef kim_int64		foffs_type;
		typedef kim_int64		ftime_type;
		typedef struct __stat64	stat_type;
#elif defined(KIM_GNUC_COMPILER)
		typedef kim_size	fsize_type;
		typedef kim_off		foffs_type;
		typedef time_t		ftime_type;
		typedef struct stat	stat_type;
#endif

		/**/
		inline
		bool kim_stat(const char *pathname, stat_type &buffer)
		{
#if defined(KIM_MSVC_COMPILER)
			if(::_stat64(pathname, &buffer) != 0)
#elif defined(KIM_GNUC_COMPILER)
			if(::stat(pathname, &buffer) != 0)
#endif
			{
				if(errno == ENOENT)
					return false;

				FILE_ERROR
					FILE_ENOENT;	// dummy.
				FILE_END_OF_ERROR_(KIM_E("kim_stat() failed."))
			}

			return true;
		};

		/**/
		inline
		kim::kim_int32 kim_open(const char *pathname, kim::kim_native flags, kim::kim_native mode)
		{
			kim::kim_int32 fd;

#if defined(KIM_HAS_SECURE_CRT)
			if(::_sopen_s(&fd, pathname, flags, _SH_DENYRW, mode) != 0)
#else
			fd = ::open(pathname, (int)flags, (int)mode);
			if(fd == -1)
#endif
			{
				FILE_ERROR
					FILE_EACCES;
					FILE_ENOENT;
					FILE_EINVAL;
					FILE_EEXIST;
					FILE_EMFILE;
				FILE_END_OF_ERROR_(KIM_E("kim_open() failed."));
			}

			return fd;
		};

		/**/
		inline
		void kim_close(kim::kim_int32 fd)
		{
			if(::_close(fd) != 0 && errno != EBADF)
			{
				FILE_ERROR
					FILE_EBADF;	// dummy.
				FILE_END_OF_ERROR_(KIM_E("kim_close() failed."));
			}
		};

		/**/
		inline
		bool kim_fstat(kim::kim_int32 fd, stat_type &buffer)
		{
#if defined(KIM_MSVC_COMPILER)
			if(::_fstat64(fd, &buffer) != 0)
#elif defined(KIM_GNUC_COMPILER)
			if(::fstat(fd, &buffer) != 0)
#endif
			{
				FILE_ERROR
					FILE_EBADF;
				FILE_END_OF_ERROR
			}

			return true;
		};

		/**/
		inline
		foffs_type kim_lseek(kim::kim_int32 fd, foffs_type offset, kim::kim_int32 whence)
		{
			foffs_type o = ::_lseeki64(fd, offset, whence);

			if(o == -1L)
			{
				FILE_ERROR
					FILE_EBADF;
				FILE_END_OF_ERROR
			}

			return o;
		};

		/**/
		inline
		fsize_type kim_read(kim::kim_int32 fd, void *buffer, fsize_type size)
		{
			kim_byte *p = reinterpret_cast<kim_byte*>(buffer);
			fsize_type r = 0;
			kim_int32 ret;

			while(r < size)
			{
				fsize_type n = size - r;

				errno = 0;
				ret = _read(fd, p, static_cast<kim::kim_uint32>(n));

				if(ret == 0)
					break;
				if(ret < -1)
				{
					if(errno == EAGAIN || errno == EINTR)
						continue;

					FILE_ERROR
						FILE_EBADF_(KIM_E("It is not opened for reading or file descriptor is invalid to this file."));
					FILE_END_OF_ERROR_(KIM_E("kim_read() failed."))
				}

				r += ret;
				p += ret;
			}

			return r;
		};

		/**/
		inline
		fsize_type kim_write(kim::kim_int32 fd, const void *buffer, fsize_type size)
		{
			const kim_byte *p = reinterpret_cast<const kim_byte*>(buffer);
			fsize_type r = 0;
			kim_int32 ret;

			while(r < size)
			{
				fsize_type n = size - r;

				errno = 0;
				ret = _write(fd, p, static_cast<kim::kim_uint32>(n));

				if(ret == 0)
					break;
				if(n < 0)
				{
					if(errno == EAGAIN || errno == EINTR)
						continue;

					FILE_ERROR
						FILE_EBADF_(KIM_E("It is not opened for writing or file descriptor is invalid to this file."));
						FILE_ENOSPC;
					FILE_END_OF_ERROR_(KIM_E("kim_write() failed."))
				}

				r += ret;
				p += ret;
			}

			return r;
		};

		/**/
		inline
		void kim_ftruncate(kim::kim_int32 fd, foffs_type length)
		{
#if defined(KIM_HAS_SECURE_CRT)	// Using secure CRT.
			if(_chsize_s(fd, length) != 0)
#else
			kim::kim_uint32 l = (kim_int32)(length & 0x8FFFFFFF);
			if(_chsize(fd, l) != 0)	// o..rz
#endif
			{
				FILE_ERROR
					FILE_EACCES;
					FILE_EBADF_(KIM_E("Is not opened for writing or file descriptor is invalid to this file."));
					FILE_ENOSPC;
				FILE_END_OF_ERROR_(KIM_E("kim_ftruncate() failed."))
			}
		};

		/**/
		inline
		void kim_fsync(kim::kim_int32 fd)
		{
			if(_commit(fd) != 0)
			{
				FILE_ERROR
					FILE_EBADF;
				FILE_END_OF_ERROR_(KIM_E("kim_fsync() failed."))
			}
		};
	}
}

namespace kim {

	namespace details {

		/**/
		template<class TChar, class TTraits = std::char_traits<TChar> >
		class file_methods
		{
		public:
			typedef TChar			char_type;
			typedef TTraits			char_traits;

			typedef kim_int32		descriptor_type;

			typedef details::stat_type	stat_type;
			typedef details::foffs_type	offs_type;
			typedef details::fsize_type	size_type;
			typedef details::ftime_type	time_type;

			enum {
				INVALID_FILE_DESCRIPTOR = -1
			};

		public:
			static inline
			const descriptor_type invalid_file()
			{
				return INVALID_FILE_DESCRIPTOR;
			};
			static inline
			bool is_invalid_file(const descriptor_type &fd)
			{
				return static_cast<bool>(fd == invalid_file());
			};

			// exist()
			static inline
			bool exist(const char_type *pathname)
			{
				static stat_type s;
				return kim_stat(pathname, &s);
			};

			// open()
			static inline
			descriptor_type open(const char_type *pathname, kim_native flags)
			{
				return file_methods::open(pathname, flags, S_IRUSR | S_IWUSR);
			};
			static inline
			descriptor_type open(const char_type *pathname, kim_native flags, kim_native mode)
			{
				return kim_open(pathname, flags, mode);
			};

			// close()
			static inline
			void close(descriptor_type fd)
			{
				if(file_methods::is_invalid_file(fd))
					return;
				kim_close(fd);
			};

			// fstat()
			static inline
			void fstat(descriptor_type fd, stat_type &stat)
			{
				kim_fstat(fd, stat);
			};

			// fsync()
			static inline
			void fsync(descriptor_type fd)
			{
				kim_fsync(fd);
			};

			// position()
			static inline
			offs_type position(descriptor_type fd)
			{
				return file_methods::seek(fd, 0, SEEK_CUR);
			};

			// seek()
			static inline
			offs_type seek(descriptor_type fd, offs_type pos, kim_int32 whence = SEEK_SET)
			{
				return kim_lseek(fd, pos, whence);
			};

			// read()
			static
			size_type read(descriptor_type fd, void *buffer, size_type size)
			{
				return kim_read(fd, buffer, size);
			};

			// write()
			static
			size_type write(descriptor_type fd, const void *buffer, size_type size)
			{
				return kim_write(fd, buffer, size);
			};

			// terminate()
			static
			void terminate(descriptor_type fd)
			{
				kim_ftruncate(fd, position(fd));
			};
			// sync()
			static
			void sync(descriptor_type fd)
			{
				kim_fsync(fd);
			};
		};
	}

	/**/
	template<kim_native TMode, kim_native TUmask = 0>
	struct FileAccessPermission
	{
		enum {
			mode = TMode, umask = TUmask
		};
	};

	typedef FileAccessPermission<
		O_RDONLY | O_BINARY
	>	FileReadOnly;
	typedef FileAccessPermission<
		O_CREAT | O_RDONLY | O_BINARY,
		S_IRUSR | S_IWUSR		// umask 0600
	>	FileReadRW;
	typedef FileAccessPermission<
		O_CREAT | O_WRONLY | O_BINARY,
		S_IRUSR | S_IWUSR		// umask 0600
	>	FileWriteRW;
	typedef FileAccessPermission<
		O_CREAT | O_RDWR | O_BINARY,
		S_IRUSR | S_IWUSR		// umask 0600
	>	FileReadWriteRW;

	/**/
	template<
		class TFileMethods,
		class TDefaultAccessPermission = FileReadWriteRW
	>
	class file
	{
	public:
		typedef TFileMethods						methods;
		typedef TDefaultAccessPermission			default_access_permission;

		typedef typename methods::stat_type			stat_type;
		typedef typename methods::offs_type			offs_type;
		typedef typename methods::size_type			size_type;
		typedef typename methods::time_type			time_type;

		typedef typename methods::descriptor_type	descriptor_type;

		typedef typename methods::char_type					char_type;
		typedef typename methods::char_traits				char_traits;
		typedef std::basic_string<char_type, char_traits>	string_type;

	public:
		file()
		{};
		explicit
		file(
			const char_type *path,
			kim_int32 mode = default_access_permission::mode,
			kim_int32 umask = default_access_permission::umask)
		{
			open(path, mode, umask);
		};
		virtual
		~file()
		{
			try {
				close();
			} catch(KIM_E_TYPE(e_invalid_parameters)) {
			} catch(KIM_E_TYPE(e_kim)) {
			} catch(...) {
			}
		};

		inline
		void open(
			const char_type *pathname,
			kim_int32 mode = default_access_permission::mode,
			kim_int32 umask = default_access_permission::umask)
		{
			fd_ = methods::open(pathname, mode, umask);
			file_name_ = pathname;
			sync();
		};
		inline
		void close()
		{
			if(!opened()) return;
			methods::close(fd_);
			fd_ = methods::invalid_file();
			sync();
		};

		/**/
		bool opened() const
		{
			return !methods::is_invalid_file(fd_);
		};

		/**/
		inline
		offs_type seek(offs_type pos)
		{
			return methods::seek(fd_, pos);
		};
		inline
		offs_type seek_by_offset(offs_type offset)
		{
			if(offset < 0 && (position() + offset) > position())
				return seek(0);	// underflow.
			return seek(position() + offset);
		};
		inline
		offs_type position() const
		{
			return methods::position(fd_);
		};
		inline
		offs_type size() const
		{
			return stat_.st_size;
		};

		/**/
		inline
		size_type read(void *buffer, size_type size)
		{
			return methods::read(fd_, buffer, size);
		};

		/**/
		inline
		size_type write(void const *buffer, size_type size)
		{
			return methods::write(fd_, buffer, size);
		};
		inline
		void terminate()
		{
			methods::terminate(fd_);
		};

		/**/
		inline
		void sync()
		{
			if(opened())
			{
				methods::sync(fd_);
				methods::fstat(fd_, stat_);
			}
			else
			{
				::memset(&stat_, 0, sizeof(stat_));
				file_name_.clear();
			}
		};

	private:
		string_type		file_name_;
		descriptor_type	fd_;
		stat_type		stat_;
	};

	typedef details::file_methods<kim_achar>	FileMethods;
//	typedef details::file_methods<kim_wchar>	FileMethodsW;

	typedef file<FileMethods>	File;
//	typedef file<FileMethodsW>	FileW;

}

#endif	/* GUARD_KIMFILE_H */


