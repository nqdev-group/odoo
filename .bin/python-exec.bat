:: =============================================================================
:: Script: python-exec.bat
:: Description: Python virtual environment management and package installation
:: Author: Nguyen Quy
:: Date: 2025-12-14
:: Version: 1.0
:: Last Updated: 2025-12-14
:: Dependencies: Python
:: Usage:
::   python-exec.bat --venv             - tạo virtual environment (.venv)
::   python-exec.bat --virtualenv       - tạo virtual environment (env) bằng virtualenv
::   python-exec.bat --backup           - backup các package đã cài (requirements.txt)
::   python-exec.bat --install          - cài đặt packages từ requirements.txt
::   python-exec.bat --venv --install   - tạo venv và cài đặt packages
:: =============================================================================

@echo off
setlocal EnableDelayedExpansion
chcp 65001 > nul
cls

:: Show current directory
echo === Current Directory: %cd%
echo .

:: Parse command line arguments
set CREATE_VENV=false
set CREATE_VIRTUALENV=false
set BACKUP_PACKAGES=false
set INSTALL_PACKAGES=false

:parse_args
if "%~1"=="" goto args_done

if /i "%~1"=="--venv" set CREATE_VENV=true
if /i "%~1"=="--virtualenv" set CREATE_VIRTUALENV=true
if /i "%~1"=="--backup" set BACKUP_PACKAGES=true
if /i "%~1"=="--install" set INSTALL_PACKAGES=true

shift
goto parse_args

:args_done

:: Check if no arguments provided
if "%CREATE_VENV%"=="false" if "%CREATE_VIRTUALENV%"=="false" if "%BACKUP_PACKAGES%"=="false" if "%INSTALL_PACKAGES%"=="false" (
    echo === No arguments provided ===
    echo.
    echo Usage:
    echo   python-exec.bat --venv             - tạo virtual environment (.venv)
    echo   python-exec.bat --virtualenv       - tạo virtual environment (env) bằng virtualenv
    echo   python-exec.bat --backup           - backup các package đã cài (requirements.txt)
    echo   python-exec.bat --install          - cài đặt packages từ requirements.txt
    echo   python-exec.bat --venv --install   - tạo venv và cài đặt packages
    echo.
    goto end
)

:: Create virtual environment with venv
if "%CREATE_VENV%"=="true" (
    echo === Creating virtual environment with venv ===
    if exist ".venv" (
        echo !!! Warning: '.venv' folder already exists.
        set /p "confirm=Do you want to delete it and create new? (Y/N): "
        if /i "!confirm!" NEQ "Y" (
            echo === Skipping venv creation ===
            goto skip_venv
        )
        echo === Removing existing '.venv' folder ===
        rmdir /s /q ".venv"
    )
    
    python -m venv .venv
    if %ERRORLEVEL% NEQ 0 (
        echo !!! Failed to create virtual environment. Please check Python installation.
        goto end
    )
    echo === Virtual environment created successfully at .venv ===
    echo.
)
:skip_venv

:: Create virtual environment with virtualenv
if "%CREATE_VIRTUALENV%"=="true" (
    echo === Creating virtual environment with virtualenv ===
    if exist "env" (
        echo !!! Warning: 'env' folder already exists.
        set /p "confirm=Do you want to delete it and create new? (Y/N): "
        if /i "!confirm!" NEQ "Y" (
            echo === Skipping virtualenv creation ===
            goto skip_virtualenv
        )
        echo === Removing existing 'env' folder ===
        rmdir /s /q "env"
    )
    
    virtualenv env
    if %ERRORLEVEL% NEQ 0 (
        echo !!! Failed to create virtual environment. Please check virtualenv installation.
        echo Tip: Install virtualenv with 'pip install virtualenv'
        goto end
    )
    echo === Virtual environment created successfully at env ===
    echo.
)
:skip_virtualenv

:: Backup installed packages
if "%BACKUP_PACKAGES%"=="true" (
    echo === Backing up installed packages ===
    python -m pip freeze > .\requirements.txt
    if %ERRORLEVEL% NEQ 0 (
        echo !!! Failed to backup packages.
        goto end
    )
    echo === Packages backed up to requirements.txt ===
    echo.
)

:: Install packages from requirements.txt
if "%INSTALL_PACKAGES%"=="true" (
    echo === Installing packages from requirements.txt ===
    if not exist "requirements.txt" (
        echo !!! Error: requirements.txt not found.
        goto end
    )
    
    python -m pip install -r .\requirements.txt
    if %ERRORLEVEL% NEQ 0 (
        echo !!! Failed to install packages.
        goto end
    )
    echo === Packages installed successfully ===
    echo.
)

:end
echo.
echo === All done ===
pause
endlocal
