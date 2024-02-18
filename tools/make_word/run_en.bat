@echo off

pushd %~dp0

ruby make.rb ..\..\src\data\typing_words\words_en.xls --cf=config_en.ini --o=. --output-encoding=UTF-8

popd
pause

@echo on


