@ECHO OFF

@REM テストラン用のバッチプログラム

pushd %~dp0

@echo エディタ起動中。
..\tvpwin32.exe

popd

@ECHO ON



