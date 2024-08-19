@Echo Off
cd /d %~dp0
title Notepad++ "Tools for Delete or add file menu"

SetLocal EnableDelayedExpansion
echo 1. Add Notepad++ to menu
echo ------------------------
echo 2. Remove Notepad++ from menu
echo ------------------------

Set /p u="Input the operation number and Press Enter:"

If "%u%"=="1" Goto regnpp
If "%u%"=="2" Goto unregnpp

:regnpp
regsvr32 /i NppShell64.dll
exit

:unregnpp
regsvr32 /u NppShell64.dll
exit
