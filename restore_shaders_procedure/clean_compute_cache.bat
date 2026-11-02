@echo off
setlocal

:: Generic path using %APPDATA% (resolves to C:\Users\<Username>\AppData\Roaming)
set "TARGET_DIR=%APPDATA%\NVIDIA\ComputeCache"

echo [INFO] Checking NVIDIA ComputeCache directory: "%TARGET_DIR%"

if exist "%TARGET_DIR%" (
    echo [INFO] Cleaning files and subdirectories in "%TARGET_DIR%"...
    
    :: Delete all files quietly (including read-only/hidden/system if any)
    del /f /s /q "%TARGET_DIR%\*" >nul 2>&1
    
    :: Remove all subdirectories inside ComputeCache while keeping ComputeCache itself
    for /d %%D in ("%TARGET_DIR%\*") do (
        rd /s /q "%%~fD" >nul 2>&1
    )
    
    echo [OK] Cleanup completed. Note: Files currently locked by active processes are skipped automatically.
) else (
    echo [INFO] Directory "%TARGET_DIR%" does not exist. Nothing to clean.
)

endlocal
exit /b 0
