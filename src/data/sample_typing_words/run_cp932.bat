@echo off

pushd %~dp0

ruby make.rb words.ods --cf=config.ini --o=.

popd
pause

@echo on


