@echo off

@REM 簡易スクリプト変換用バッチプログラム

pushd %~dp0

@echo List of files to convert is generate... 
dir /s /b .\sample\ >.\conv_sample.list

@rem 吉里吉里Zの場合はこちらを利用してください。
ruby convks.rb .\conv_sample.list --o=.\output_sample --input-encoding=cp932 --output-encoding=UTF-8 -v
@rem 吉里吉里２の場合はこちらを利用してください。
@rem ruby convks.rb .\conv_sample.list --o=.\output_main_part --input-encoding=cp932 -v

popd
pause

@echo on


