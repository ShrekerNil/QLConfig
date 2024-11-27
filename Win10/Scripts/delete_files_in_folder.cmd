@echo off
setlocal enabledelayedexpansion

rem chcp 65001 >nul

set "script_dir=%~dp0"
set "exclude_dir=.git"

:delete_recursive
    set "current_dir=%~1"

    if not exist "%current_dir%" (
        echo Directory does not exist: "%current_dir%"
        goto :eof
    )

    echo Processing directory: "%current_dir%"

    for %%f in ("%current_dir%\*") do (
        if not exist "%%~ff\*" (
            echo Deleting file: "%%~ff"
            del /f /q "%%~ff"
        )
    )

    for /d %%d in ("%current_dir%\*") do (
        call :delete_recursive "%%d"
    )

    set "has_files=0"
    set "has_dirs=0"

    for %%f in ("%current_dir%\*") do (
        if exist "%%~ff\*" (
            set "has_dirs=1"
        ) else (
            set "has_files=1"
        )
    )

    if "!has_files!"=="0" if "!has_dirs!"=="0" (
        echo Deleting empty directory: "%current_dir%"
        rd /s /q "%current_dir%"
    )

    goto :eof

echo Starting deletion from directory: "%script_dir%"

for /d %%s in ("%script_dir%\*") do (
    if /I not "%%~ns"=="%exclude_dir%" (
        echo Deleting from subdirectory: "%%s"
        call :delete_recursive "%%s"
    )
)

echo Completed.
pause
