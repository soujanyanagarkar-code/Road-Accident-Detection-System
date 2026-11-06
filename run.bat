@echo off
setlocal
echo ================================================================
echo   Road Accident Detection ^& Emergency Alert System
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
echo Using Python interpreter: %PY_BIN%
echo Starting Accident Detection System...
echo.
%PY_BIN% "%~dp0Accident-Detection-System\main.py"
if %ERRORLEVEL% neq 0 (
    echo.
    echo [NOTICE] If an error occurred with %PY_BIN%, attempting fallback with default python...
    python "%~dp0Accident-Detection-System\main.py"
)
pause
