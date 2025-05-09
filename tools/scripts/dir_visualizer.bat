@echo off
setlocal

REM UV 설치 여부 확인
uv --version >nul 2>nul
if errorlevel 1 (
    echo [ERROR] UV is not installed or not found in PATH.
    echo Please install UV first. See: https://github.com/astral-sh/uv
    pause
    exit /b 1
)

cd /d "%~dp0"
cd ..

set VENV_PATH=.\.venv

uv run ./src/directory_visualizer.py

if errorlevel 1 (
    echo.
    echo [ERROR] Script execution failed. Check the messages above.
) else (
    echo.
    echo [SUCCESS] Directory visualization script completed successfully!
)

endlocal
pause