@echo off
setlocal
echo ================================================================
echo   Accident Detection System - Health ^& Diagnostic Verifier
echo ================================================================

set "PY_BIN="

REM 1. Check python3.12 command
where python3.12 >nul 2>nul
if %ERRORLEVEL% equ 0 (
    set "PY_BIN=python3.12"
    goto :RUN
)

REM 2. Check direct Windows Store Python 3.12 path
if exist "%LOCALAPPDATA%\Microsoft\WindowsApps\PythonSoftwareFoundation.Python.3.12_qbz5n2kfra8p0\python.exe" (
    set "PY_BIN=%LOCALAPPDATA%\Microsoft\WindowsApps\PythonSoftwareFoundation.Python.3.12_qbz5n2kfra8p0\python.exe"
    goto :RUN
)

REM 3. Check Windows py launcher for 3.12
py -3.12 --version >nul 2>nul
if %ERRORLEVEL% equ 0 (
    set "PY_BIN=py -3.12"
    goto :RUN
)

REM 4. Fallback to default python
set "PY_BIN=python"

:RUN
echo Using Python: %PY_BIN%
echo.
%PY_BIN% "%~dp0Accident-Detection-System\verify_system.py"
pause

