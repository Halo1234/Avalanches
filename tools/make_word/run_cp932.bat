@echo off

pushd %~dp0

ruby make.rb ..\..\src\data\typing_words\words.xls --cf=config.ini --o=.

popd
pause

@echo on


