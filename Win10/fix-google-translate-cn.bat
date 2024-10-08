:: Copyright (c)2022 https://bookfere.com
:: This is a batch script for fixing Google Translate and making it available
:: in the Chinese mainland. If you experience any problem, visit the page below:
:: https://bookfere.com/post/1020.html

@echo off
setlocal enabledelayedexpansion
chcp 437

set "source_domain=google.cn"
set "target_domain=translate.googleapis.com"

set "hosts_file=C:\Windows\System32\drivers\etc\hosts"
for /f "skip=4 tokens=2" %%a in ('"nslookup %source_domain% 2>NUL"') do set ip=%%a
set "old_rule=null"
set "new_rule=%ip% %target_domain%"
set "comment=# Fix Google Translate CN"

for /f "tokens=*" %%i in ('type %hosts_file%') do (
    set "line=%%i"
    :: Retrieve the rule If the target domain exists.
    if not "!line:%target_domain%=!"=="%%i" set "old_rule=%%i"
)

if not "%old_rule%"=="null" (
    echo A rule has been added to the hosts file. 
    echo [1] Update [2] Delete
    set /p action="Enter a number to choose an action: "
    if "!action!"=="1" (
        if not "%old_rule%"=="%new_rule%" (
            echo Deleting the rule "%old_rule%"
            echo Adding the rule "%new_rule%"
            set "new_line=false"
            for /f "tokens=*" %%i in ('type %hosts_file% ^| find /v /n "" ^& break ^> %hosts_file%') do (
                set "rule=%%i"
                set "rule=!rule:*]=!"
                if "%old_rule%"=="!rule!" set "rule=%new_rule%"
                if "!new_line!"=="true" >>%hosts_file% echo.
                >>%hosts_file% <NUL set /p="!rule!"
                set "new_line=true"
            )
        ) else (
            echo The rule already exists, nothing to do.
        )
    )
    if "!action!"=="2" (
        echo Deleting the rule "%old_rule%"
        set "new_line=false"
        for /f "tokens=*" %%i in ('
            type "%hosts_file%" ^| findstr /v /c:"%comment%" ^| findstr /v "%target_domain%" ^| find /v /n "" ^& break ^> "%hosts_file%"
        ') do (
            set "line=%%i"
            set "line=!line:*]=!"
            if "!new_line!"=="true" >>%hosts_file% echo.
            >>%hosts_file% <NUL set /p="!line!"
            set "new_line=true"
        )
    )
) else (
    echo Adding the rule "%new_rule%"
    echo.>>%hosts_file%
    echo %comment%>>%hosts_file%
    <NUL set /p="%new_rule%">>%hosts_file%
)

echo Done.
pause
