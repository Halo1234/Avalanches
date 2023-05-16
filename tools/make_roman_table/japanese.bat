@echo off

@REM 日本語ローマ字対応表から .dic ファイルへの変換。

pushd %~dp0

ruby make.rb --i=.\..\..\src\data\roman_alphabet --o=. --output-encoding=UTF-8 --file-type=.xls --lang=japanese

popd
pause

@echo on


