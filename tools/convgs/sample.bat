@echo off

@REM �ȈՃX�N���v�g�ϊ��p�o�b�`�v���O����

pushd %~dp0

@echo List of files to convert is generate... 
dir /s /b .\sample\ >.\conv_sample.list

@rem �g���g��Z�̏ꍇ�͂�����𗘗p���Ă��������B
ruby convks.rb .\conv_sample.list --o=.\output_sample --input-encoding=cp932 --output-encoding=UTF-8 -v
@rem �g���g���Q�̏ꍇ�͂�����𗘗p���Ă��������B
@rem ruby convks.rb .\conv_sample.list --o=.\output_main_part --input-encoding=cp932 -v

popd
pause

@echo on


