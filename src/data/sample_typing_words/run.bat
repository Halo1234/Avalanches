@echo off

pushd %~dp0

ruby make.rb words.ods --cf=config.ini --o=. --output-encoding=UTF-8

popd
pause

@echo on


