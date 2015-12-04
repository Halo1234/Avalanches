#!/usr/bin/ruby -w
# -*- coding: cp932 -*-


#/**
# *

def show_usage
	puts <<EOS
Synopsis:
 ruby #{File.basename(__FILE__)} Options

Example:
 ruby #{File.basename(__FILE__)} --i=foo/bar/input --o=foo/bar/output --language=japanese -v

Description:
 指定された言語のローマ字対応表を読み込んで *.dic ファイルに変換します。

Options:
 --file-type
  入力元から読み込むファイルタイプ（拡張子）を指定します。
  デフォルトでは .ods を読み込みます。
  '.' は含めても含めなくてもどちらでも構いません。

 -help
 -h
  使い方の詳細（このテキスト）を表示します。

 --language
 --lang
  言語を指定します。
  ここに指定できる値は実質的に入力元に存在するファイル名です。

  つまり INPUT-PATH\\LANGUAGE.FILE-TYPE を読み込みます。

 --input-path
 --i
  入力元を指定します。
  デフォルトの入力元はカレントディレクトリです。

 --output-path
 --o
  出力先を指定します。
  デフォルトの出力先はカレントディレクトリです。

 -vervose
 -v
  変換の詳細を出力します。
EOS
end

# *
# * Global settings

# カレント
pwd = '.'
# 環境ルート
root_dir = "#{pwd}/../.."
# ファイルタイプ
file_type = ".ods"
# 言語
language = nil
# 入力元
input_dir = "#{pwd}"
# 出力先
output_dir = "#{pwd}"

# ruby 用共有モジュールへのパス
common_module_dir = "#{root_dir}/src/common/ruby"

$: << "#{common_module_dir}"

verbose = false

# .dic ファイルヘッダ
dictionary_file_header = <<EOT
/**
 * !!!! Warning !!!!
 *
 * This file was generated by #{File.basename(__FILE__)}.
 * Don't edit directly this file.
**/

EOT

# *
#**/

require 'mod_utils.rb'
require 'mod_cmd_params.rb'
require 'mod_convxlsx.rb'

cmdp = CmdParam.new(ARGV)

if(cmdp['-help'] || cmdp['-h'])
	show_usage()
	exit
end

verbose = (cmdp['-verbose'] || cmdp['-v'])
MakeUtils.verbose = verbose

file_type = cmdp['--file-type'] if cmdp['--file-type'] != nil
file_type = ".#{file_type}" if file_type[0] != '.'

# --input-path オプション名義の方を優先
input_dir = cmdp['--i'] if cmdp['--i'] != nil
input_dir = cmdp['--input-path'] if cmdp['--input-path'] != nil
input_dir = input_dir.gsub(/\\/, '/')

while input_dir[-1].chr == '/' do input_dir.chop! end

# --output-path オプション名義の方を優先
output_dir = cmdp['--o'] if cmdp['--o'] != nil
output_dir = cmdp['--output-path'] if cmdp['--output-path'] != nil
output_dir = output_dir.gsub(/\\/, '/')

while output_dir[-1].chr == '/' do output_dir.chop! end
MakeUtils.mkdir_p(output_dir)

# --language オプション名義の方を優先
language = cmdp['--lang'] if cmdp['--lang'] != nil
language = cmdp['--language'] if cmdp['--language'] != nil

if(language == nil)
	puts 'Error:'
	puts ' --language オプションが指定されていません。'
	puts ''
	exit
end

puts ''
puts "Input directory: #{input_dir}"
puts "Output directory: #{output_dir}"
puts "Language: #{language}"
puts "File type: #{file_type}"
puts ''

input_path = "#{input_dir}/#{language}#{file_type}"

converter = XlsxConverter.new()

puts "'#{input_path}' is loading."
puts 'Please wait...'
sheets = converter.load(input_path)

symbols = []
others = []

sheets.each { |sheet|

	header_row = true
	header = []

	table = nil

	if(sheet.name.downcase == 'symbol')
		table = symbols
	else
		table = others
	end

	sheet.each { |row|

		# 何もない行は無視する
		if(row.count(nil) == row.size) then next; end

		if(header_row)
			row.each { |cell|
				header << cell
			}
		else
			code = []

			row.each { |cell|
				code << cell
			}

			header.each_index { |index|

				if(code[index] == nil) then next; end

				src = []
				work = code[index].split(/\n/)
				work.each { |line|
					# NOTE: 一旦 \n で置換してから１文字ずつばらして再度 \\* で置き換える
					line = line.gsub(/\\\\\*/, "\n")
					line = line.split(//)
					line.map! { |n| n == "\n" ? '\\\\*' : n }
					src << "[(string)\"#{line.join('", (string)"')}\"]"
				}

				MakeUtils.puts(symbol = "\"#{header[index]}\" => [#{src.join(', ')}]")

				table << symbol

			}

			header.clear

		end

		header_row = !header_row

	}

}

# Symbol 以外を出力。
File.open("#{output_dir}/#{language}.dic", 'w') { |file|
	file << dictionary_file_header
	file << "%[\n"
	file << "\t#{others.join(",\n\t")}\n"
	file << "]\n\n\n"
}

# Symbol を出力。
File.open("#{output_dir}/#{language}_symbol.dic", 'w') { |file|
	file << dictionary_file_header
	file << "%[\n"
	file << "\t#{symbols.join(",\n\t")}\n"
	file << "]\n\n\n"
}


