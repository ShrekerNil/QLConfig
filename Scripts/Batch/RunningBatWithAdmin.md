# 让bat批处理以管理员权限运行的实现方法

这篇文章主要介绍了让bat批处理以管理员权限运行的实现方法,需要的朋友可以参考下

## 1、第一种方法

有的电脑是非管理员登录，运行程序时，需要提示是否运行运行。解决方法如下：

```bash
@ echo off
%1 %2
ver|find "5.">nul&&goto :Admin
mshta vbscript:createobject("shell.application").shellexecute("%~s0","goto :Admin","","runas",1)(window.close)&goto :eof
:Admin
//在你的bat开头加上上面的命令即可
//下面是你需要执行的命令
set path=%~dp0
echo install mysql service...
echo %path%
cd %path%\bin\
mysqld.exe --remove mysql
mysqld.exe --install mysql
echo start mysql Service
"%SystemRoot%"\system32\net start mysql
```

## 2、bat脚本获取管理员权限

```bash
@echo off
%1 mshta vbscript:CreateObject("Shell.Application").ShellExecute("cmd.exe","/c %~s0 ::","","runas",1)(window.close)&&exit
cd /d "%~dp0"
```

写在bat文件的顶端就可以实现。

## 3、bat脚本中以管理员权限执行命令

在bat脚本文件第一行加上下面命令：

```bash
%1 mshta vbscript:CreateObject(“Shell.Application”).ShellExecute(“cmd.exe”,``"/c %~s0 ::"``,``""``,“runas”,1)(window.close)&&exit
```

## 4、自动以管理员身份运行批处理(bat)文件

在日常运维工作中，为方便对windows用户进行系统安装或配置等，使用Windows自带的批处理(bat文件)是一种最为简单快速的方法。

但是，批处理脚本不会默认已管理员身份运行，一般情况下，我会将脚本命名为"XXXXXX(请右键点击，用管理员身份运行!).bat"，但总有些用户会忽略这条提示，直接运行，此时由于权限不足，导致脚本运行失败。我们可以使用一种变通的方法，让bat启动时，首先调用vbs脚本，通过vbs脚本，以管理员身份调用该bat的 runas 部分

我们的脚本可以写在runas 下，这样就点击该bat脚本，就可以已管理员身份运行了

示例代码如下

```bash
@ECHO OFF
setlocal EnableDelayedExpansion
color 3e
title 添加服务配置
 
PUSHD %~DP0 & cd /d "%~dp0"
%1 %2
mshta vbscript:createobject("shell.application").shellexecute("%~s0","goto :runas","","runas",1)(window.close)&goto :eof
:runas
 
::填写自己的脚本
 
echo 执行完毕,任意键退出
 
pause >nul
exit
```

## 5、以管理员权限执行bat脚本

只需要在你编写的.bat文件的开头加上以下脚本，然后双击.bat文件即是以管理员权限执行

```bash
@echo off&color 17
if exist "%SystemRoot%\SysWOW64" path %path%;%windir%\SysNative;%SystemRoot%\SysWOW64;%~dp0
bcdedit >nul
if '%errorlevel%' NEQ '0' (goto UACPrompt) else (goto UACAdmin)
:UACPrompt
%1 start "" mshta vbscript:createobject("shell.application").shellexecute("""%~0""","::",,"runas",1)(window.close)&exit
exit /B
:UACAdmin
cd /d "%~dp0"
echo 当前运行路径是：%CD%
echo 已获取管理员权限
```

## 6、如何让BAT和CMD批处理以管理员身份运行

如何让BAT和CMD批处理以管理员身份运行？

有些批处理需要很高的权限执行才能达到我们所需要的效果，

将以下代码放入批处理最顶部就可以实现以管理员身份运行了。

```bash
@echo off
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
if '%errorlevel%' NEQ '0' (
goto UACPrompt
) else ( goto gotAdmin )
:UACPrompt
echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"
"%temp%\getadmin.vbs"
exit /B
:gotAdmin
if exist "%temp%\getadmin.vbs" ( del "%temp%\getadmin.vbs" )
```

## 7、命令行CMD批处理自动以管理员身份运行的正确方法

修正了路径有空格时的问题

在批处理开头加上：

适用于无参数

> %1 mshta vbscript:CreateObject("Shell.Application").ShellExecute("cmd.exe","/c "^&chr(34)^&"%~0"^&chr(34)^&" ::","%cd%","runas",1)(window.close)&&exit

适用于一参数

> %2 mshta vbscript:CreateObject("Shell.Application").ShellExecute("cmd.exe","/c "^&chr(34)^&"%~0"^&chr(34)^&" "^&chr(34)^&"%~1"^&chr(34)^&" ::","%cd%","runas",1)(window.close)&&exit

更多参数的以此类推
运行批处理时多加一个参数::，这句就不会执行
为了兼容8.3短路径，可把`%~0`等换成`%~s0`等
理论上是没问题，但启动路径有时不可靠，之后可能还要`pushd`或`cd /d`

## 8、bat文件以管理员权限运行的几种方式

1、创建bat快捷方式，然后右键快捷方式-->properties-->advanced-->Run as administrator。
2、下载bat转成exe工具，将bat转成exe,然后右键exe-->properties-->Compatibility-->Run as administrator。
3、以管理员权限运行cmd，然后dos框中运行相应的bat。

到此这篇关于让bat批处理以管理员权限运行的实现方法的文章就介绍到这了,更多相关管理员权限运行bat内容请搜索脚本之家以前的文章或继续浏览下面的相关文章希望大家以后多多支持脚本之家！

您可能感兴趣的文章:

- [BAT 批处理脚本教程(详细篇脚本之家补充)](https://www.jb51.net/article/151923.htm)
- [Windows下使用批处理文件.bat删除旧文件](https://www.jb51.net/article/151039.htm)
- [利用bat批处理程序通过DOS命令行删除所有的空文件夹的方法](https://www.jb51.net/article/140978.htm)
- [bat命令批处理判断32位还是64位系统的多种方法](https://www.jb51.net/article/134126.htm)
- [解决springmvc+mybatis+mysql中文乱码问题](https://www.jb51.net/article/71832.htm)
- [bat文件加密 bat解密脚本(让bat乱码现形)](https://www.jb51.net/article/32942.htm)
- [解决bat批处理输出乱码的问题](https://www.jb51.net/article/211165.htm)