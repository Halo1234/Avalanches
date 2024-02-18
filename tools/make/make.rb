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
 TARGET �Ŏw�肳�ꂽ�p�b�P�[�W�𐶐����܂��B

Options:
 --configuration-file
 --cf
  �ݒ�t�@�C�����w�肵�܂��B
  �ݒ�t�@�C���� Windows INI file �t�H�[�}�b�g�ł��B
  �f�t�H���g�̐ݒ�t�@�C���� config.ini �ł��B

  �ݒ�t�@�C���̏������ɂ��Ă� config.ini ���Q�Ƃ��Ă��������B

 --version-encoding
 --ve
  version.* �X�N���v�g�̃G���R�[�f�B���O���w�肵�܂��B
  �f�t�H���g�� utf-16le �ł��B

 -help
 -h
  �g�����̏ڍׁi���̃e�L�X�g�j��\�����܂��B

 -no-archive
 -na
 �A�[�J�C�u���쐬���܂���B

 -no-package
 -np
  �C���X�g�[�����쐬���܂���B

 --patch-number
 --pn
  �쐬����C���t�@�C���ԍ����w�肵�܂��B
  �ݒ�t�@�C���ɑΉ�����C���t�@�C���ԍ����L�^����Ă��Ȃ���΃G���[�ɂȂ�܂��B
  �܂��A--pn=LOW:HIGH �̌`���Ńp�b�P�[�W�ɕ����̏C���t�@�C�����܂߂鎖���ł��܂��B
  �Ⴆ�΁A--pn=1:3 �Ɠ��͂���ΏC���t�@�C���P�`�R�܂ł��܂߂��p�b�P�[�W���쐬���܂��B
  ����� LOW ���ȗ����鎖���ł��܂��B���̏ꍇ LOW �� 1 ���w�肳�ꂽ�Ƃ݂Ȃ���܂��B
  �܂�A��̗�̏ꍇ --pn=:3 �Ə��������ł��܂��B

 -rom
  �w�肷��ƃC���X�g�[���� ROM �p�ɍœK�����ꂽ�`�ō쐬���܂��B
  �w�肵�Ȃ���΃C���X�g�[���͈�̎��s�t�@�C���ɃA�[�J�C�u����܂��B

 -vervose
 -v
  �ϊ��̏ڍׂ��o�͂��܂��B
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

# �J�����g
pwd = '.'
# �����[�g
root_dir = "#{pwd}/../.."
# �ݒ�t�@�C��
configuration_file = "#{pwd}/config.ini"
# version.gs �X�N���v�g�̃G���R�[�f�B���O
version_encoding = "UTF-16LE"
# �A�[�J�C�u���s�����ǂ���
do_archive = true
# �C���X�g�[�����쐬���邩�ǂ���
do_package = true
# �p�b�`�ԍ�
patch_number = nil
patch_number_low = nil
patch_number_high = nil

# �^�[�Q�b�g
target = ''

# ruby �p���L���W���[���ւ̃p�X
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

# --configuration-file �I�v�V�������`�̕���D��
configuration_file = cmdp['--cf'] if cmdp['--cf'] != nil
configuration_file = cmdp['--configuration-file'] if cmdp['--configuration-file'] != nil
configuration_file = configuration_file.gsub(/\\/, '/')

# --version-encoding �I�v�V�������`�̕���D��
version_encoding = cmdp['--ve'] if cmdp['--ve'] != nil
version_encoding = cmdp['--version-encoding'] if cmdp['--version-encoding'] != nil

do_archive = false if cmdp['-no-archive'] || cmdp['-na']
do_package = false if cmdp['-no-package'] || cmdp['-np']

# --patch-number �I�v�V�������`�̕���D��
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

# ��{�ݒ�ǂݍ���
input_file_encoding = Encoding.find("cp932")
config = IniFile.load(configuration_file, {:encoding=>input_file_encoding})
section = config['SETTINGS']

# override.ini �}�[�W
override_ini_file = "#{root_dir}/#{section['resource_dir']}/#{target}/override.ini"
override_ini = IniFile.load(override_ini_file, {:encoding=>input_file_encoding})
override_ini.each { |section, parameter, value|
    config[section][parameter] = value
}

if(patch_number != nil)

	# �p�b�`�ԍ��̍ő�l�𒲂ׂ�
	patch_number_max = 1
	while config.has_section?("UPDATE#{patch_number_max}") do patch_number_max = patch_number_max + 1 end
	patch_number_max = patch_number_max - 1

	patch_number_high = patch_number_max if patch_number_high == 'HEAD'

	if(patch_number_max == 0)
		puts 'Error:'
		puts ' �p�b�`�ԍ����w�肳��Ă��܂����p�b�`��񂪈������܂���B'
		puts ''
		exit
	elsif(patch_number_low <= 0 || patch_number_high <= 0)
		puts 'Error:'
		puts ' �p�b�`�ԍ��Ƀ[���A�܂��͕��̒l���w�肳��܂����B'
		puts ''
		exit
	elsif(patch_number_low > patch_number_max || patch_number_high > patch_number_max)
		puts 'Error:'
		puts ' �p�b�`�ԍ����w�肳��Ă��܂����͈͊O�ł��B'
		if(patch_number_low == patch_number_high)
			puts " �w�肳�ꂽ�p�b�`�ԍ��F #{patch_number_low}"
		else
			puts " �w�肳�ꂽ�p�b�`�ԍ��F #{patch_number_low} �` #{patch_number_high}"
		end
		puts " �L���ȃp�b�`�ԍ��F 1 �` #{patch_number_max}"
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

# �X�V�����쐬
#if cmdp['--patch-number'] != nil
#	log = ''
#	1.step(patch_number_high) { |n|
#		str = config["UPDATE#{n}"]['log'].gsub("\\n", "\n")
#		log = "---- update #{n}\n#{str}\n\n#{log}"
#	}
#	config['UPDATEINFO']['log'] = log
#end

# xp3 �A�[�J�C�o�N��
section = config['SETTINGS']
source_dir = section['source_dir']
archiver = XP3Archiver.new(section['project_name'], target)
archiver.set_repository_url(section['repository_url'], section['subset'])
archiver.set_local_root_dir(root_dir)
archiver.set_package_dir("#{root_dir}/#{section['resource_dir']}/#{target}")
archiver.set_archiver(config['ARCHIVER']['path'], config['ARCHIVER'])
archiver.set_signer(config['SIGNER']['path'], config['SIGNER'])
archiver.set_config(config)

# xp3 �R���|�[�l���g������
case archive_type
when 'master'
	# ��ƃt�H���_
	archiver.set_work_dir("#{pwd}/work_#{target}/#{archive_type}")

	section = config['COMPONENTS']
	section.each_pair { |key, value|
		archiver.add_component(key, "#{root_dir}/#{source_dir}", value.split(/\s?,\s?/))
	}
	archiver.add_component('bin', archiver.package_dir, ['install'])

when 'different'
	# ��ƃt�H���_
	archiver.set_work_dir("#{pwd}/#{archiver.name}/#{archive_type}#{patch_number_low}_#{patch_number_high}")

	log = ''
	1.step(patch_number_max) { |n|
		work = config["UPDATE#{n}"]['log'].gsub("\\n", "\n")
		log = "---- update #{n}\n#{work}\n\n#{log}"
		archiver.add_component("update#{n}.xp3", source_dir, [], config["UPDATE#{n}"]['revs'])
	}
end

# xp3 �A�[�J�C�u�J�n
archiver.archive_and_sign(version_encoding) if do_archive

# �p�b�P�[�W���O
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


