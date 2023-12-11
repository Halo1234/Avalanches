#!/usr/bin/ruby -w
# -*- coding: cp932 -*-


#/**
# *

def show_usage
	puts <<EOS
Synopsis:
 ruby convks.rb INPUT_FILE_LIST [Options]

Example:
 ruby convks.rb input.list --o=foo/bar/ -v

Description:
 INPUT_FILE_LIST に書かれたファイルを全て *.ks/*.gs ファイルに変換します。
 INPUT_FILE_LIST には一行につき１ファイルを指定できます。

Options:
 --configuration-file
 --cf
  設定ファイルを指定します。
  設定ファイルは Windows INI file フォーマットです。
  デフォルトの設定ファイルは config.ini です。

  設定ファイルの書き方については config.ini.sample を参照してください。

 --input-encoding
  入力されるテキストの文字エンコーディングを指定します。
  指定できるエンコーディングの名前のリストは下記コマンドで得る事ができます。
  デフォルトの文字エンコーディングは CP932 です。

   #ruby -e "puts Encoding.name_list"

  このオプションはコマンドライン以外の
  全ての入力に影響を与える事に注意してください。
  つまり、設定ファイルである *.ini ファイルの読み込みにも影響を与えます。

  また、U+301C 変換問題があるため
  現状 (Ruby version 1.9.3) では Shift_JIS はほぼ使い物になりません。

 --output-encoding
  出力されるテキストの文字エンコーディングを指定します。
  指定できるエンコーディングは --input-encoding の説明を参照してください。

 -gs
  出力するスクリプトファイルの拡張子を *.gs に変更します。

 -help
 -h
  使い方の詳細（このテキスト）を表示します。

 --output-path
 --o
  出力先を指定します。
  デフォルトの出力先はカレントディレクトリです。

 -vervose
 -v
  変換の詳細を出力します。
EOS
end

def show_usage_english
	puts <<EOS
Description:
  Convert all files written to INPUT_FILE_LIST to *.ks/*.gs files.
  One file can be specified per line in INPUT_FILE_LIST.

Options:
  --configuration-file
  --cf
   Specify the configuration file.
   The configuration file is in Windows INI file format.
   The default configuration file is config.ini.

   Please refer to config.ini.sample for information on how to write the configuration file.

  --input-encoding
   Specifies the character encoding of the input text.
   A list of possible encoding names can be obtained with the following command.
   The default character encoding is CP932.

    #ruby -e "puts Encoding.name_list"

   This option is useful for non-command line
   Please note that this will affect all inputs.
   In other words, it also affects the loading of *.ini files, which are configuration files.

   Also, because there is a U+301C conversion problem
   Currently (Ruby version 1.9.3) Shift_JIS is almost unusable.

  --output-encoding
   Specifies the character encoding of the output text.
   Please refer to the explanation of --input-encoding for the encodings that can be specified.

  -gs
   Change the extension of the output script file to *.gs.

  -help
  -h
   Display usage details (this text).

  --output-path
  --o
   Specify the output destination.
   The default output destination is the current directory.

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
# 入力ファイルリスト
input_file_list = nil
# 設定ファイル
configuration_file = "#{pwd}/config.ini"
# 入力のエンコーディング方式
input_file_encoding = __ENCODING__
# 出力のエンコーディング方式
output_file_encoding = __ENCODING__
# 出力先
output_dir = "#{pwd}"
# 拡張子
script_extension = '.gs'

# ruby 用共有モジュールへのパス
common_module_dir = "#{root_dir}/src/common/ruby"

$: << "#{common_module_dir}"
$: << "#{pwd}/mod"

verbose = false

# *
#**/

require 'inifile.rb'

require 'mod_utils.rb'
require 'mod_cmd_params.rb'
require 'mod_conv.rb'


cmdp = CmdParam.new(ARGV)

if(cmdp['-h'])
    if(cmdp['-english'])
        show_usage_english()
    else
        show_usage()
    end
	exit
end

verbose = (cmdp['-verbose'] || cmdp['-v'])
MakeUtils.verbose = verbose

if(cmdp['--input-encoding'] != nil)

	begin
		input_file_encoding = Encoding.find(cmdp['--input-encoding'])
	rescue ArgumentError
		puts 'Error:'
		puts " #{$!.message}"
		puts " --input-encoding=#{cmdp['--input-encoding']}"
		puts '--------------'
		exit
	end

	if(input_file_encoding == Encoding.find('Shift_JIS'))
		puts 'Warning:'
		puts ' 入力エンコーディングに Shift_JIS が指定されました。'
		puts ' 正常に動作しない可能性があります。'
		puts '--------------'
	end

end

if(cmdp['--output-encoding'] != nil)

	begin
		output_file_encoding = Encoding.find(cmdp['--output-encoding'])
	rescue ArgumentError
		puts 'Error:'
		puts " #{$!.message}"
		puts " --output-encoding=#{cmdp['--output-encoding']}"
		puts '--------------'
		exit
	end

end

if(cmdp['@'] == nil)
	puts 'Error:'
	puts ' 入力ファイルのリストが指定されていません。'
	puts ''
	exit
end
input_file_list = cmdp['@'].gsub(/\\/, '/')

# --configuration-file オプション名義の方を優先
configuration_file = cmdp['--cf'] if cmdp['--cf'] != nil
configuration_file = cmdp['--configuration-file'] if cmdp['--configuration-file'] != nil
configuration_file = configuration_file.gsub(/\\/, '/')

# --output-path オプション名義の方を優先
output_dir = cmdp['--o'] if cmdp['--o'] != nil
output_dir = cmdp['--output-path'] if cmdp['--output-path'] != nil
output_dir = output_dir.gsub(/\\/, '/')

if(output_dir[-1].chr == '/') then output_dir.chop! end
MakeUtils.mkdir_p(output_dir)

# --configuration-file オプション名義の方を優先
configuration_file = cmdp['--cf'] if cmdp['--cf'] != nil
configuration_file = cmdp['--configuration-file'] if cmdp['--configuration-file'] != nil
configuration_file = configuration_file.gsub(/\\/, '/')

script_extension = '.gs' if cmdp['-gs'] == true
script_extension = '.ks' if cmdp['-ks'] == true

puts ''
puts "Input encoding name: '#{input_file_encoding.name}'"
puts "Output encoding name: '#{output_file_encoding.name}'"
puts "Configuration file: '#{configuration_file}'"
puts "Input file list: '#{input_file_list}'"
puts "Output directory: '#{output_dir}'"
puts "Output file type: '*#{script_extension}'"
puts ''

# 基本設定読み込み
conf = IniFile.load(configuration_file, {:encoding=>input_file_encoding})

# conf の内容は全て Ruby の言うところの '外部エンコーディング' なので
# ここで全て '内部エンコーディング' に変換する
#conf.each { |section, parameter, value|
#	conf[section][parameter].encode!(__ENCODING__)
#}

# コンバータ生成
converter = ScenarioConverter.new(input_file_encoding, output_file_encoding)
converter.verbose = verbose
# INI ファイルの内容は全て String なので
# 必要なものはココで全て変換しておく
cc = conf['SIMPLE_PARSE']
cc['main_characters'] = cc['main_characters'].split(/,/)
cc['strip_brackets'] = (cc['strip_brackets'] == '0' ? false : true)
cc['begin_brackets'] = (cc['begin_brackets'] == nil ? [''] : cc['begin_brackets'].split(//))
cc['end_brackets'] = (cc['end_brackets'] == nil ? [''] : cc['end_brackets'].split(//))
cc['anonymous_text'] = cc['anonymous_text'].to_i
cc['warning_only_name_appears'] = (cc['warning_only_name_appears'] == '0' ? false : true)

converter.configure(cc)

# 入力ファイルを全て処理する
input_files = File.readlines(input_file_list)
input_files.each { |path|

	path.rstrip!()
	path.gsub!(/\\/, '/')

	converter.convert_to(
		path,
		"#{output_dir}/#{File.basename(path, '.*')}#{script_extension}"
	)

}


