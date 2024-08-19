# Bat常用语法总结

## 常用

### 脚本中的路径

```bat
@echo off
echo Current Disk: %~d0
echo Current Disk and Path: %~dp0
echo Current Batch Full Path: %~f0
echo Current Disk and Short Filename: %~sdp0
echo Current CMD Default Path: %cd%
pause
----------------------
Current Disk: 				D:
Current Disk and Path: 			D:\QLRepo\QLNotes\Config\Win10\0)Backup\
Current Batch Full Path: 		D:\QLRepo\QLNotes\Config\Win10\0)Backup\sync-setting-bak.cmd
Current Disk and Short Filename: 	D:\QLRepo\QLNotes\Config\Win10\0)Backup\
Current CMD Default Path: 		D:\QLRepo\QLNotes\Config\Win10\0)Backup

rem 切换到bat脚本的所在目录
cd /d %~dp0
```



# Bat Method

> 查询windows下脚本使用说明的网站: https://ss64.com/
>
> 本篇来源：https://blog.csdn.net/u011388696/article/details/79121717

## 空格

bat赋值语句中非必要位置不要使用空格。由于长期写c++代码造成的习惯，变量赋值的前后加空格。bat命令中仍采用该种写法，会命令执行时会出现一些稀奇古怪的问题，期初以为是命令使用不正确，拷贝网上实例代码仔细对照后发现是赋值符号的前后多了两个空格。如：

```bat
::错误写法，输出结果为：%var%
set var = abc 
echo %var%
 
::正确写法，输出结果为：abc
set var=abc
echo %var%
```

命令与某些符号之间要有空格否则会导致解析错误，如：

```bat
rem 如下命令解析失败
for %%a in (a b c) do(echo %%a)
```

do和其后的括号之间要有空格。

## 命令回显

bat命令执行时，自动开启命令回显，需要在bat文件头，输入`echo off`命令；这样调用的命令不会有回显，仅显示正常输出的结果，如：

```bat
::输出为：hello
echo off
echo hello
echo.
```

`echo.`表示输出空行，`echo`和`.`号之间不能有空格。

## 引号

命令调用中若参数包含特殊字符则要将参数用引号，或者解析器不能区分当前传入为两个参数的，也可用引号。如下所示：

```bat
rem 第二个参数不加引号，解析会报错找不到文件
xcopy /Q /Y /F /S ..\plugin\trunk\target\libs\win64\*.* .\exe
 
rem 对第二个参数加引号，明确是两个入参；
xcopy /Q /Y /F /S "..\plugin\trunk\target\libs\win64\*.*" ".\exe"
```

## for循环

for循环的使用，写个简单例子，记住基本使用

```bat
for %%i in (a b c) do (echo %%i)
```

 需要注意的是：

1) 循环变量的变量名仅能为单字母变量，且区分大小写；

2) 循环变量的引用做如下区分：在CMD窗口中为`%i`，在bat文件中为`%%i`；

3) 循环的变量是非延迟扩展的；

4. 变量的非延迟扩展，是说bat命令在逐行执行时，单行中的变量引用会先做替换，然后执行 。如下示例，求集合中数字的总和

   ```bat
   ::输出结果为：3
   echo off
   set /A n=0
   for %%i in (1,2,3) do (
   	set /A n=%n%+%%i
   )
   echo %n%
   ```

   在for语句执行时，由于是非延迟扩展，所以将语句中的%n%替换为0，所以最终输出结果为3。为能够让变量n在运行时展开，则可开启延迟展开，此时通过在文件开头调用setlocal语句，同时用!n!方式引用变量达到延迟展开效果，而%n%依然是非延迟展开。如下输出即为正确结果：

   ```bat
   ::输出结果为：6
   setlocal enabledelayedexpansion
   set /A s=0
   for %%i in (1,2,3) do (
   	set /A s=!s!+%%i
   )
   echo %s%
   ```

   多条语句的跨多行编写，可用（）包裹多行语句。

   还有一种较为特殊的场景是字符中包含特殊字符，在变量引用中若不使用延迟展开则会出现不错误的结果，示例代码如下：

   ```bat
   @echo off
    
   setlocal ENABLEDELAYEDEXPANSION
   set x=^> is the greater than symbol
   echo %x%
   echo !x!
   endlocal
    
   pause
   ```

   第一个ehco在对命令解析时，会认为>是重定向到文件is，然后将后续字符输出到文本文件is中；

   第二个则为延至加载效果，^>是转移序列，最终是输出">is the greater than symbol"，为预期的输出结果。

   所以在对文本字符串的处理中，为避免其中包含特殊字符导致解析错误，最好都是用延迟加载方式。

## 临时path

经常会有使用某个工具而工具又未在path路径下的情况，这时输入命令执行会提示“不是可执行程序”。通过cd命令进入工具所属路径有需要来回切换路径很麻烦。如果经常使用该命令可以在系统属性中修改path变量，若只是是偶尔用一下，则可以用path命令是修改path路径，这样仅修改当前cmd环境中生效。如：

```bat
path c:\system32;%path%
```

这样就可以直接访问c:\system32路径下的工具了。

## bat函数

样例

```bat
REM 输出为：Hello World
echo off
 
set str1=Hello
set str2=World
set joint=
call :myStrJoint %str1%,%str2%,joint
echo %joint%
pause 
 
REM join two strings witch space
:myStrJoint
set new_str=%~1 %~2
set %~3=%new_str%
goto:eof
```

如上函数中输入str1和str2，而后调用myStrJonit过程，拼接好的字符串保存至全局变量oin。其中也使用了一点字符串拼接的技巧，就是%str1% %str2%，中间的空格也会一并作为字符拼接到字符串中。在函数定义和使用上，注意以下几点：

a. 函数的名称即为label名称，在函数的结尾处必须有goto:eof；

b. 函数的调用一定要是call，不能为goto，若为goto则在函数执行结束后直接退出了。

c. 入参的传递方式，多个参数中间使用逗号或者空格分开，若为变量的值传递则要通过%var%对变量解引用，若为传递变量名称则不需要。函数调用中实际返回值是通过对环境变量join复制而做到的。

由此也引入一个疑问，如果是局部作用域的变量该如何返回。如下示例

```bat
echo off
 
echo testFunc
set str1=void
call:testFunc str1
echo %str1%
 
echo testFunc1
set str1=void
call:testFunc1 str1
 
echo testFunc2
set str1=void
call:testFunc2 str1
 
pause
REM==========================
 
:testFunc
SETLOCAL 
set astr=DosTips
(ENDLOCAL
	set %~1=%astr%
)
goto:eof
 
:testFunc1
SETLOCAL 
set astr=DosTips
set %~1=%astr%
ENDLOCAL
goto:eof
 
:testFunc2
SETLOCAL 
set astr=DosTips
ENDLOCAL & set %~1=%astr%
echo %astr%
goto:eof
```

如上3种写法中只有testFunc是有效的其他两种均无效。原理上应该还是因为非延迟展开，即在最后一条语句执行时，对命令中的astr做了替换。testFunc2中&是告诉命令解析器，同一行中有两个命令，但由于命令执行还是在ENDLOCAL执行结束后，无法再访问到astr，所以未能将值拷贝到%~1。简单验证如下：

```bat
REM 输出为：1
set /A num=1 
set /A num=%num%+1 & set /A num=%num%
echo %num%
```

由于&连接的两个命令是不跨行的，而且num为非延迟替换，所以最终输出结果为1，但这种非延迟替换效果在ENLOCAL却没有生效。

最后记录一个小技巧，有时会希望在文件管理器的特定路径下打开CMD窗口。当然先打开CMD窗口，此时为命令工具的默认路径，然后cd /d切换到目标路径。还有如下两种操作方式：

1) 在目标路径下，按住Shift键，单击右键，弹出菜单中选择“在此处打开命令窗口”；

2) 资源管理器的地址栏中输入cmd，此时命令窗口默认也是当前路径。

## call set说明

call语句之后可以跟bat文件路径或label标识名称，调用批文件或子过程。但是在说明文档中没有提及的是call之后可以跟Set之类的cmd命令，FOR和IF命令除外。解释说明如下截图：

![img](Bat.assets/20200730182559834.png)

应该是不建议使用的，因为对call之后的命令解析有前置的文件查找过程。

## 字符串处理

1. 剔除首部的空格，注意字符串要有空格修饰；

   ```bat
   set /P var=
   echo The input:%var%
   for /f "tokens=* delims= " %%a in ("%var%") do set var=%%a
   ```

   这里有一层隐藏的含义，字符串%var%按照delims指定的间隔符做一次段分割，分割为多段后通过变量名称顺序匹配，如%%a引用对应分割后第1段，%%b对应分割后的第2段，以此类推。tokens是对当前分组内容的说明：

   `tokens=*`，意味着不做分段，整个对应1段；

   `tokens=1*`，拣出第1段与%%a对应。其余的部分作为第2段对应到%%b

   `tokens=1,2*`，则捡出1和2段，其余部分对应为第段。以此类推。

   分段结果对应当前循环，所以如果分段的是字符串，则只会循环一次，不会因为分多段，每个循环取一段处理。

2. 截取子串

   Substrings are done using the `:~start,length`notation:

   ```bat
   %var:~10,5%
   ```

   start可以为负值

## 获取本机的IP地址

```bat
@echo off
set ip=
for /f "tokens=2 delims=:" %%i in ('ipconfig^|findstr "IPv4"') do (
	set ip=%%i
	goto web
)
:web
set PATH=%PATH%;C:\Program Files (x86)\Google\Chrome\Application
chrome.exe %ip%
```

