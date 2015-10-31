@echo off

@REM 日本語ローマ字対応表から .dic ファイルへの変換。

pushd %~dp0

ruby make.rb --i=.\..\..\src\data\roman_alphabet --o=..\..\src\goki2\testcase --lang=japanese

popd
pause

@echo on


