@echo off

if "%~1"=="" (
    echo ERROR: Please provide a folder path.
    echo Usage: %~nx0 "folder_path"
    exit /b 1
)

if not exist "%~1" (
    echo ERROR: Folder does not exist: %~1
    exit /b 1
)

echo Deleting files from: %~1

del /Q "%~1\*"

echo Done.
