@echo off

@REM �p��p���[�}���Ή��\���� .dic �t�@�C���ւ̕ϊ��B

pushd %~dp0

ruby make.rb --i=.\..\..\src\data\roman_alphabet --o=. --output-encoding=UTF-8 --file-type=.xls --lang=english

popd
pause

@echo on


