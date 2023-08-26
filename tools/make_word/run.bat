@echo off

pushd %~dp0

ruby make.rb ..\..\src\data\typing_words\words.xls --cf=config.ini --o=. --output-encoding=UTF-8

popd
pause

@echo on


