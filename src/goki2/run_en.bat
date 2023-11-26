@ECHO OFF

@REM テストラン用のバッチプログラム

pushd %~dp0

@echo ゲーム起動中。
..\..\tools\krkrz\tvpwin32.exe ..\..\src\goki2\ -lang=en

popd

@ECHO ON



