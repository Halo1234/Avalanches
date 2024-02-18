@echo off

pushd %~dp0

ruby make.rb ..\..\src\data\cgmemory\list_en.xlsx --cf=config_en.ini --o=. --output-encoding=UTF-8

popd
pause

@echo on


