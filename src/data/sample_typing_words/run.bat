@echo off

pushd %~dp0

ruby make.rb words.ods --cf=config.ini --o=..\..\goki2\testcase

popd
pause

@echo on


