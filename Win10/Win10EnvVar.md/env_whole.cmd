::From: www.sysin.org
::OS 环境: Windows 10 (Include Server 2016/2019/2022)

@echo off
::用户变量所在位置：`HKEY_CURRENT_USER\Environment`
set USER_REG_PATH=HKEY_CURRENT_USER\Environment
::系统变量所在位置：`HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Session Manager\Environment`
set MACHINE_REG_PATH=HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment

echo.
echo =====================================================
echo              VSCode Environment Setting
echo =====================================================
echo.

set /P EN=Press Enter To Confirm ...
echo.

::用户环境变量
::处理路径有空格异常，增加一句 set
set CODE_PATH=D:\Programs\Tools\Editor\VSCode
echo New User Variable: CODE_PATH=%CODE_PATH%
reg add "%USER_REG_PATH%" /v "CODE_PATH" /t REG_SZ /d "%CODE_PATH%" /f
echo.

echo Append New User Path: PATH=%CODE_PATH%\bin
for /F "tokens=3*" %%i in ('reg query "%USER_REG_PATH%" /v "path" 2^>nul') do (set USER_PATH=%%i)
echo USER_PATH=%USER_PATH%
::reg add "%USER_REG_PATH%" /v "Path" /t REG_EXPAND_SZ /d "%USER_PATH%;%CODE_PATH%\bin" /f
::若要保持变量 %CODE_PATH% 为变量名称而不是变量实际值增加 %%
reg add "%USER_REG_PATH%" /v "Path" /t REG_EXPAND_SZ /d "%USER_PATH%;%%CODE_PATH%%\bin" /f
echo.

::系统环境变量
::处理路径有空格异常，增加一句 set
set CODE_ROOT=D:\Programs\Tools\Editor\VSCode
echo New Machine Variable: CODE_ROOT=%CODE_ROOT%
reg add "%MACHINE_REG_PATH%" /v "CODE_ROOT" /t REG_SZ /d "%CODE_ROOT%" /f
echo.

echo Append New Machine Path: PATH=%CODE_ROOT%\bin
for /F "tokens=3*" %%i in ('reg query "%MACHINE_REG_PATH%" /v "path" 2^>nul') do (set MACHINE_PATH=%%i)
echo Before Appending: MACHINE_PATH=%MACHINE_PATH%
::reg add "%MACHINE_REG_PATH%" /v "Path" /t REG_EXPAND_SZ /d "%MACHINE_PATH%;%CODE_ROOT%\bin" /f
::若要保持变量 %CODE_ROOT% 为变量名称而不是变量实际值增加 %%
reg add "%MACHINE_REG_PATH%" /v "Path" /t REG_EXPAND_SZ /d "%MACHINE_PATH%;%%CODE_ROOT%%\bin" /f
echo After Appending: MACHINE_PATH=%MACHINE_PATH%
echo.

echo ************ Environment Setting End ***********
echo.
echo Press Any Key to Contimue ...
pause>nul