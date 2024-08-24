::@echo off
:menu
::color 4f
cls
echo "| |"
echo "| 进程判断 |"
echo "| 请选择(只要输入1,2,3,4)： |"
echo "| 1.根据程序名 例：taskmgr.exe |"
echo "| 2.根据窗口标题 例：Windows 任务管理器 |"
echo "| 3.根据PID值 例：3896 |"
echo "| 4.帮助文件 |"
echo "| 5.安全退出 |"
echo "| |"

 

set /p Select=请选择(1,2,3,4然后回车):
echo 您选择了第%Select%项
echo.
echo.

if {%Select%}=={1} goto ProgrammeName
if {%Select%}=={2} goto WindowsTitle
if {%Select%}=={3} goto PID
if {%Select%}=={4} goto helptxt
if {%Select%}=={5} goto exit


:ProgrammeName

color a

echo 请输入需要追踪的程序名(记得加.exe 例taskmgr.exe)
set /p EXE=程序名:
echo.
echo 您输入的程序名是:%EXE%
echo.
tasklist|find /i "%EXE%" && echo %EXE%运行中 || echo %EXE%未运行
pause
goto menu

:WindowsTitle

color b

echo 请输入需要追踪的窗口标题(例如：Windows 任务管理器)
set /p Title=窗口标题:
echo.
echo 您输入的窗口标题是:%Title%
echo.
tasklist /FI "WINDOWTITLE eq %Title%"|find /i "PID" && echo %Title%运行中 || echo %Title%未运行
pause
goto menu

:PID

color c

echo 请输入需要追踪的PID值(例如：3896)
set /p pid=PID值:
echo.
echo 您输入的PID值是:%pid%
echo.
tasklist /FI "PID eq %pid%"|find /i "PID" && echo PID:%pid%运行中 || echo PID:%pid%未运行
pause
goto menu

:helptxt
color 03
more data/helptxt.inf
goto menu

 

:exit
cls
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.

echo 再见感谢你的使用
echo off
pause