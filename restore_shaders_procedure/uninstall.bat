@echo off
setlocal

set "INSTALL_DIR=%LOCALAPPDATA%\RestoreShadersProcedure"
set "REG_KEY=HKCU\Software\Microsoft\Windows\CurrentVersion\Run"
set "REG_VALUE_NAME=CleanNvidiaComputeCache"

echo ========================================================
echo   Uninstalling NVIDIA ComputeCache Startup Cleaner
echo ========================================================

:: 1. Remove Registry startup entry
reg query "%REG_KEY%" /v "%REG_VALUE_NAME%" >nul 2>&1
if %errorlevel% equ 0 (
    reg delete "%REG_KEY%" /v "%REG_VALUE_NAME%" /f >nul
    echo [OK] Removed startup entry '%REG_VALUE_NAME%' from Registry.
) else (
    echo [INFO] Registry startup entry was not found (already removed).
)

:: 2. Remove installed script directory
if exist "%INSTALL_DIR%" (
    rd /s /q "%INSTALL_DIR%" >nul 2>&1
    echo [OK] Removed installation directory: "%INSTALL_DIR%"
) else (
    echo [INFO] Installation directory not found (already removed).
)

echo.
echo [SUCCESS] Uninstallation completed.
pause
endlocal
exit /b 0
