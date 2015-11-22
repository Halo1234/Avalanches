@ECHO OFF

@REM テストラン用のバッチプログラム

pushd %~dp0

@echo ゲーム起動中。
..\..\tools\krkr\kirikiri2\krkr.exe ..\..\..\src\goki2\

popd

@ECHO ON



