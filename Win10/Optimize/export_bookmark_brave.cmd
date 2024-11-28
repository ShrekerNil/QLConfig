@echo off
REM Set the path to the Brave browser executable (modify this path if necessary)
set BRAVE_PATH="C:\Program Files\BraveSoftware\Brave-Browser\Application\brave.exe"

REM Check if the Brave browser is installed
if not exist %BRAVE_PATH% (
    echo Brave browser not found. Please check the installation path.
    pause
    exit /b 1
)

REM Get the current date in YYYY_MM_DD format
for /f "tokens=2 delims==." %%i in ('wmic os get localdatetime /value') do set datetime=%%i
set year=%datetime:~0,4%
set month=%datetime:~4,2%
set day=%datetime:~6,2%
set formatted_date=%year%_%month%_%day%

REM Set the output path and filename for the bookmarks
set OUTPUT_PATH=D:\QLRepo\QLConfig\Broswer\Bookmarks\bookmarks_%formatted_date%.html

REM Export bookmarks using Brave
%BRAVE_PATH% --export-bookmarks-to="%OUTPUT_PATH%"

REM Check if the bookmarks were successfully exported
if exist "%OUTPUT_PATH%" (
    echo Bookmarks successfully exported to %OUTPUT_PATH%
) else (
    echo Bookmark export failed. Please check the path and permissions.
)

pause
