# -*- coding: cp932 -*-

require "mod_utils.rb"


class XP3AUtils

	def XP3AUtils.normalize(path)
		# / で始まる場合は削除しておく
		work = path.gsub(/^(\\|\/)/, '')
		# path の内容を変更する
		work.gsub(/\//, '_')
	end

	#---
	# path から version 情報を抜き出す
	# version 情報が見つからなかった場合は nil を返す
	# それ以外は 'x.y' 形式でバージョン文字列を返す
	def XP3AUtils.extract_version_string(path, version_encoding)
		major = nil
		minor = nil
		Encoding.default_external = version_encoding
		lines = File.readlines(path)

		# version タグを探す
		reg = /(@version .*|\[version [^\[]*\])/
		lines.each { |line|
			if(line =~ reg)
				tag = $1
				tag =~ /major=(\d*).*minor=(\d*)/
				major = $1
				minor = $2
			end
		}

		return (major == nil && minor == nil ? nil : "#{major}.#{minor}")
	end

end

#---
# XP3 コンポーネント基本
class XP3ComponentBase
public
	attr_reader :name, :update

	def initialize(name, source_dir_path, work_dir_path)
		@name = name
		@source_dir_path = source_dir_path
		@work_dir_path = work_dir_path
		@update = false
	end

	def collect(&block)
		MakeUtils.mkdir_p(collect_dir_path)
		if(@name == 'bin')
			@update = binary_collect(@source_dir_path, get_targets(@source_dir_path), &block)
		else
			@update = archive_source_collect(@source_dir_path, get_targets(@source_dir_path), &block)
		end
	end

	def get_targets(source_dir)
		# TODO: オーバーライドすること
		nil
	end

	def collect_dir_path
		"#{@work_dir_path}/#{@name}"
	end

protected
	def archive_source_collect(source_dir, targets, &block)
		# TODO: オーバーライドすること
		false
	end

	def binary_collect(source_dir, targets, &block)
		# TODO: オーバーライドすること
		false
	end
end

#---
class XP3LocalComponent < XP3ComponentBase
public
	#---
	def initialize(name, source_dir_path, targets, work_dir_path)
		super(name, source_dir_path, work_dir_path)
		@targets = targets
	end

	#---
	def get_targets(source_dir)
		@targets
	end

	#---
	# フォルダ階層は維持しない
	# 例えば、#{source_dir}/example/data1.bmp というファイルがあった場合
	# #{collect_dir_path}/example_data1.bmp と変更される
	def archive_source_collect(source_dir, targets, &block)
		update = false
		@targets.each { |t|
			if t == 'data'
				MakeUtils.find_ignore_subdir(source_dir) { |path|
					update = MakeUtils.copy_to(path, "#{collect_dir_path}/#{File.basename(path)}") || update
				}
				next
			end

			work = "#{source_dir}/#{t}"
			MakeUtils.find_ignore_spdir(work) { |path|
				if File.directory?(path) then next end
				dest = "#{collect_dir_path}/#{XP3AUtils.normalize(path.gsub(work, ''))}"
				update = MakeUtils.copy_to(path, dest) || update
				yield "#{dest}" if block_given?
			}
		}

		@update = update
	end

	#---
	# フォルダ階層を維持する
	def binary_collect(source_dir, targets, &block)
		update = false
		@targets.each { |t|
			work = "#{source_dir}/#{t}"
			MakeUtils.find_ignore_spdir(work) { |path|
				if work == path then next end

				# 出力パスの生成
				target = path.clone
				target[work] = collect_dir_path

				# ターゲットソースがフォルダならばサブフォルダ作成
				if File.directory?(path)
					update = MakeUtils.mkdir_p(target) || update
					next
				end

				if (r = MakeUtils.copy_to(path, target)) && block_given?
					yield target
				end
				update = r || update
			}
		}

		@update = update
	end

end

class XP3SVNCollector < XP3ComponentBase
public
	#---
	def initialize(name, url, revs, source_dir_path, work_dir_path)
		super(name, source_dir_path, work_dir_path)
		@url = url
		@revs = revs
		@low, @high = revs.split(':')
	end

	#---
	# SVN からターゲットリストを得る
	def get_targets(source_dir)
		full_url = "#{@url}/#{source_dir}"

		puts("Download from #{full_url}##{@revs}")

		# svn log 取得
		cmd = "svn log -r #{@revs} -v --quiet #{full_url}/"
		MakeUtils.puts(cmd)
		svnlog = `#{cmd}`
		#exit 1 if 0 != $?.exitstatus
		svnlog = svnlog.split("\n")
		puts source_dir

		# M(modify) と A(Added) のファイルのみ取り出す
		reg = /\s*[MA]\s*([^\s].*)/
		list = []
		svnlog.each { |line|
			if line =~ reg
				work = $1
				puts work
				# debug フォルダは無視する
				# また場合によっては source_dir に含まれないパスがログに含まれている場合がある
				# その場合は必要なパスのみを取り出す
				if work !~ /\/debug\// && work[1..source_dir.length] == source_dir && work != '/trunk/src/game'
					puts work
					list << work
				end
			end
		}
		list.uniq!

		# svn list 取得
		cmd = "svn list -r #{@high} -R #{full_url}/"
		MakeUtils.puts(cmd)
		svnlist = `#{cmd}`
		#exit 1 if 0 != $?.exitstatus
		svnlist = svnlist.split("\n")

		# フォルダのリストを作る
		# svn list の出力で最後が / で終わっているものはフォルダ
		reg = /(.*)\/$/
		folders = []
		svnlist.each { |line|
			folders << $1 if line =~ reg
		}

		# list からフォルダを削除する
		list.delete_if { |item|
			result = for folder in folders do
				if item[-1] == '/' || item.index(folder) == item.length - folder.length
					break true
				end
			end
			(result == true)
		}
	end

	#---
	def archive_source_collect(source_dir, targets, &block)
		targets.each { |item|
			work = item.sub(/^\/#{source_dir}\/[^\/]*\//, '')
			work = "#{collect_dir_path}/#{XP3AUtils.normalize(work)}"

			cmd = "svn export -r #{@high} \"#{@url}#{item}\" \"#{work}\""
			MakeUtils.puts(cmd)
			`#{cmd}`
			#exit 1 if 0 != $?.exitstatus

			yield "#{work}" if block_given?
		}

		return true
	end

	#---
	def binary_collect(source_dir, targets, &block)
		targets.each { |item|
			MakeUtils.mkdir_p(File.dirname(item))

			work = item.sub(/^\/#{source_dir}/, '')
			work = "#{collect_dir_path}/#{XP3AUtils.normalize(work)}"

			cmd = "svn export -r #{@high} \"#{@url}#{item}\" \"#{work}\""
			MakeUtils.puts(cmd)
			`#{cmd}`
			#exit 1 if 0 != $?.exitstatus

			yield "#{work}" if block_given?
		}
	end

end

class XP3Archiver
public
	attr_reader :name, :target_name
	attr_reader :repository_url, :repository_subset
	attr_reader :root_dir, :work_dir, :package_dir
	attr_reader :major_version, :minor_version

	def initialize(name, target_name)
		@name = name
		@target_name = target_name
		@repository_url = nil
		@repository_subset = nil
		@root_dir = nil
		@work_dir = nil
		@components = []
		@archiver_path = nil
		@archiver_options = nil
		@signer_path = nil
		@signer_options = nil
		@major_version = 0
		@minor_version = 0
	end

	def set_repository_url(url, subset)
		@repository_url = url
		@repository_subset = subset
	end

	def set_local_root_dir(dir)
		@root_dir = dir
	end

	def set_work_dir(dir)
		@work_dir = dir
	end

	def set_package_dir(dir)
		@package_dir = dir
	end

	def set_config(config)
		@config = config
		@config['PRODUCTINFO']['version'] = '0.0'
		@config['PRODUCTINFO']['major_version'] = 0
		@config['PRODUCTINFO']['minor_version'] = 0
	end

	def config
		@config
	end

	#/**
	# * アーカイバに関する設定を行います。
	# *
	# * options に指定できるパラメータの詳細
	# * +------------------+----------------------------------------------------------------+
	# * |             path | アーカイバへの環境ルートからの部分パスです。                   |
	# * | compress_archive | アーカイブ時に圧縮するファイル拡張子を指定します。             |
	# * |    store_archive | アーカイブには含めるが圧縮しないファイル拡張子を指定します。   |
	# * |  discard_archive | アーカイブには含めないファイル拡張子を指定します。             |
	# * |    embed_warning | 0 ならば何もしません。                                         |
	# * |                  | 1 ならばリバースエンジニアリングに対する警告文を埋め込みます。 |
	# * |   use_xp3enc_dll | 0 ならば xp3enc.dll を利用しない。                             |
	# * |                  | 1 ならば xp3enc.dll を利用する。                               |
	# * |             auto | 0 ならばアーカイバを手動で実行します。                         |
	# * |                  | 1 ならばアーカイバを自動で実行します。                         |
	# * +------------------+----------------------------------------------------------------+
	def set_archiver(archiver, options)
		@archiver_path = "#{root_dir}/#{archiver}" if archiver != nil
		@archiver_options = options.clone()
	end

	#/**
	# * サインツールに関する設定を行います。
	# *
	# * options に指定できるパラメータの詳細
	# * +------+------------------------------------------------+
	# * | path | サインツールへの環境ルートからの部分パスです。 |
	# * | auto | 0 ならばサインツールを手動で実行します。       |
	# * |      | 1 ならばサインツールを自動で実行します。       |
	# * +------+------------------------------------------------+
	#**/
	def set_signer(signer, options)
		@signer_path = "#{root_dir}/#{signer}" if signer != nil
		@signer_options = options.clone()
	end

	#/**
	# * xp3 コンポーネントの追加。
	#**/
	def add_component(name, source_dir, targets, revision = nil)
		if(revision == nil)
			if(name == 'bin')
				@components << XP3LocalComponent.new(name, source_dir, targets, work_dir)
			else
				@components << XP3LocalComponent.new(name, source_dir, targets, "#{work_dir}/src")
			end
		else
			@components << XP3SVNCollector.new(name, "#{repository_url}/#{@name}", revision, "#{repository_subset}/#{source_dir}", "#{work_dir}/src")
		end
	end

	def archive(version_encoding)
		MakeUtils.mkdir_p(bin_dir)

		collect(version_encoding)

		options = " -nowriterpf"
		options += " -go" if @archiver_options['auto'].to_i != 0

		@components.each { |c|
			if c.name == 'bin' then next end
			if !c.update then puts "Skipping archive of #{c.name}."; next end

			make_rpf(c)

			cmd = "#{@archiver_path} #{options} #{c.collect_dir_path}"
			MakeUtils.puts(cmd)
			`#{cmd}`
		}
	end

	#---
	def sign
		options = "-sign"
		@components.each { |c|
			if !c.update || c.name == 'bin' then next end
			cmd = "#{@signer_path} #{options} #{bin_dir}/#{c.name} #{sign_key}"
			MakeUtils.puts(cmd)
			`#{cmd}`
		}
	end

	def archive_and_sign(version_encoding)
		archive(version_encoding)
		sign
	end

	def create_dummy_components
		MakeUtils.mkdir_p(bin_dir)

		@components.each { |c|
			puts "Making the #{c.name} as a dummy component."
			File.open("#{bin_dir}/#{c.name}", "w") { |file|
				file << "This file is dummy component.\n"
			}
		}

		sign
	end

	#---
	# path が指すファイルの参照を解決する
	def make_readme_text(path)
		Encoding.default_external = 'CP932'
		lines = File.readlines(path)
		# #{xxx} 形式の参照を探す
		reg = /#\{([^\}]*)\}/
		File.open(path, 'w+') { |file|
			lines.each { |line|
                #puts "readline #{line}"
				while line =~ reg
					section, key = $1.split('.')
					if @config[section] != nil && @config[section][key] != nil
						line.sub!(reg, @config[section][key])
					else
						line.sub!(reg, '')
					end
				end
				file << line
			}

			# 更新ログがあれば書き出す
			#if different
			#	1.step(config['UPDATEINFO']['high']) { |n|
			#		log = @config["UPDATE#{n}"]['log']
			#		file << "---- version #{@config['PRODUCT']['version']}\n"
			#		file << "    #{log}\n"
			#	}
			#	file << ("\n" * 2)
			#end
		}
	end

	#---
	# アーカイブなどの出力用のフォルダパス
	def bin_dir
		"#{work_dir}/bin"
	end

private
	#---
	# component のアーカイブ用設定ファイルを作成する
	def make_rpf(component)
		# default.rpf の出力
		File.open("#{component.collect_dir_path}/default.rpf", "w") { |file|
			file << "[Output]\n"
			file << "Executable=0\n"
			file << "OutputFileName=#{bin_dir}/#{component.name}\n"
			file << "\n"
			file << "[Extensions]\n"
			file << "Compress=#{@archiver_options['compress_archive']}\n"
			file << "Store=#{@archiver_options['store_archive']}\n"
			file << "Discard=#{@archiver_options['discard_archive']}\n"
			file << "\n"
			file << "[Options]\n"
			file << "DoCompressSizeLimit=1\n"
			file << "CompressSizeLimit=1024\n"
			file << "Protect=#{@archiver_options['embed_warning']}\n"
			file << "OVBookShare=1\n"
			file << "CompressIndex=1\n"
			file << "UseXP3EncDLL=#{@archiver_options['use_xp3enc_dll']}\n"
			file << "\n\n"
		}
	end

	#---
	# path が指すファイルからバージョン情報を取り出して config を更新する
	def update_version_number(path, version_encoding)
		version_string = XP3AUtils.extract_version_string(path, version_encoding)
		if version_string != nil
			@major_version, @minor_version = version_string.split('.')
			@config['PRODUCTINFO']['version'] = version_string
			@config['PRODUCTINFO']['major_version'] = @major_version
			@config['PRODUCTINFO']['minor_version'] = @minor_version
		end
	end

	#---
	def collect(version_encoding)
		options = "-sign"

		@components.each { |c|

			puts("#{c.name} is collected...")

			c.collect() { |path|
				case File.basename(path, '.*').downcase
				# ファイル名が krkr.* の場合は名前を変更する
				when 'krkr'
					# ついでに署名が必要
					cmd = "#{@signer_path} #{options} #{path} #{sign_key}"
					MakeUtils.puts(cmd)
					`#{cmd}`

					#File.rename(path, path.sub(/krkr/, @config['PRODUCT']['name']))
				# ファイル名が readme.* の場合はタグを変換する
				when 'readme'
					make_readme_text(path)
				# ファイル名が version.* の場合はバージョン情報を抜き出す
				when 'version'
					update_version_number(path, version_encoding)
				else
					case File.extname(path).downcase
					when ".exe", ".dll", ".tpm" then
						cmd = "#{@signer_path} #{options} #{path} #{sign_key}"
						MakeUtils.puts(cmd)
						`#{cmd}`
					end
				end
			}

		}
	end

	#---
	# 修正ファイルの基本名
	def patch_base_name
		return 'update'
	end

	#---
	# サインキー
	def sign_key
		"#{@package_dir}/key/priv"
	end

end


