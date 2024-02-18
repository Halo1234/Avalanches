#!/usr/bin/ruby -w
# -*- coding: cp932 -*-


#/**
# *

def show_usage
	puts <<EOS
Synopsis:
 ruby #{File.basename(__FILE__)} [Options] TARGET

Example:
 ruby #{File.basename(__FILE__)} --cf=./config.ini TestProducts

Description:
 TARGET で指定されたパッケージを生成します。

Options:
 --configuration-file
 --cf
  設定ファイルを指定します。
  設定ファイルは Windows INI file フォーマットです。
  デフォルトの設定ファイルは config.ini です。

  設定ファイルの書き方については config.ini を参照してください。

 --version-encoding
 --ve
  version.* スクリプトのエンコーディングを指定します。
  デフォルトは utf-16le です。

 -help
 -h
  使い方の詳細（このテキスト）を表示します。

 -no-archive
 -na
 アーカイブを作成しません。

 -no-package
 -np
  インストーラを作成しません。

 --patch-number
 --pn
  作成する修正ファイル番号を指定します。
  設定ファイルに対応する修正ファイル番号が記録されていなければエラーになります。
  また、--pn=LOW:HIGH の形式でパッケージに複数の修正ファイルを含める事ができます。
  例えば、--pn=1:3 と入力すれば修正ファイル１～３までを含めたパッケージを作成します。
  さらに LOW を省略する事ができます。その場合 LOW は 1 が指定されたとみなされます。
  つまり、先の例の場合 --pn=:3 と書く事ができます。

 -rom
  指定するとインストーラを ROM 用に最適化された形で作成します。
  指定しなければインストーラは一つの実行ファイルにアーカイブされます。

 -vervose
 -v
  変換の詳細を出力します。
EOS
end

def show_usage_english
	puts <<EOS
Synopsis:
 ruby #{File.basename(__FILE__)} [Options] TARGET

Example:
 ruby #{File.basename(__FILE__)} --cf=./config.ini TestProducts

Description:
  Generates the package specified by TARGET.

Options:
  --configuration-file
  --cf
   Specify the configuration file.
   The configuration file is in Windows INI file format.
   The default configuration file is config.ini.

   Please refer to config.ini for information on how to write the configuration file.

  --version-encoding
  --ve
   version.* Specifies the script encoding.
   Default is utf-16le.

  -help
  -h
   Display usage details (this text).

  -no-archive
  -na
  Does not create an archive.

  -no-package
  -np
   Does not create an installer.

  --patch-number
  --pn
   Specify the modification file number to create.
   An error will occur if the modification file number corresponding to the configuration file is not recorded.
   You can also include multiple fix files in a package using the --pn=LOW:HIGH format.
   For example, if you enter --pn=1:3, a package including modified files 1 to 3 will be created.
   Furthermore, LOW can be omitted. In that case, LOW is assumed to be 1.
   In other words, in the previous example, you could write --pn=:3.

  -ROM
   If specified, the installer will be created in a form optimized for ROM.
   If not specified, the installer will be archived into a single executable file.

  -verbose
  -v
   Print conversion details.
EOS
end

# *
# * Global settings

# カレント
pwd = '.'
# 環境ルート
root_dir = "#{pwd}/../.."
# 設定ファイル
configuration_file = "#{pwd}/config.ini"
# version.gs スクリプトのエンコーディング
version_encoding = "UTF-16LE"
# アーカイブを行うかどうか
do_archive = true
# インストーラを作成するかどうか
do_package = true
# パッチ番号
patch_number = nil
patch_number_low = nil
patch_number_high = nil

# ターゲット
target = ''

# ruby 用共有モジュールへのパス
common_module_dir = "#{root_dir}/src/common/ruby"

$: << "#{common_module_dir}"
$: << "#{pwd}/mod"

verbose = false

# *
#**/


require "inifile.rb"

require "mod_cmd_params.rb"
require "mod_xp3_archiver.rb"
require "mod_setup.rb"

cmdp = CmdParam.new(ARGV)

if(cmdp['-help'] || cmdp['-h'])
    if(cmdp['-english'])
        show_usage_english()
    else
        show_usage()
    end
	exit
end

verbose = (cmdp['-verbose'] || cmdp['-v'])
MakeUtils.verbose = verbose

# --configuration-file オプション名義の方を優先
configuration_file = cmdp['--cf'] if cmdp['--cf'] != nil
configuration_file = cmdp['--configuration-file'] if cmdp['--configuration-file'] != nil
configuration_file = configuration_file.gsub(/\\/, '/')

# --version-encoding オプション名義の方を優先
version_encoding = cmdp['--ve'] if cmdp['--ve'] != nil
version_encoding = cmdp['--version-encoding'] if cmdp['--version-encoding'] != nil

do_archive = false if cmdp['-no-archive'] || cmdp['-na']
do_package = false if cmdp['-no-package'] || cmdp['-np']

# --patch-number オプション名義の方を優先
patch_number = cmdp['--pn'] if cmdp['--pn'] != nil
patch_number = cmdp['--patch-number'] if cmdp['--patch-number'] != nil
if(patch_number != nil)
	if(patch_number =~ /(\d?):(\d?)/)
		patch_number_low = ($1.empty? ? 1 : $1.to_i)
		patch_number_high = ($2.empty? ? 'HEAD' : $2.to_i)
	else
		patch_number_low = patch_number_high = patch_number.to_i
	end
end

target = cmdp['@'] if cmdp['@'] != nil

# 基本設定読み込み
input_file_encoding = Encoding.find("cp932")
config = IniFile.load(configuration_file, {:encoding=>input_file_encoding})
section = config['SETTINGS']

# override.ini マージ
override_ini_file = "#{root_dir}/#{section['resource_dir']}/#{target}/override.ini"
override_ini = IniFile.load(override_ini_file, {:encoding=>input_file_encoding})
override_ini.each { |section, parameter, value|
    config[section][parameter] = value
}

if(patch_number != nil)

	# パッチ番号の最大値を調べる
	patch_number_max = 1
	while config.has_section?("UPDATE#{patch_number_max}") do patch_number_max = patch_number_max + 1 end
	patch_number_max = patch_number_max - 1

	patch_number_high = patch_number_max if patch_number_high == 'HEAD'

	if(patch_number_max == 0)
		puts 'Error:'
		puts ' パッチ番号が指定されていますがパッチ情報が一つもありません。'
		puts ''
		exit
	elsif(patch_number_low <= 0 || patch_number_high <= 0)
		puts 'Error:'
		puts ' パッチ番号にゼロ、または負の値が指定されました。'
		puts ''
		exit
	elsif(patch_number_low > patch_number_max || patch_number_high > patch_number_max)
		puts 'Error:'
		puts ' パッチ番号が指定されていますが範囲外です。'
		if(patch_number_low == patch_number_high)
			puts " 指定されたパッチ番号： #{patch_number_low}"
		else
			puts " 指定されたパッチ番号： #{patch_number_low} ～ #{patch_number_high}"
		end
		puts " 有効なパッチ番号： 1 ～ #{patch_number_max}"
		puts ''
		exit
	end
end

archive_type = (patch_number == nil ? 'master' : 'different')

puts ''
puts "Target: #{target}"
puts "Type: #{archive_type}"
if(patch_number != nil)
	if(patch_number_low == patch_number_high)
		patch_number = patch_number_low
	else
		patch_number = "#{patch_number_low}:#{patch_number_high}"
	end
	puts "Patch number: #{patch_number}"
end
puts "Configuration file..."
puts "  Base: '#{configuration_file}'"
puts "  Override: '#{override_ini_file}'"
puts "Archive: #{do_archive ? 'yes' : 'no'}"
puts "Package: #{do_package ? 'yes' : 'no'}"
puts ''

# 更新履歴作成
#if cmdp['--patch-number'] != nil
#	log = ''
#	1.step(patch_number_high) { |n|
#		str = config["UPDATE#{n}"]['log'].gsub("\\n", "\n")
#		log = "---- update #{n}\n#{str}\n\n#{log}"
#	}
#	config['UPDATEINFO']['log'] = log
#end

# xp3 アーカイバ起動
section = config['SETTINGS']
source_dir = section['source_dir']
archiver = XP3Archiver.new(section['project_name'], target)
archiver.set_repository_url(section['repository_url'], section['subset'])
archiver.set_local_root_dir(root_dir)
archiver.set_package_dir("#{root_dir}/#{section['resource_dir']}/#{target}")
archiver.set_archiver(config['ARCHIVER']['path'], config['ARCHIVER'])
archiver.set_signer(config['SIGNER']['path'], config['SIGNER'])
archiver.set_config(config)

# xp3 コンポーネント初期化
case archive_type
when 'master'
	# 作業フォルダ
	archiver.set_work_dir("#{pwd}/work_#{target}/#{archive_type}")

	section = config['COMPONENTS']
	section.each_pair { |key, value|
		archiver.add_component(key, "#{root_dir}/#{source_dir}", value.split(/\s?,\s?/))
	}
	archiver.add_component('bin', archiver.package_dir, ['install'])

when 'different'
	# 作業フォルダ
	archiver.set_work_dir("#{pwd}/#{archiver.name}/#{archive_type}#{patch_number_low}_#{patch_number_high}")

	log = ''
	1.step(patch_number_max) { |n|
		work = config["UPDATE#{n}"]['log'].gsub("\\n", "\n")
		log = "---- update #{n}\n#{work}\n\n#{log}"
		archiver.add_component("update#{n}.xp3", source_dir, [], config["UPDATE#{n}"]['revs'])
	}
end

# xp3 アーカイブ開始
archiver.archive_and_sign(version_encoding) if do_archive

# パッケージング
if do_package
	SetupCompiler.nsis(archiver) { |c|
		if cmdp['-rom']
			c.compile_rom_version(archive_type)
		else
			c.compile(archive_type)
		end
	}
else
	puts('!!!!Making of installer was skipped.')
end


