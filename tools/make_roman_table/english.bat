@echo off

@REM 英語用ローマ字対応表から .dic ファイルへの変換。

pushd %~dp0

ruby make.rb --i=.\..\..\src\data\roman_alphabet --o=. --output-encoding=UTF-8 --file-type=.xls --lang=english

popd
pause

@echo on


