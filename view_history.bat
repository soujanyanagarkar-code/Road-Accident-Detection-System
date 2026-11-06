@echo off
setlocal
echo ================================================================
echo   Accident Detection System - Incident History Dashboard
echo ================================================================

set "PY_BIN=python"
where python3.12 >nul 2>nul
if %ERRORLEVEL% equ 0 (
    set "PY_BIN=python3.12"
) else if exist "%LOCALAPPDATA%\Microsoft\WindowsApps\PythonSoftwareFoundation.Python.3.12_qbz5n2kfra8p0\python.exe" (
    set "PY_BIN=%LOCALAPPDATA%\Microsoft\WindowsApps\PythonSoftwareFoundation.Python.3.12_qbz5n2kfra8p0\python.exe"
)

echo Starting Incident History Dashboard on http://127.0.0.1:5000 ...
echo.
%PY_BIN% "%~dp0Accident-Detection-System\history.py"
pause
