@echo off

pushd %~dp0

ruby make.rb ..\..\src\data\cgmemory\list.xlsx --cf=config.ini --o=.

popd
pause

@echo on


