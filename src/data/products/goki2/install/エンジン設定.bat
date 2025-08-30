@ECHO OFF

@REM エンジン設定起動

pushd %~dp0

@echo エンジン設定起動中。
.\krkr.eXe -userconf

popd

@ECHO ON



