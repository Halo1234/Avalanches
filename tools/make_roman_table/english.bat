@echo off

@REM Conversion from English Romanization table to .dic file.

pushd %~dp0

ruby make.rb --i=.\..\..\src\data\roman_alphabet --o=. --output-encoding=UTF-8 --file-type=.xls --lang=english

popd
pause

@echo on


