@ECHO OFF

@REM Batch program for test run

pushd %~dp0

@echo Game is starting up.
..\..\tools\krkrz\tvpwin32.exe ..\..\src\goki2\ -lang=en

popd

@ECHO ON



