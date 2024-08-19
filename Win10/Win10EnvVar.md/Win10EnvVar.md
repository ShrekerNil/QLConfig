# Win10环境变量的设置

> 该文来源于博客: https://sysin.org/blog/windows-env/
>
> 还没有进一步进行验证, 好东西要保留, 要不然用的时候就找不到了...

[toc]

## 概述

环境变量 (environment variables) 是在操作系统中用来指定操作系统运行环境的一些参数。环境变量是在操作系统中一个具有特定名字的对象，它包含了一个或者多个应用程序所将使用到的信息。**Windows 和 DOS 操作系统中的 `path` 环境变量，当要求系统运行一个程序而没有告诉它程序所在的完整路径时，系统除了在当前目录下面寻找此程序外，还应到 `path` 中指定的路径去找。用户通过设置环境变量，来更好的运行进程。**

Environment variables：环境变量

- User variables：用户变量
- System variables：系统变量

环境变量可分为用户变量与系统变量两类，在注册表中都有对应的项。

### 用户变量

用户变量仅针对当前用户有效。

- 用户变量所在位置：`HKEY_CURRENT_USER\Environment`

### 系统变量

系统变量为全局变量，对所有用户有效。

- 系统变量所在位置：`HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Session Manager\Environment`

### 内置环境变量

| 变量 | 备注 |
| ---- | ---- |
| %ALLUSERSPROFILE% | 局部 返回所有“用户配置文件”的位置。|
| %APPDATA% | 局部 返回默认情况下应用程序存储数据的位置。|
| %CD% | 局部 返回当前目录字符串。|
| %CMDCMDLINE% | 局部 返回用来启动当前的 Cmd.exe 的准确命令行。|
| %CMDEXTVERSION% | 系统 返回当前的“命令处理程序扩展”的版本号。|
| %COMPUTERNAME% | 系统 返回计算机的名称。|
| %COMSPEC% | 系统 返回命令行解释器可执行程序的准确路径。|
| %DATE% | 系统 返回当前日期。使用与 date /t 命令相同的格式。由 Cmd.exe 生成。有关 date 命令的详细信息，请参阅 Date。|
| %ERRORLEVEL% | 系统 返回最近使用过的命令的错误代码。通常用非零值表示错误。|
| %HOMEDRIVE% | 系统 返回连接到用户主目录的本地工作站驱动器号。基于主目录值的设置。用户主目录是在“本地用户和组”中指定的。|
| %HOMEPATH% | 系统 返回用户主目录的完整路径。基于主目录值的设置。用户主目录是在“本地用户和组”中指定的。|
| %HOMESHARE% | 系统 返回用户的共享主目录的网络路径。基于主目录值的设置。用户主目录是在“本地用户和组”中指定的。|
| %LOGONSEVER% | 局部 返回验证当前登录会话的域控制器的名称。|
| %NUMBER_OF_PROCESSORS% | 系统 指定安装在计算机上的处理器的数目。|
| %OS% | 系统 返回操作系统的名称。Windows 2000 将操作系统显示为 Windows_NT。|
| %PATH% | 系统 指定可执行文件的搜索路径 (sysin)。|
| %PATHEXT% | 系统 返回操作系统认为可执行的文件扩展名的列表。|
| %PROCESSOR_ARCHITECTURE% | 系统 返回处理器的芯片体系结构。值: x86，IA64。|
| %PROCESSOR_IDENTFIER% | 系统 返回处理器说明。|
| %PROCESSOR_LEVEL% | 系统 返回计算机上安装的处理器的型号。|
| %PROCESSOR_REVISION% | 系统 返回处理器修订号的系统变量。|
| %PROMPT% | 局部 返回当前解释程序的命令提示符设置。由 Cmd.exe 生成。|
| %RANDOM% | 系统 返回 0 到 32767 之间的任意十进制数字。由 Cmd.exe 生成。|
| %SYSTEMDRIVE% | 系统 返回包含 Windows XP 根目录（即系统根目录）的驱动器。|
| %SYSTEMROOT% | 系统 返回 Windows XP 根目录的位置。|
| %TEMP% and %TMP% | 系统和用户 返回对当前登录用户可用的应用程序所使用的默认临时目录。有些应用程序需要 TEMP，而其它应用程序则需要 TMP。|
| %TIME% | 系统 返回当前时间。使用与 time /t 命令相同的格式。由 Cmd.exe 生成。有关 time 命令的详细信息，请参阅 Time。|
| %USERDOMAIN% | 局部 返回包含用户帐户的域的名称。|
| %USERNAME% | 局部 返回当前登录的用户的名称。|
| %UserProfile% | 局部 返回当前用户的配置文件的位置。|
| %WINDIR% | 系统 返回操作系统目录的位置。|

## 设置环境变量

> mermaid文档: https://mermaid-js.github.io/mermaid/

```mermaid
flowchart LR
A(设置环境变量) --> B(临时设置)
A(设置环境变量) --> C(永久设置)
B --> D(CMD的set命令)
B --> G(PowerShell的$env命令)
C(永久设置) --> E(setx命令)
C(永久设置) --> F(批处理修改注册表)
C(永久设置) --> H(PowerShell中.NET的方法)
```

> 临时设置涉及不到用户变量和系统变量的问题, 其操作的是二者的合集

### 临时设置

#### CMD的set命令

设置语法: `set 变量名=变量内容`

```sh
# 设置变量 tmp 的值为 d:\tmp
set tmp=d:\tmp

# 设置变量 tmp 的值为 c:\tmp
set tmp=c:\tmp
# 上述已经设置 tmp 的值，这里会直接覆盖原有值
```

追加值: `set 变量名=%变量名%;追加值`

#### PowerShell的$env命令

1. PowerShell查看全部环境变量: `ls env:`

    ```sh
    PS> ls env:
    
    Name                           Value
    ----                           -----
    ALLUSERSPROFILE                C:\ProgramData
    APPDATA                        C:\Users\Administrator\AppData\Roaming
    CLIENTNAME                     SAMBP
    CommonProgramFiles             C:\Program Files\Common Files
    CommonProgramFiles(x86)        C:\Program Files (x86)\Common Files
    CommonProgramW6432             C:\Program Files\Common Files
    COMPUTERNAME                   SYSIN-NJ
    ComSpec                        C:\Windows\system32\cmd.exe
    DriverData                     C:\Windows\System32\Drivers\DriverData
    GOPATH                         C:\Users\Administrator\go
    HOMEDRIVE                      C:
    HOMEPATH                       \Users\Administrator
    LOCALAPPDATA                   C:\Users\Administrator\AppData\Local
    LOGONSERVER                    \\SYSIN-NJ
    NUMBER_OF_PROCESSORS           1
    OS                             Windows_NT
    Path                           C:\Windows\system32;C:\Windows;C:\Windows\System32\Wbem;C:\Windows\System32\WindowsPo...
    PATHEXT                        .COM;.EXE;.BAT;.CMD;.VBS;.VBE;.JS;.JSE;.WSF;.WSH;.MSC;.CPL
    PROCESSOR_ARCHITECTURE         AMD64
    PROCESSOR_IDENTIFIER           AMD64 Family 23 Model 49 Stepping 0, AuthenticAMD
    PROCESSOR_LEVEL                23
    PROCESSOR_REVISION             3100
    ProgramData                    C:\ProgramData
    ProgramFiles                   C:\Program Files
    ProgramFiles(x86)              C:\Program Files (x86)
    ProgramW6432                   C:\Program Files
    PSModulePath                   C:\Users\Administrator\Documents\WindowsPowerShell\Modules;C:\Program Files\WindowsPo...
    PUBLIC                         C:\Users\Public
    SESSIONNAME                    RDP-Tcp#103
    SystemDrive                    C:
    SystemRoot                     C:\Windows
    TEMP                           C:\Users\ADMINI~1\AppData\Local\Temp\2
    TMP                            C:\Users\ADMINI~1\AppData\Local\Temp\2
    USERDOMAIN                     SYSIN-NJ
    USERDOMAIN_ROAMINGPROFILE      SYSIN-NJ
    USERNAME                       Administrator
    USERPROFILE                    C:\Users\Administrator
    windir                         C:\Windows
    ```

2. PowerShell查看指定环境变量: `ls env:<变量名>`

    ```sh
    PS> $env:windir
    C:\Windows
    ```

    一些特殊的用法: [查看 path 的特殊方法](http://www.bathome.net/redirect.php?tid=31373&goto=lastpost)

    ```sh
    PS > (type env:path) -split ';'
    #列表分割换行显示
    PS > (type env:path) -split ';' | sls bin
    #过滤搜索包含bin的条目
    ```

3. PowerShell创建或者修改环境变量

    语法: `$env:<变量名>="<变量值>"`

    ```sh
    PS> $env:Test1="sysin.org"
    PS> $env:Test2="www.sysin.org"
    PS> ls env:Test*
    
    Name                           Value
    ----                           -----
    Test1                       sysin.org
    Test2                       www.sysin.org
    ```

4. PowerShell删除环境变量

   语法: `del env:变量名称`

   ```sh
   PS> del env:windir
   PS> $env:windir
   ```

5. PowerShell追加环境变量

   语法: `变量名称="env:变量名称;变量值"`

   ```sh
   $env:Path="$env:Path;C:\sysin"
   ```

### 永久设置

#### setx命令

语法: 

- 设置**用户环境**变量：`setx "变量名" "变量值"`
- 设置**系统环境**变量：`setx "变量名" "变量值" /m`

#### 批处理修改注册表

示例：新建和追加环境变量

这里以 go 语言环境变量配置为例：

Win10图形界面操作：此电脑 --> 属性 --> 高级系统设置 --> 高级 --> 环境变量…

- 用户变量：
  - 新建：GOPATH = %UserProfile%\gopath (例如：当前用户是 C:\Users\Administrators)
  - PATH 变量增加一条 %GOPATH%\bin
- 系统变量：
  - 新建：GOROOT = C:\go
  - PATH 增加了一条 %GOROOT%\bin

对应的注册表脚本如下:

```powershell
::用户变量所在位置：`HKEY_CURRENT_USER\Environment`
set USERregpath=HKEY_CURRENT_USER\Environment

::系统变量所在位置：`HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Session Manager\Environment`
set MACHINEregpath=HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment

::用户环境变量
::新建
reg add "%USERregpath%" /v "GOPATH" /t REG_SZ /d "%UserProfile%\gopath" /f

::PATH 追加
::查询原有 PATH 的值
for /F "tokens=3*" %i in ('reg query "%USERregpath%" /v "path" 2^>nul') do echo %i
for /F "tokens=3*" %i in ('reg query "%MACHINEregpath%" /v "path" 2^>nul') do echo %i
::在 .bat 或者 .cmd 批处理文件中，%i 应该写成 %%i
for /F "tokens=3*" %%i in ('reg query "%USERregpath%" /v "path" 2^>nul') do echo %%i
for /F "tokens=3*" %%i in ('reg query "%MACHINEregpath%" /v "path" 2^>nul') do echo %%i

for /F "tokens=3*" %i in ('reg query "%USERregpath%" /v "path" 2^>nul') do ( set USERpath=%i)
echo USERpath=%USERpath%
reg add "%USERregpath%" /v "Path" /t REG_EXPAND_SZ /d ""%USERpath%"%GOPATH%\bin;" /f
::经过测试，巨硬 A3 的不同 Windows 10 版本的 PATH 变量竟然写法不一样，有的以分号结尾，有的没有分号。所以命令还是要加上分号分割，结尾分号取消
reg add "%USERregpath%" /v "Path" /t REG_EXPAND_SZ /d "%USERpath%;%GOPATH%\bin" /f

::系统环境变量
::新建
reg add "%MACHINEregpath%" /v "GOROOT" /t REG_SZ /d "C:\go" /f

::PATH 追加
for /F "tokens=3*" %i in ('reg query "%MACHINEregpath%" /v "path" 2^>nul') do ( set MACHINEpath=%i)
echo MACHINEpath=%MACHINEpath%
reg add "%MACHINEregpath%" /v "Path" /t REG_EXPAND_SZ /d "%MACHINEpath%;%GOROOT%\bin" /f
```

写成批处理如下:

```bat
::From: www.sysin.org
::OS 环境: Windows 10 (Include Server 2016/2019/2022)

@echo off
::用户变量所在位置：`HKEY_CURRENT_USER\Environment`
set USERregpath=HKEY_CURRENT_USER\Environment
::系统变量所在位置：`HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Session Manager\Environment`
set MACHINEregpath=HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment

color 17
echo.
echo =====================================================
echo                Go 环境变量设置
echo =====================================================
echo.

set /P EN=请按 回车键 确认设置开始!
echo.

::用户环境变量
::处理路径有空格异常，增加一句 set
set GOPATH=%UserProfile%\gopath
echo 新建用户环境变量 GOPATH=%GOPATH%
reg add "%USERregpath%" /v "GOPATH" /t REG_SZ /d "%GOPATH%" /f
echo.

echo 增加用户环境变量 PATH=%GOPATH%\bin
for /F "tokens=3*" %%i in ('reg query "%USERregpath%" /v "path" 2^>nul') do (set USERpath=%%i)
echo USERpath=%USERpath%
::reg add "%USERregpath%" /v "Path" /t REG_EXPAND_SZ /d "%USERpath%;%GOPATH%\bin" /f
::若要保持变量 %GOPATH% 为变量名称而不是变量实际值增加 %%
reg add "%USERregpath%" /v "Path" /t REG_EXPAND_SZ /d "%USERpath%;%%GOPATH%%\bin" /f
echo.

::系统环境变量
::处理路径有空格异常，增加一句 set
set GOROOT=C:\go
echo 新建系统环境变量 GOROOT=%GOROOT%
reg add "%MACHINEregpath%" /v "GOROOT" /t REG_SZ /d "%GOROOT%" /f
echo.

echo 增加系统环境变量 PATH=%GOROOT%\bin
for /F "tokens=3*" %%i in ('reg query "%MACHINEregpath%" /v "path" 2^>nul') do (set MACHINEpath=%%i)
echo MACHINEpath=%MACHINEpath%
::reg add "%MACHINEregpath%" /v "Path" /t REG_EXPAND_SZ /d "%MACHINEpath%;%GOROOT%\bin" /f
::若要保持变量 %GOROOT% 为变量名称而不是变量实际值增加 %%
reg add "%MACHINEregpath%" /v "Path" /t REG_EXPAND_SZ /d "%MACHINEpath%;%%GOROOT%%\bin" /f
echo.

echo ************ Go 环境变量设置结束! ***********
echo.
echo 请按 任意键 退出!
pause>nul
```

#### PowerShell中.NET的方法

使用 .NET 方法 [[environment\]::SetEnvironmentvariable](https://docs.microsoft.com/zh-cn/dotnet/api/system.environment.setenvironmentvariable?view=net-5.0) 操作环境变量。

首先我们看看如何分别查看"用户变量"和"系统变量"中的 “PATH”。

```powershell
#用户变量
PS> [environment]::GetEnvironmentvariable("Path", "User")
c:\powershellscript
#在某些 Windows 10 版本中以分号结尾
C:\Users\Administrator\AppData\Local\Microsoft\WindowsApps;

#系统变量
PS> [environment]::GetEnvironmentvariable("Path", "Machine")
C:\Windows\system32;C:\Windows;C:\Windows\System32\Wbem;C:\Windows\System32\WindowsPowerShell\v1.0\;C:\Windows\System32\OpenSSH\;
#在某些 Windows 10 版本中又没有分号（巨硬 A3 太不讲究）
C:\Windows\system32;C:\Windows;C:\Windows\System32\Wbem;C:\Windows\System32\WindowsPowerShell\v1.0\;C:\Windows\System32\OpenSSH\
```

写入环境变量：

```c#
# 用户变量
[environment]::SetEnvironmentvariable("变量名称", "变量值", "User")

# 系统变量
[environment]::SetEnvironmentvariable("变量名称", "变量值", "Machine")
```

案例: **新建和追加环境变量**

这里以 go 语言环境变量配置为例：

图形界面（Windows 10）：此电脑 --> 属性 --> 高级系统设置 --> 高级 --> 环境变量…

- 用户变量：
  - 新建：GOPATH = %UserProfile%\gopath (例如：当前用户是 C:\Users\Administrators)
  - PATH 变量增加一条 %GOPATH%\bin
- 系统变量：
  - 新建：GOROOT = C:\go
  - PATH 增加了一条 %GOROOT%\bin

Powershell 实现如下：

```powershell
[environment]::SetEnvironmentvariable("GOPATH", "$env:USERPROFILE\gopath", "User")
#调用命令结果：$(命令)
#获取原有用户 PATH 变量：$([environment]::GetEnvironmentvariable("Path", "User"))
#注意 PATH 中条目以分号结尾
[environment]::SetEnvironmentvariable("PATH", "$([environment]::GetEnvironmentvariable("Path", "User"));%GOPATH%\bin", "User")

[environment]::SetEnvironmentvariable("GOROOT", "C:\go", "Machine")
#调用命令结果：$(命令)
#获取原有系统 PATH 变量：$([environment]::GetEnvironmentvariable("Path", "Machine"))
[environment]::SetEnvironmentvariable("PATH", "$([environment]::GetEnvironmentvariable("Path", "Machine"));%GOROOT%\bin", "Machine")
```



