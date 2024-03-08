@echo off

@REM Batch program for simple script conversion

pushd %~dp0

@echo List of files to convert is generate... 
dir /s /b .\sample\ >.\sample.list

@rem For Kirikiri Z, please use this.
ruby convgs.rb --cf=./config_en.ini .\sample.list --o=.\output_sample --input-encoding=cp932 --output-encoding=UTF-8 -v
@rem For Kirikiri 2, please use this.
@rem ruby convks.rb --cf=./config_en.ini .\sample.list --o=.\output_main_part --input-encoding=cp932 -v

popd
pause

@echo on


