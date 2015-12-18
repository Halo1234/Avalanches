@echo off

pushd %~dp0

ruby make.rb ..\..\src\data\sample_typing_words\words.ods --cf=config.ini --o=. --output-encoding=UTF-8

popd
pause

@echo on


