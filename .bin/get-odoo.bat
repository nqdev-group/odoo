:: =============================================================================
:: Script: get-odoo.bat
:: Description: Download Odoo from GitHub (branch 19.0) and extract to odoo folder.
::              If odoo folder exists as a git repository, it will run git pull to update.
::              Otherwise, prompts to delete and download fresh.
:: Author: Nguyen Quy
:: Date: 2025-12-14
:: Version: 1.1
:: Last Updated: 2025-12-14
:: Dependencies: PowerShell (for downloading files via HTTPS), Git (for updates)
:: Usage: Just double-click this script or run it from the command line.
:: =============================================================================

@echo off
setlocal EnableDelayedExpansion
chcp 65001 > nul
cls

:: Show current directory
echo === Current Directory: %cd%
echo .

:: Configuration
set ODOO_REPO_URL=https://github.com/odoo/odoo
set ODOO_BRANCH=19.0
set DOWNLOAD_URL=%ODOO_REPO_URL%/archive/refs/heads/%ODOO_BRANCH%.zip
set ZIP_FILE=odoo-%ODOO_BRANCH%.zip
set EXTRACT_FOLDER=odoo
set TEMP_EXTRACT_FOLDER=odoo-%ODOO_BRANCH%

echo === Downloading Odoo from GitHub ===
echo URL: %DOWNLOAD_URL%
echo Branch: %ODOO_BRANCH%
echo Target folder: %EXTRACT_FOLDER%
echo.

:: Check if odoo folder already exists
if exist "%EXTRACT_FOLDER%" (
    echo !!! Warning: '%EXTRACT_FOLDER%' folder already exists.
    
    :: Check if it's a git repository
    if exist "%EXTRACT_FOLDER%\.git" (
        echo === Detected existing git repository. Running git pull to update ===
        pushd "%EXTRACT_FOLDER%"
        git pull
        set gitPullStatus=%ERRORLEVEL%
        popd
        
        if !gitPullStatus! EQU 0 (
            echo === Update completed successfully ===
            goto end
        ) else (
            echo !!! Git pull failed.
            set /p "confirm=Would you like to delete and download fresh? (Y/N): "
            if /i "!confirm!" NEQ "Y" (
                echo === Operation cancelled by user ===
                goto end
            )
        )
    ) else (
        set /p "confirm=Not a git repository. Would you like to delete and download fresh? (Y/N): "
        if /i "!confirm!" NEQ "Y" (
            echo === Operation cancelled by user ===
            goto end
        )
    )
    
    echo === Removing existing '%EXTRACT_FOLDER%' folder ===
    rmdir /s /q "%EXTRACT_FOLDER%"
    if exist "%EXTRACT_FOLDER%" (
        echo !!! Failed to remove '%EXTRACT_FOLDER%' folder. Please delete it manually.
        goto end
    )
)

:: Download the zip file using PowerShell
echo === Downloading zip file ===
powershell -Command "& {try { [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12 -bor [Net.SecurityProtocolType]::Tls13 } catch { [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12 }; Invoke-WebRequest -Uri '%DOWNLOAD_URL%' -OutFile '%ZIP_FILE%' -UseBasicParsing}"
if %ERRORLEVEL% NEQ 0 (
    echo !!! Failed to download the zip file. Please check your internet connection.
    goto cleanup
)
echo === Download completed successfully ===
echo.

:: Extract the zip file
echo === Extracting zip file ===
powershell -Command "& {Expand-Archive -Path '%ZIP_FILE%' -DestinationPath '.' -Force}"
if %ERRORLEVEL% NEQ 0 (
    echo !!! Failed to extract the zip file.
    goto cleanup
)
echo === Extraction completed successfully ===
echo.

:: Rename the extracted folder to 'odoo'
if exist "%TEMP_EXTRACT_FOLDER%" (
    echo === Renaming '%TEMP_EXTRACT_FOLDER%' to '%EXTRACT_FOLDER%' ===
    move "%TEMP_EXTRACT_FOLDER%" "%EXTRACT_FOLDER%" > nul
    if %ERRORLEVEL% NEQ 0 (
        echo !!! Failed to rename folder. Folder remains as '%TEMP_EXTRACT_FOLDER%'
        goto cleanup
    )
    echo === Folder renamed successfully ===
    echo.
    echo === All done ===
    echo Odoo has been downloaded and extracted to: %cd%\%EXTRACT_FOLDER%
) else (
    echo !!! Expected folder '%TEMP_EXTRACT_FOLDER%' not found after extraction
    goto cleanup
)

:cleanup
:: Clean up the zip file
if exist "%ZIP_FILE%" (
    echo === Removing zip file ===
    del /f /q "%ZIP_FILE%"
)

:: Clean up temporary extraction folder if exists (in case of failure)
if exist "%TEMP_EXTRACT_FOLDER%" (
    echo === Removing temporary extraction folder ===
    rmdir /s /q "%TEMP_EXTRACT_FOLDER%"
)

:end
echo.
pause
endlocal
