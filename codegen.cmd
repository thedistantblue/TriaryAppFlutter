@echo off
setlocal

rem Run from the directory this script lives in (project root).
cd /d "%~dp0"

echo [1/2] melos bootstrap: link packages + pub get
call dart run melos bootstrap
if errorlevel 1 (
    echo.
    echo ERROR: bootstrap failed.
    exit /b 1
)

echo.
echo [2/2] melos codegen: build_runner in all packages
call dart run melos run codegen
if errorlevel 1 (
    echo.
    echo ERROR: codegen failed.
    exit /b 1
)

echo.
echo Done.
endlocal
