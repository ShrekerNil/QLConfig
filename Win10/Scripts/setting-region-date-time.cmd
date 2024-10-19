@echo off
SETLOCAL ENABLEDELAYEDEXPANSION

:: 设置新的区域值
:: "Locale=0409:00000409" :: 美国英语
SET "Locale=0804:00000804"
:: "LocaleName=en-US"
SET "LocaleName=zh-CN"
SET "sLongDate=yyyy/MM/dd ddd"
SET "sShortDate=yyyy/MM/dd ddd"
SET "sTimeFormat=HH:mm:ss"
SET "sShortTime=HH:mm:ss"

:: 修改注册表项
reg add "HKEY_CURRENT_USER\Control Panel\International" /v LocaleName /t REG_SZ /d %LocaleName% /f
reg add "HKEY_CURRENT_USER\Control Panel\International" /v sLongDate /t REG_SZ /d %sLongDate% /f
reg add "HKEY_CURRENT_USER\Control Panel\International" /v sShortDate /t REG_SZ /d %sShortDate% /f
reg add "HKEY_CURRENT_USER\Control Panel\International" /v sTimeFormat /t REG_SZ /d %sTimeFormat% /f
reg add "HKEY_CURRENT_USER\Control Panel\International" /v sShortTime /t REG_SZ /d %sShortTime% /f

:: 重启Windows Explorer以应用更改
taskkill /IM explorer.exe /F
start explorer.exe

echo Locale settings have been updated.
ENDLOCAL
