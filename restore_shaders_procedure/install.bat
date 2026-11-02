@echo off
setlocal

set "SCRIPT_NAME=clean_compute_cache.bat"
set "SOURCE_SCRIPT=%~dp0%SCRIPT_NAME%"
set "INSTALL_DIR=%LOCALAPPDATA%\RestoreShadersProcedure"
set "INSTALLED_SCRIPT=%INSTALL_DIR%\%SCRIPT_NAME%"
set "REG_KEY=HKCU\Software\Microsoft\Windows\CurrentVersion\Run"
set "REG_VALUE_NAME=CleanNvidiaComputeCache"

echo ========================================================
echo   Installing NVIDIA ComputeCache Startup Cleaner
echo ========================================================

if not exist "%SOURCE_SCRIPT%" (
    echo [ERROR] Source script not found at: "%SOURCE_SCRIPT%"
    pause
    exit /b 1
)

:: 1. Copy the script to a standard local user directory so it works even if the repo moves
if not exist "%INSTALL_DIR%" (
    mkdir "%INSTALL_DIR%"
)
copy /y "%SOURCE_SCRIPT%" "%INSTALLED_SCRIPT%" >nul
if errorlevel 1 (
    echo [ERROR] Failed to copy script to "%INSTALL_DIR%".
    pause
    exit /b 1
)
echo [OK] Script installed to: "%INSTALLED_SCRIPT%"

:: 2. Register in Windows CurrentUser Run registry key (runs at user logon, no Admin required)
:: Run minimized via cmd /c to avoid intrusive console popups
reg add "%REG_KEY%" /v "%REG_VALUE_NAME%" /t REG_SZ /d "cmd.exe /c \"%INSTALLED_SCRIPT%\"" /f >nul
if errorlevel 1 (
    echo [ERROR] Failed to register startup entry in Registry.
    pause
    exit /b 1
)
echo [OK] Registered startup entry '%REG_VALUE_NAME%' in "%REG_KEY%"

:: 3. Run it once immediately to verify
echo [INFO] Running initial cleanup now...
call "%INSTALLED_SCRIPT%"

echo.
echo [SUCCESS] Installation finished! The cache will be cleaned automatically on every Windows logon.
pause
endlocal
exit /b 0
