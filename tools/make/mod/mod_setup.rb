# -*- coding: cp932 -*-

require "mod_utils.rb"
require "pathname"
require "win32/registry"


class SetupUtils

	#---
	# .svn フォルダをコピーしない
	def SetupUtils.copy_entry(src, dest)
		MakeUtils.find_ignore_spdir(src) { |path|
			if(path == src) then next end
			if File.directory?(path)
				name = File.basename(path)
				puts "#{src}/#{name} -> #{dest}/#{name}"
				MakeUtils.mkdir_p("#{dest}/#{name}")
				SetupUtils.copy_entry("#{src}/#{name}", "#{dest}/#{name}")
				Find.prune
			else
				puts path
				FileUtils.cp(path, dest)
				yield "#{dest}/#{File.basename(path)}" if block_given?
			end
		}
	end

end

#---
# NSIS による実装
class NSIS
public
	attr_reader :archiver

	#---
	def initialize(archiver)
		@archiver = archiver
		@compiler_path = ''
		@header_comment = <<EOT
;---
; このファイルは #{$PROGRAM_NAME} によって自動生成されました。
;

EOT

		find_compiler_path
	end

	#---
	def compile_rom_version(type)
		update_script(type)
		make_components_files(type, true)
		nsis_compile(type)
	end

	#---
	def compile(type)
		update_script(type)
		make_components_files(type, false)
		nsis_compile(type)
	end

	#---
	# アーカイバの作業用パスに間借りさしてもらう
	# まぁ問題ないだろう。
	def work_dir_path
		return "#{@archiver.work_dir}/nsis_src"
	end

	#---
	# NSIS テンプレートやヘッダがある場所
	def nsis_module_dir_path
		return "./mod"
	end

	#---
	def source_file_path
		return "#{work_dir_path}/setup_master.nsi"
	end

	#---
	# 出力先パス
	def dist_dir_path
		return "#{@archiver.root_dir}/dist"
	end

	#---
	# setup.exe 出力先
	def setup_dir_path
		return "#{dist_dir_path}/#{@archiver.target_name}/#{File.basename(@archiver.work_dir)}"
	end

	#---
	# rom 版時のバイナリ出力先
	def rom_bin_dir_path
		return "#{setup_dir_path}/bin"
	end

	#---
	def setup_title(type)
		if type == 'master'
			return "#{@archiver.config['PRODUCTINFO']['name']}"
		end
		return "#{@archiver.config['PRODUCTINFO']['name']} 更新ファイル(Version #{@archiver.major_version}.#{@archiver.minor_version})"
	end

private

	#---
	# コンパイラのパスを探して compiler_path を初期化する
	def find_compiler_path
		Win32::Registry::HKEY_LOCAL_MACHINE.open("SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Uninstall") { |reg|
			reg.each_key { |key, wtime|
                #puts "debug = #{key}"
				if key !~ /NSIS/ then next end
				Win32::Registry::HKEY_LOCAL_MACHINE.open("#{reg.keyname}\\#{key}") { |nsis|
					@compiler_path = "\"#{nsis['InstallLocation'].gsub!(/\\/, '/')}/makensisw.exe\""
				}
			}
		}
        if @compiler_path == ""
            Win32::Registry::HKEY_LOCAL_MACHINE.open("SOFTWARE\\WOW6432Node\\Microsoft\\Windows\\CurrentVersion\\Uninstall") { |reg|
                reg.each_key { |key, wtime|
                    #puts "debug = #{key}"
                    if key !~ /NSIS/ then next end
                    Win32::Registry::HKEY_LOCAL_MACHINE.open("#{reg.keyname}\\#{key}") { |nsis|
                        @compiler_path = "\"#{nsis['InstallLocation'].gsub!(/\\/, '/')}/makensisw.exe\""
                    }
                }
            }
        end
	end

	#---
	def update_script(type)
		MakeUtils.mkdir_p(work_dir_path)
		MakeUtils.mkdir_p(setup_dir_path)

		src = ''
		if type == 'master'
			src = "#{nsis_module_dir_path}/setup_master.nsi.template"
		else
			src = "#{nsis_module_dir_path}/setup_update.nsi.template"
		end

		if FileUtils.uptodate?(src, ["#{source_file_path}"])
			make_main_file(src)
			make_configure_file(type)
		end
	end

	#---
	def nsis_compile(type)
		# コンパイル
		cmd = "#{@compiler_path} #{source_file_path}"
		puts cmd
		`#{cmd}`

		if type == 'master'
			add_bin_dir = "#{@archiver.package_dir}/master"
		else
			add_bin_dir = "#{@archiver.package_dir}/update"
		end

		# 追加のバイナリコピー
		SetupUtils.copy_entry(add_bin_dir, setup_dir_path) { |path|
			case File.basename(path, '.*').downcase
			# ファイル名が readme.* の場合はタグを変換する
			when 'readme'
				@archiver.make_readme_text(path)
			end
		}
	end

	#---
	def make_main_file(template)
		puts "make #{source_file_path} from #{template}"
		File.open("#{source_file_path}", "w") { |file|
			bom = %w(EF BB BF).map { |e| e.hex.chr }.join
			file.write(bom)
			file << "Unicode true\n"
			file << @header_comment.encode("UTF-8")
			file << "!verbose 3\n\n".encode("UTF-8")

			tmp = File.readlines(template)
			tmp.each { |line|
				file << line
			}
		}
	end

	#---
	def make_configure_file(type)
		config = @archiver.config
		version_dword = (((@archiver.major_version.to_i & 0xFF) << 24) | ((@archiver.minor_version.to_i & 0xFF) << 16))
		File.open("#{work_dir_path}/configure.nsh", "w") { |file|
			file << @header_comment.encode("UTF-8")
			file << "!ifndef GUARD_CONFIGURE_NSH\n".encode("UTF-8")
			file << "!define GUARD_CONFIGURE_NSH\n".encode("UTF-8")
			file << "\n"
			file << "!verbose 3\n".encode("UTF-8")
			file << "\n"
			file << "!define UPDATE_NUMBER\t#{config['UPDATEINFO']['high'].to_i}\n".encode("UTF-8")
			file << "\n"
			file << "!define MAJOR_VERSION\t#{@archiver.major_version}\n".encode("UTF-8")
			file << "!define MINOR_VERSION\t#{@archiver.minor_version}\n".encode("UTF-8")
			file << "!define VERSION_DWORD\t#{sprintf("%#010x", version_dword)}\n".encode("UTF-8")
			file << "\n"
			file << "!define TOP_DIR\t\t\"#{get_work_dir_path_base_relative_path('.')}\"\n".encode("UTF-8")
			file << "!define ROOT_DIR\t\"#{get_work_dir_path_base_relative_path(@archiver.root_dir)}\"\n".encode("UTF-8")
			file << "!define MODNSIS_DIR\t\"${TOP_DIR}\\mod\"\n".encode("UTF-8")
			file << "\n"
			file << "!define PUBLISHER\t\"#{config['VENDERINFO']['publisher']}\"\n".encode("UTF-8")
			file << "!define VENDER\t\t\"#{config['VENDERINFO']['name']}\"\n".encode("UTF-8")
			file << "!define VENDER_J\t\"#{config['VENDERINFO']['name_j']}\"\n".encode("UTF-8")
			file << "!define VENDER_URL\t\"#{config['VENDERINFO']['url']}\"\n".encode("UTF-8")
			file << "!define PRODUCT\t\t\"#{@archiver.name}\"\n".encode("UTF-8")
			file << "!define PRODUCT_J\t\"#{config['PRODUCTINFO']['name']}\"\n".encode("UTF-8")
			file << "!define PRODUCT_ID\t\"#{config['PRODUCTINFO']['id']}\"\n".encode("UTF-8")
			file << "!define PRODUCT_URL\t\"#{config['PRODUCTINFO']['url']}\"\n".encode("UTF-8")
			file << "!define SUPPORT_URL\t\"#{config['VENDERINFO']['support_url']}\"\n".encode("UTF-8")
			file << "\n"
			file << "!define TARGET_NAME\t\t\"#{@archiver.target_name}\"\n".encode("UTF-8")
			file << "\n"
			file << "!define USE_ALLUSERS\t0\n".encode("UTF-8")
			file << "\n"
			file << "!define SETUP_TITLE\t\"#{setup_title(type)}\"\n".encode("UTF-8")
			file << "\n"
			file << "!include \"${MODNSIS_DIR}\\mod_nsis.nsh\"\n".encode("UTF-8")
			file << "\n"
			file << "OutFile \"${ROOT_DIR}\\dist\\${TARGET_NAME}\\\\#{File.basename(@archiver.work_dir)}\\GameInstaller.exe\"\n".encode("UTF-8")
			file << "\n"
			file << "!endif\n".encode("UTF-8")
			file << ("\n" * 2)
		}
	end

	#---
	# install_components と uninstall_components の作成
	def make_components_files(type, rom_ver = false)
		MakeUtils.mkdir_p(rom_bin_dir_path) if rom_ver

		# リスト作成
		components = []
		bin_size = 0
		Find.find(@archiver.bin_dir) { |path|
			if @archiver.bin_dir == path then next end
			# debug.* はセットアップしない
			if File.basename(path, '.*').downcase =~ /^debug/ then next end

			puts path

			target = path.clone
			target[@archiver.bin_dir] = rom_bin_dir_path

			components << target.sub(/#{rom_bin_dir_path}\//, '')

			if rom_ver
				# ターゲットソースがフォルダならばサブフォルダ作成
				if File.directory?(path)
					MakeUtils.mkdir_p(target)
					next
				end
				MakeUtils.copy_to(path, target)
				bin_size += File.size(target)
			end
		}

		bin_size = nil if !rom_ver

		shortcuts = make_install_components(type, components, bin_size)

		# パッチの場合必要ない
		if type == 'master'
			make_uninstall_components(components, shortcuts)
		end
	end

	#---
	# 作成したショートカットのリストを返す
	def make_install_components(type, list, total_size = nil)
		shortcuts = []
		File.open("#{work_dir_path}/install_components", "w") { |file|
			# TODO: \ マークを / に変換
			# フォルダかどうか調べる
			if total_size == nil
				# アーカイブバージョン
				list.each { |fn|
					fn.gsub!('/', '\\')
					file << "File \"#{get_work_dir_path_base_relative_path(@archiver.bin_dir)}\\#{fn}\"\n".encode("UTF-8")
					if type != 'master'
						file << "MorningNightcap::AddExternalIndex $IndexFile \"F\" \"$ProductDir#{fn}\"\n".encode("UTF-8")
					end
				}
			else
				# ROM バージョン
				file << "AddSize #{total_size >> 10}\n".encode("UTF-8")
				list.each { |fn|
					fn.gsub!('/', '\\')
					file << "${SafeFileCopy} \"$EXEDIR\\bin\\#{fn}\" \"$ProductDir\\#{fn}\"\n".encode("UTF-8")
					if File.extname(fn).downcase == ".sig"
						file << "SetFileAttributes \"$ProductDir\\#{fn}\" HIDDEN\n".encode("UTF-8")
					end
					if type != 'master'
						file << "MorningNightcap::AddExternalIndex $IndexFile \"F\" \"$ProductDir#{fn}\"\n".encode("UTF-8")
					end
				}
			end
		}

		File.open("#{work_dir_path}/install_shortcutitems", "w") { |file|
			list.each { |fn|
				case File.extname(fn).downcase
				when ".exe"
					if File.basename(fn, ".*") != "krkr"
						fn.gsub!('/', '\\')
						lnk = "#{File.basename(fn, ".*")}.lnk"
						file << "CreateShortCut \"${SM_PRODUCT}\\#{lnk}\" \"$ProductDir\\#{fn}\"\n".encode("UTF-8")
						shortcuts << lnk
					end
				end
			}
		}

		return shortcuts
	end

	#---
	def make_uninstall_components(components, shortcuts)
		File.open("#{work_dir_path}/uninstall_components", "w") { |file|
			file << "${SafeDelete} \"$ProductDir\\krenvprf.kep\"\n".encode("UTF-8")
			components.reverse_each { |fn|
				fn.gsub!('/', '\\')
				file << "${SafeDelete} \"$ProductDir\\#{fn}\"\n".encode("UTF-8")
			}
		}

		File.open("#{work_dir_path}/uninstall_shortcutitems", "w") { |file|
			shortcuts.reverse_each { |fn|
				fn.gsub!('/', '\\')
				file << "${SafeDelete} \"${SM_PRODUCT}\\#{fn}\"\n".encode("UTF-8")
			}
		}
	end

	#---
	def get_work_dir_path_base_relative_path(relative_path)
		# FIXME:relative_path が相対パスじゃなかったらトチる
		base = Pathname.new(work_dir_path)
		path = Pathname.new(relative_path)
		obj = path.relative_path_from(base)
		return obj.to_s.gsub('/', '\\')
	end

end

#---
# セットアップコンパイラ
class SetupCompiler

	#---
	def SetupCompiler.nsis(archiver)
		obj = NSIS.new(archiver)

		if block_given?
			return yield(obj)
		end

		return obj
	end

end


