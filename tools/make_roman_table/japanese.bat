@echo off

@REM ���{�ꃍ�[�}���Ή��\���� .dic �t�@�C���ւ̕ϊ��B

pushd %~dp0

ruby make.rb --i=.\..\..\src\data\roman_alphabet --o=..\..\src\goki2\testcase --lang=japanese

popd
pause

@echo on


