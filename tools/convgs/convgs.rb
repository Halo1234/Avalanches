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
 INPUT_FILE_LIST �ɏ����ꂽ�t�@�C����S�� *.ks/*.gs �t�@�C���ɕϊ����܂��B
 INPUT_FILE_LIST �ɂ͈�s�ɂ��P�t�@�C�����w��ł��܂��B

Options:
 --configuration-file
 --cf
  �ݒ�t�@�C�����w�肵�܂��B
  �ݒ�t�@�C���� Windows INI file �t�H�[�}�b�g�ł��B
  �f�t�H���g�̐ݒ�t�@�C���� config.ini �ł��B

  �ݒ�t�@�C���̏������ɂ��Ă� config.ini.sample ���Q�Ƃ��Ă��������B

 --input-encoding
  ���͂����e�L�X�g�̕����G���R�[�f�B���O���w�肵�܂��B
  �w��ł���G���R�[�f�B���O�̖��O�̃��X�g�͉��L�R�}���h�œ��鎖���ł��܂��B
  �f�t�H���g�̕����G���R�[�f�B���O�� CP932 �ł��B

   #ruby -e "puts Encoding.name_list"

  ���̃I�v�V�����̓R�}���h���C���ȊO��
  �S�Ă̓��͂ɉe����^���鎖�ɒ��ӂ��Ă��������B
  �܂�A�ݒ�t�@�C���ł��� *.ini �t�@�C���̓ǂݍ��݂ɂ��e����^���܂��B

  �܂��AU+301C �ϊ���肪���邽��
  ���� (Ruby version 1.9.3) �ł� Shift_JIS �͂قڎg�����ɂȂ�܂���B

 --output-encoding
  �o�͂����e�L�X�g�̕����G���R�[�f�B���O���w�肵�܂��B
  �w��ł���G���R�[�f�B���O�� --input-encoding �̐������Q�Ƃ��Ă��������B

 -gs
  �o�͂���X�N���v�g�t�@�C���̊g���q�� *.gs �ɕύX���܂��B

 -help
 -h
  �g�����̏ڍׁi���̃e�L�X�g�j��\�����܂��B

 --output-path
 --o
  �o�͐���w�肵�܂��B
  �f�t�H���g�̏o�͐�̓J�����g�f�B���N�g���ł��B

 -vervose
 -v
  �ϊ��̏ڍׂ��o�͂��܂��B
EOS
end

# *
# * Global settings

# �J�����g
pwd = '.'
# �����[�g
root_dir = "#{pwd}/../.."
# ���̓t�@�C�����X�g
input_file_list = nil
# �ݒ�t�@�C��
configuration_file = "#{pwd}/config.ini"
# ���͂̃G���R�[�f�B���O����
input_file_encoding = __ENCODING__
# �o�͂̃G���R�[�f�B���O����
output_file_encoding = __ENCODING__
# �o�͐�
output_dir = "#{pwd}"
# �g���q
script_extension = '.gs'

# ruby �p���L���W���[���ւ̃p�X
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
	show_usage()
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
		puts ' ���̓G���R�[�f�B���O�� Shift_JIS ���w�肳��܂����B'
		puts ' ����ɓ��삵�Ȃ��\��������܂��B'
		puts '--------------'
	end

end

if(cmdp['--output-encoding'] != nil)

	begin
		output_file_encoding = Encoding.find(cmdp['--output-encoding'])
	rescue ArgumentError
		puts 'Error:'
		puts " #{$!.message}"
		puts " --output-encoding=#{cmdp['--input-encoding']}"
		puts '--------------'
		exit
	end

end

if(cmdp['@'] == nil)
	puts 'Error:'
	puts ' ���̓t�@�C���̃��X�g���w�肳��Ă��܂���B'
	puts ''
	exit
end
input_file_list = cmdp['@'].gsub(/\\/, '/')

# --output-path �I�v�V�������`�̕���D��
output_dir = cmdp['--o'] if cmdp['--o'] != nil
output_dir = cmdp['--output-path'] if cmdp['--output-path'] != nil
output_dir = output_dir.gsub(/\\/, '/')

if(output_dir[-1].chr == '/') then output_dir.chop! end
MakeUtils.mkdir_p(output_dir)

# --configuration-file �I�v�V�������`�̕���D��
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

# ��{�ݒ�ǂݍ���
conf = IniFile.load(configuration_file, {:encoding=>input_file_encoding})

# conf �̓��e�͑S�� Ruby �̌����Ƃ���� '�O���G���R�[�f�B���O' �Ȃ̂�
# �����őS�� '�����G���R�[�f�B���O' �ɕϊ�����
#conf.each { |section, parameter, value|
#	conf[section][parameter].encode!(__ENCODING__)
#}

# �R���o�[�^����
converter = ScenarioConverter.new(input_file_encoding, output_file_encoding)
converter.verbose = verbose
# INI �t�@�C���̓��e�͑S�� String �Ȃ̂�
# �K�v�Ȃ��̂̓R�R�őS�ĕϊ����Ă���
cc = conf['SIMPLE_PARSE']
cc['main_characters'] = cc['main_characters'].split(/,/)
cc['strip_brackets'] = (cc['strip_brackets'] == '0' ? false : true)
cc['begin_brackets'] = (cc['begin_brackets'] == nil ? [''] : cc['begin_brackets'].split(//))
cc['end_brackets'] = (cc['end_brackets'] == nil ? [''] : cc['end_brackets'].split(//))
cc['anonymous_text'] = cc['anonymous_text'].to_i
cc['warning_only_name_appears'] = (cc['warning_only_name_appears'] == '0' ? false : true)

converter.configure(cc)

# ���̓t�@�C����S�ď�������
input_files = File.readlines(input_file_list)
input_files.each { |path|

	path.rstrip!()
	path.gsub!(/\\/, '/')

	converter.convert_to(
		path,
		"#{output_dir}/#{File.basename(path, '.*')}#{script_extension}"
	)

}


