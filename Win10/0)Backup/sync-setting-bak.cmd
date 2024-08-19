@REM @Author: Shreker.Nil
@REM @Date:   2022-12-21 00:34:42
@REM @Last Modified by:   Shreker.Nil
@REM Modified time: 2022-12-21 02:26:34

@echo off
setlocal enabledelayedexpansion

set source_target=%AppData%\Typora\profile.data
set filename=profile.data

call :main_opt

rem pause
goto:eof

:main_opt
SETLOCAL
set /p option=0 for BACKUP, 1 for RECOVERY. Your Choice:
if %option% == 0 (
    call :backup
) else if %option% == 1 (
    call :recovery
) else (
    echo INVALID input ... try again ...
    call :main_opt
)
goto:eof

:backup
SETLOCAL
echo ---------------------------------
echo Doing Backup ...
if exist %source_target% (
    echo %filename% Exists, Backup operation going on ...
    echo Copy %source_target% to Current ...
    copy %source_target%
    if %errorlevel% == 0 (
        echo %filename% Backup operation DONE!
    ) else (
        echo %filename% Backup operation FAILURED, chcking for more details!
    )
) else (
    echo %filename% NOT Exists, Backup operation TERMINATED.
)
goto:eof

:recovery
SETLOCAL
echo ---------------------------------
echo Doing Recovery ...
copy %filename% %source_target%
if %errorlevel% == 0 (
    echo %filename% Recovery operation DONE!
) else (
    echo %filename% Recovery operation FAILURED, chcking for more details!
)
goto:eof
