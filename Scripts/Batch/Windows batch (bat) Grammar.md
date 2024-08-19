# [Windows batch (bat) Grammar](https://titanwolf.org/Network/Articles/Article?AID=38fe8260-2d24-4156-8821-9435de41538e)

This article is to learn bat finishing notes, as more content, the proposed combination of the right side of the article outline view.

## % ~ Dp0 [Get current path]

%~dp0 "D" is an abbreviation Drive, namely drive, a diskette , "P" is the abbreviation for Path, namely the path, directory

cd% ~ dp0: enter batch directory

cd% ~ dp0bin\: enter the directory batch bin directory

### Examples

This example tests are normal in win10 x64

```
::作用：以管理员身份安装Apache
d:
cd %~dp0bin\
httpd.exe -k install -n "Apache24"
```

### Operation result

Run as Administrator **example .bat** , execution results are as follows:

```
C:\Windows\system32>d:
D:\>cd D:\Server\Apache24\bin\
D:\Server\Apache24\bin>httpd.exe -k install -n "Apache24"
```

## My common commands

### % Cd% [paths of execution]

Path path of the current execution, not the target file

### Taskkill/f/im notepad.exe [terminate the process]

taskkill/? Open help

### Cmd window Chinese garbled

In the Right/Defaults CMD window , select Properties to open the "default code page for the Simplified Chinese GBK ",

### Get Command Help xxx/?

Command can not remember the encounter, but remember the name, you can type the name of the command space/? Will help detail the order of, for example: ping/cd/??

## Built-in command to view the help information

ver/?

cmd/?

set/?

rem/?

if/?

echo/?

goto/?

for/?

shift/?

call/?

### Other commonly used commands

type/?

find/?

findstr/?

copy/?

## First, the basic grammar

\1. batch file is a ".bat" at the end of the text file, each line of the file is a DOS command. You can create and modify files using any text editor.

2 is a simple batch procedure can be used to control the process if and goto, may also be used for loop.

\3. Batch C programming language ability is far better than other programming languages, but also very non-standard.

\4. Each batch file to write good are the equivalent of a DOS external command, and put it in the DOS directory into the search path (path), the can run in any position.

5.C:\AUTOEXEC.BAT is started each time the system will automatically run, you can run the command every time you start to be placed in the file.

\6. The case-insensitive (command symbol ignored)

\7. Batch file extension .bat or .cmd.

\8. Type the name of the batch file at the command prompt, or double-click the batch file, the system will call Cmd.exe to run the file.

## Second, the parameters

### 1) System parameters

% SystemRoot% === C:\WINDOWS (% windir% same)

%ProgramFiles% === C:\Program Files

% USERPROFILE% === C:\Documents and Settings\Administrator (subdirectories are "Desktop", "Start Menu", "Favorites", etc.)

%APPDATA% === C:\Documents and Settings\Administrator\Application Data

% TEMP% === C:\DOCUME ~ 1\ADMINI ~ 1\LOCALS ~ 1\Temp (% TEM% similarly)

%APPDATA% === C:\Documents and Settings\Administrator\Application Data

% OS% === Windows_NT (system)

% Path% ===% SystemRoot%\system32;% SystemRoot%;% SystemRoot%\System32\Wbem (original settings)

% HOMEDRIVE% === C: (system disk)

%HOMEPATH% ===\Documents and Settings\Administrator

:: enumerate the current environment variables

setlocal enabledelayedexpansion

FOR/F "usebackq delims==" %%i IN (`set`) DO @echo %%i !%%i!

### 2) to pass parameters to the batch file

% [1-9] represents a parameter, the parameter is a string when running the batch file after the file name with a space of (or Tab) separated.

Variable from 0% to 9%, 0% denotes batch command itself, other parameter string represented by the order of 9% to 1%.

Sample:

call test2.bat "hello" "haha" (executed under the same directory "test2.bat" file and enter the two parameters)

In "test2.bat" file write:

echo% 1 (print: "hello")

echo% 2 (print: "haha")

echo% 0 (Print: test2.bat)

echo% 19 (print: "hello" 9)

## Third, the basic batch command

### 0. help command

/? Command

Syntax: command/?

To display help information for this command

Sample: type/>> tmp.txt (to help write the type command to tmp.txt file)?

Sample: help type (display with "type/?" The same)

### 1.Echo command

Syntax: echo [{on | off}] [message]

ECHO [ON | OFF] turn on the echo function or echo off.

ECHO display the current echo setting.

ECHO [message] display information.

echo off after this statement represents all run commands are not displayed command line itself; the default is on, displays such as the time on: C:\folder path> command line.

In practice we put this command and redirection symbols (also referred to as the pipe symbol, generally used> >> ^) combined to achieve a particular input commands into a file format.

Sample: echo off

Sample: echo hello world (showing "hello world")

Sample: echo Windows Registry Editor Version 5.00> c:\setupreg.reg (previously not setupreg.reg this file)

Sample: echo "SourcePath" = "D:\\Win2003\\" >> c:\setupreg.reg (setupreg.reg additional content into this document)

### 2. @ command

@ Indicates that the following command does not show (in the invasion process naturally can not let the other side to see the commands you use it)

@ Echo off and alike, but it is applied on top of each command line, this line does not display the command line (only affect the current line) represents the runtime.

Sample: @echo off (commonly used in the beginning of this statement, said they did not display all the command-line information, including this sentence)

Sample: @echo please wait a minite ...

Sample: @format X:/q/u/autoset

(Format of this command is to not use/y this parameter, the good news is that Microsoft left a autoset this parameter to us, the effect and/y is the same.)

### 3.Goto command

Syntax: goto label (label is a parameter that specifies a batch program to turn in the line.)

After you specify a jump to the label line, find the tag line, the program will start processing commands from the next line.

Name label tag can easily play, but the best is meaningful, you must add a colon before the letter ":" This letter is to represent the label.

goto command is based on this colon to find the next jump to get there. If often used in conjunction with, a command to perform different groups according to different conditions.

See examples "5.Pause command"

### 4.Rem command

Syntax: Rem Message ...

(Tip: use :: instead of rem)

Comment Command, comparable/*...*/in C language, and it will not be executed, just a comment from the role to facilitate others to read and modify their own future.

Sample: @Rem Here is the description.

### 5.Pause command

It will suspend execution of the batch and displays the prompt Press any key to continue ... and wait for the user to press any key to continue on screen

Sample:

@echo off

:begin

copy a:*.* d:\back

echo Please put a new disk into driver A

pause

goto begin

In this example, drive A all files on the disk are copied to d:\back in.

Information display prompts you to insert another disk into drive A when, pause command causes the program to hang, so that you can change disks and then press any key to copy again.

### 6.Call command

Syntax: call [[Drive:] [Path] FileName [BatchParameters]] [: label [arguments]]

Parameters: [Drive:] [Path] the location and name of the batch program FileName to be invoked. filename parameter must have a .bat or .cmd extension.

Call another batch program, and not stopping the parent batch program.

If you do not call directly call another batch file, after executing the batch file will not return the current file and execute the current file subsequent commands.

call command accepts labels as a target of the call. If you use the Call outside of a script or batch file, it will not work on the command line.

Sample: call = "% cd%\test2.bat" haha kkk aaa (call test2.bat in the specified directory, and enter the three parameters to him)

Sample: call test2.bat arg1 arg2 (call test2.bat under the same directory, and enter the two parameters to him)

Note: You can call itself (infinite loop, recursion)

### 7.start command

Call an external program, all DOS commands and command-line programs can be called by the start command.

Intrusion common parameters:

MIN beginning when the window is minimized

SEPARATE start 16-bit Windows program in separate space

HIGH HIGH classes begin in the priority application

REALTIME category start an application in REALTIME priority

WAIT Start application and wait for it to end

These parameters to transmit parameters to the command/program

Sample: start/MIN test2.bat arg1 arg2 (test2.bat call under the same directory, and the two input parameters to him, and the present window is minimized)

Sample: e:\"program files"\(file path name with spaces) Need train schedule\jpskb.exe

### 8.If command

if said it would determine whether compliance with the conditions thus decided to implement different commands. There are three formats:

#### 1) IF

Syntax: if [not] command "Parameters" == "string" to be executed

If the parameter is equal to (not-equal, the same below) the specified string, the condition is true, run the command, or run the next one. (Note the two equal sign)

Sample: if "%1" == "a" format a:

Sample: if {%1} == {} goto noparms

#### 2) if exist

Syntax: if [not] exist [path\] filename command to be executed

If you have a designated file, the condition is true, run the command, or run the next one.

Sample: if exist config.sys edit config.sys (indicate if the existence of this file, edit it, it is difficult to see with the system editor)

Sample: if exist config.sys type config.sys (indicate if this file exists, its contents will be displayed)

#### 3) if errorlevel number

Command if [not] errorlevel <number> to be performed: Syntax

If the program returns a value equal to the specified number, then the condition is true, run the command, otherwise a run. (Return value must be arranged in descending order)

Sample:

@echo off

XCOPY F:\test.bat D:\

IF ERRORLEVEL 1 (ECHO file copy failed

) Else IF ERRORLEVEL 0 ECHO successfully copy files

pause

Many DOS programs running at the end returns a numeric value to indicate the result of running (or state), also known as known as the error code errorlevel return code.

Common return code is 0. Analyzing the program may return value if errorlevel command decides to perform different commands depending on the return value.

#### 4) else

Syntax: if condition (command to execute when established) else (command to execute when not established)

If more than one condition, use parentheses to recommend appropriate conditions for each wrap, to avoid mistakes.

Sample: if 1 == 0 ( echo comment1 ) else if 1==0 ( echo comment2 ) else (echo comment3 )

Note: If you need to wrap else statement, end of the line if required execution "^" connected, and the action performed if required (enclosed), otherwise an error

Sample: if 1 == 0 ( echo comment1 ) else if 1==0 ( echo comment2 ) ^

else (echo comment3 )

#### 5) comparison operators:

EQU - equal (typically using the "==")

NEQ - not equal (not in favor "if not 1 == 1" is written "=!")

LSS - less than

LEQ - less than or equal to

GTR - greater than

GEQ - greater than or equal to

### 9.choice command

With this choice allows the user to enter a command character (for selection), thereby returning errorlevel different according to a user's selection,

And then with the if errorlevel choose a different running order.

Note: The external command choice for the DOS command or Windows systems offer different versions of the command syntax is slightly different choice, please use the choice/view usage?.

choice Use this command allows the user to enter a character, which run different commands.

It should be added when using/c: parameter, c: prompt should write the characters can be entered, with no spaces between the rear. Its return code is 1234 ......

Sample: choice/c:dme defrag,mem,end

The show: defrag, mem, end [D, M, E]?

Sample:

choice/c:dme defrag,mem,end

if errorlevel 3 goto defrag (the highest value should be determined error code)

if errorlevel 2 goto mem

if errotlevel 1 goto end

### 10.for command

is a command for more complex commands, parameters for main loop execution command within the specified range.

1) for {%variable | %%variable} in (set) do command [command-parameters]

% Variable parameter specifies a single letter replaceable. Variable names are case sensitive, so different from% i% I

To use the FOR command in a batch file, specify variables suggested %% variable instead of% variable.

(Set) to specify one or a group of files. You can use wildcards.

command specified command for each file.

command-parameters specify parameters for a particular command or command-line switches.

2) If command extensions are enabled, the FOR command following additional formats are supported:

a.FOR/D %variable IN (set) DO command [command-parameters]

If the set which contains wildcards, then specifies the directory name match, but not match the file name.

b.FOR/R [[drive:]path] %variable IN (set) DO command [command-parameters]

Check to [drive:] path for the root of the tree, each directory in the FOR statement.

If no directory after/R, then the current directory. If set is just a single point (.) Character, then enumerate the directory tree.

c.FOR/L %variable IN (start,step,end) DO command [command-parameters]

This represents a sequence of digits set in increments from the start to the end.

Such as: (1,1,5) to produce a sequence of 12 345; and (5, 1,1) to generate a sequence of (54321).

. D with or without usebackq options:

FOR/F ["options"] %variable IN (file-set) DO command

FOR/F ["options"] %variable IN ("string") DO command

FOR/F ["options"] %variable IN (command) DO command

Parameters "options" are:

eol = c - refers to the end of a comment character line (on a, such as ";")

skip = n - refers to the number of rows to ignore when the file starts.

delims = xxx - refers to a set of delimiters. This replaces the spaces and tab default delimiter set.

tokens = x, y, mn - means a symbol which is transmitted to each line for each iteration itself. This leads to assign additional variable names.

mn a range format. Specifies the mth through the nth tokens.

If the last character asterisk symbol string, then an additional variable is allocated and receives the remaining text on the line after the last token parsed.

usebackq - Specifies the new syntax has been used in the following types of cases:

A quoted string as a command after performing a single quote character and a text string command and allows the use of the double spread from the file name in quotation marks in filenameset.

#### 3) Sample:

\1. The following command line displays the current directory to bat or txt file name extension.

for %%c in (*.bat *.txt) do (echo %%c)

a. All the following command line displays with e in the current directory or the directory name i.

for/D %%a in (*e* *i*) do echo %%a

b. the following command line displays the test directory E drive all to bat or txt file name extension.

for/R E:\test %%b in (*.txt *.bat) do echo %%b

for/r %% c in (*) do (echo %% c) :: traverse all files in the current directory

c. the following command line generates the sequence 12345

for/L %%c in (1,1,5) do echo %%c

d. following two sentences, it displays the current date and time

For/f "tokens = 1-3 delims = -./" %% j In ( 'Date/T') do echo %% j %% k dated on May %% l

Minutes and %% k %% j In ( 'TIME/T') do echo %% j: For/f "tokens = 1,2 delims ="

e. Place the front of each row of content notepad eight characters removed

setlocal enabledelayedexpansion

for/f %%i in (zhidian.txt) do (

set atmp=%%i

set atmp=!atmp:~8!

if {!atmp!}=={} ( echo.) else echo !atmp!

)

:: Notepad to read the contents (using delims in order to show the whole line, otherwise it will be a space as a separator)

for/f "delims=" %%a in (zhidian.txt) do echo.%%a

#### 4) continue and break

Use goto implement procedures commonly used in continue and break command, it is actually very simple

continue: in the last line of the for loop written on a label, you can jump to this position

break: In an outer loop for writing on a label, to jump to this position

Sample: (pseudocode)

for/F ["options"] %variable IN (command) DO (

... do command ...

if ... goto continue

if ... goto break

... do command ...

:continue

)

:break

## Fourth, other commands

### 1. ping command

Test conditions and network connection information packet transmission and reception conditions. But you can not test port.

Syntax: ping IP address or host name [-t] [-a] [-n count] [-l size]

Definition:

-t continue to send data to the target host;

-a IP address format to display the network address of the target host;

Ping -n count specifies how many times a specific number of times specified by the count;

-l size specified packets sent to the target host.

Sample: ping 192.168.0.1 -t (test stop 192.168.0.1, press Stop ctrl + c)

Sample:. For/L %% a in (0,1,255) do ping 192.168.0 %% a -n 1 >> tmp.txt (ping at all LAN PCs)

### 2. telnet command

Test port using telnet IP address or host name of the port, using tcp protocol

Sample: telnet 192.168.0.1 80 (test port 80 of 192.168.0.1)

### 3.color command

Set the background color and font

Syntax: color bf

b is the background color specified hexadecimal number; f specifies the foreground color (ie, font color).

Color values: 0: Black 1: Blue 2: green 3: 4 Sky Blue: Red 5: Purple 6: * 7: White

8: Gray 9: light blue A: light green B: light green C: pink D: purple E: yellow F: white

If you have not given any parameters, this command will restore the color to color when CMD.EXE started.

If the two parameters, as considered invalid input. When there is only one parameter, set the font.

### 4. random order

It generates a random number (a positive integer of 0 ~)

### 5. exit command

The end of the program. Instant is the program is called, will not return after the end of the original program

### 6. shutdown command

shutdown -s Shutdown

## Fifth, string processing

### 1) Split string to view time as an Example

% Source string: - start value, intercept length% (start from zero; intercept length is optional, if taken commas and length, will be taken from the start value to the end;

If the length of the intercept is negative, the first number indicates the reciprocal intercepted. )

"% Time%" displayed as: "11: 04: 23.03" (full time "hh: mm: ss.tt")

"% Time: ~ 0,5%" Display "hh: mm" (i.e., "11:04"), where 0 represents the number of shift operation from right to left, left to right 5 represents a shift operation number

"% Time: ~ 0,8%" displays the standard time format "hh: mm: ss" (i.e., "11:04:23", the first eight string)

"% Time: ~ 3, -3%" Display "mm: ss" (i.e., the fourth from the beginning, the last three truncated string)

"% Time: ~ 3%" Display "04: 23.03" (i.e., the first four string removed)

"% Time: ~ -3%" displayed ".tt" (i.e. the last three strings)

The above division string format, may also be used in other places such as the directory path: "% cd: ~ 0,10%"

### 2) replacement string

set a="abcd1234"

echo% a% Display: "abcd1234"

set a =% a: 1 = kk% replace "1" to "KK"

echo% a% Display: "abcdkk234"

### 3) the combined string

Since there is no direct string merge function, with only the simplest method.

set str1 =% str1 %% str2% (combined str1 and str2)

### 4) Calculate the length of the string

No ready functions. Goto loop formed using the following procedure, the string will be truncated 1 constantly, and record the number of truncated, the number of times the string becomes empty, i.e. the length.

set testStr=This is a test string

:: Copy testStr to str, str is a temporary string

set str=%testStr%

:: label for goto jump

:next1

:: str judgment is not empty, the statement if it is not to run the following

if not "%str%"=="" (

:: arithmetic operation, so that the incremented value of the num 1, num corresponds num ++ ++ statements or

set/a num+=1

:: string interception, each truncated 1

set "str=%str:~1%"

Jump to next1 :: Tags: tags and goto utilized herein to form a cyclic structure

goto next1

)

:: When the above loop structure is finished, it will execute the following statement

echo testStr=%testStr%

Echo testStr length is:% num%

### 5) When the character string taken, onPassivate

Direct echo% args: ~% num%, - 5% no way want to string requires the following two steps

setlocal enabledelayedexpansion

echo !args:~%num%,-5!

## Sixth, the registry operation

1) Back up the registry, the [HKEY_LOCAL_MACHINE ... Run] content, backup to "c:\windows\1.reg"

reg export HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run c:\windows\1.reg

reg export HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run c:\windows\2.reg

2) modify/add the registry content

a. General added or modified

reg add "HKCU\Environment"/v Java_Home/t reg_sz/d "D:\Java\jdk1.6.0_07"/f

On Sentences: "HKCU" is an abbreviation of "HKEY_CURRENT_USER", do not use the full name may be abbreviated;

Add the name "Java_Home" variable; type "reg_sz", another common type is "reg_dword"; is D:\Java\jdk1.6.0_07;

b. Using variables

set SoftWareHome=HKEY_LOCAL_MACHINE\SOFTWARE\JavaSoft\Java

reg add "%SoftWareHome%Web Start\1.6.0_07"/v Home/t reg_sz/d "%cd%\jre1.6.0_07\bin"/f

c. If there are spaces in the name registry, or data with a special symbol

reg add "%SoftWareHome2%\HelpCommands"/v "01:Online Documentation"/t reg_sz/d "\"%cd%\Documentation\Index.htm\""/f

Incoming (this value with double quotation marks): "D:\ProgramFiles\1.work_soft\Sybase\PowerDesigner_12\Documentation\Index.htm"

reg add "%SoftWareHome2%\Paths"/v ReportTemplates/t reg_sz/d "%cd%\Resource Files\Report Templates\\"/f

Incoming value ( "\" at the end): E:.\Holemar\1.notes\90 Windows\Resource Files\Report Templates\

d. additions empty

reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Shared Tools\MSConfig\startupreg\IMJPMIG8.1"

e. add or modify default values

reg add "%vpath%InstallPath"/ve/t reg_sz/d "%cd%"/f

Here "/v variable name" when using the "/ve" instead of general changes, you can modify the default values

3) delete the contents of the registry

Double quotes registry is a directory, the following two will delete all information in this catalog

reg delete "HKEY_CURRENT_USER\Software\RealVNC"/f

reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\RealVNC"/f

Double quotes registry is a directory, the following sentence is deleted certain information specified under this directory

reg delete "HKEY_LOCAL_MACHINE\Software\RealVNC"/v VNC_Server/f

Common Position 4) Registry

. A system startup items:

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run]

[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run]

example: REG ADD HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Run/v VNC_Server/t REG_SZ/d "%cd%\VNC_Server.bat"/f

. B system environment variables:

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment]

. C current user's environment variables:

[HKEY_CURRENT_USER\Environment]

5) After modifying the registry, the end and reload explorer.exe process, refresh the registry to make it take effect

taskkill/f/im explorer.exe >nul

start "" "explorer.exe"

## Seven, system services

1) stop the service: NET STOP service name

Start the service: NET Start service name

2) Set Start Type

Automatic: SC CONFIG START = auto service name

Manual: SC CONFIG service name START = demand

Disabled: SC CONFIG service name START = disabled

Attachment: "START =" must be a blank space after the equal sign. (Start there boot, system two values)

Sample: SC CONFIG Spooler START = demand (add printer, set to manual, automatic default)

3) Check system services: start% SystemRoot%\system32\services.msc/s

## Eight, setlocal with variable delay

0) in the absence of open variable delay, a command line variables change, you must go to the next command in order to reflect.

Also for example, commands, etc., followed by a pair of parentheses all statements also as a closed line.

example:

set a=4

set a=5 & echo %a%

Results: 4

Variables can also be utilized for this mechanism, the following exchange

example:

set var1=abc

set var2=123

Before echo exchange: var1 =% var1% var2 =% var2%

set var1=%var2%& set var2=%var1%

After exchanging echo: var1 =% var1% var2 =% var2%

1) Start localization of environment variables in a batch file. Localization will continue to endlocal command appears to match or reaches the end of the batch file.

Syntax: setlocal {enableextension | disableextensions} {enabledelayedexpansion | disabledelayedexpansion}

enableextension: Enable command extensions until the matching endlocal command appears, regardless of the setting before setlocal command.

disableextensions: Disable command extensions until the matching endlocal command appears, regardless of the setting before setlocal command.

enabledelayedexpansion: Enabling delayed environment variable expansion until the matching endlocal command appears, regardless of the setting before setlocal command.

disabledelayedexpansion: Disable delayed environment variable expansion until the matching endlocal command appears, regardless of the setting before setlocal command.

2) In order to be able to perceive the dynamic changes in the environment variable, the variable delay batch design. In short, after reading a complete sentence, not immediately assigned to the variable line, but will then be assigned before the implementation of a single statement, that "delay" the assignment to a variable.

examle:

setlocal enabledelayedexpansion

set a=4

set a=5 & echo !a!

Results: 5

Variable delay start statement is "setlocal enabledelayedexpansion", and the variable to use one pair of exclamation "!!" quotes

Since the start of the variable delay, so that the batch can perceive changes dynamically, i.e. not give the line variable assignment, variables are assigned but during operation, and therefore at this time is a value of 5

In addition, the variable delay start, "%" of the variable or constant

example2:

setlocal enabledelayedexpansion

for/l %%i in (1,1,5) do (

set a=%%i

echo !a!

)

As a result, printing from 1 to 5; if not a variable delay, a variable is not printing

## Nine, document processing

### 1. Delete

1) delete a file or multiple files

del/s/q/f d:\test\a.bat

Will delete d:\test\a.bat, no Task Tips

del temp\*/q/f/s

This catalog will delete all files in the temp directory, no Task Tips

Delete files when you can use '*' as a wildcard

### 2) Delete an empty directory

rd/q/s d:\test\log

Will delete d:\test\log directory, log directory if there are files will not be deleted

### 3) delete a non-empty directory (the directory name must be specified)

rmdir/q/s d:\test\logs

You must specify a directory name, you can not use wildcards

/S in addition to the directory itself will also delete all subdirectories under the specified directory

Does not require confirmation/Q Quiet mode, with/S remove a directory tree

Regardless of whether there is inside a file or folder to delete all

### 2. Create a directory

MKDIR [drive:]path

MD [drive:]path

Path spaces, double quotes may be used, it can also be used & nbsp; alternatively

Practical part:

======================================================================

## Small excerpt:

\1. When calling other programs, case insensitive file, the file extension may be ignored

Such as: start LeapFTP.exe and start leapftp effect, are running "LeapFTP.exe" file

At the beginning of each line string will automatically find the program to run, but also in double quotation marks (file or directory name must be used when including spaces)

Such as: "D:\Program Files\Leap FTP.exe"

"LeapFTP.exe" can properly run the file, start "" "LeapFTP.exe" can properly run the file (note that the first parameter is the title of the window that appears)

\3. copy C:.\Test\* * D:\back (copy all the files C drive test folder (not including folders and subfolders things) to the D drive back folder)

\4. dir c:.\* *> A.txt (c disk file the list of write a.txt)

5.> generate and write the contents of the file (if this file is overwritten), the additional content file >>

\6. md d:\aa (Create Folder)

\7. In the end of the command plus "> NUL 2> NUL", represents the return information hidden.

\8. Wait for user input: set/p = variable name screen display information. Sample: set/p pass = Enter password:

\9. allowing users to press Enter to exit

Tips (substitute pause), the last sentence of the file: set/p tmp = operation is finished, press the Enter key to exit ...

\10. Set Title: title JDK installation

\11. The setting screen display color, such as green: color 0a

\12. clear the screen: cls

\13. Review your IP:

for/f "tokens=15" %%i in ('ipconfig ^| find/i "ip address"') do set ip=%%i

echo% ip% (% ip% at this time is their own IP address)

Updated 14 modified files

copy filename + ,,> nul (modification to the current time, if you want to modify for the specified time, to modify the system time, and then change back to the system time)

\15. The modified file extension

ren C:\test\*.jpg *.JPG

for/r %% c in (* .jpg) do (ren %% c * .JPG) :: modify the extension of all files in the current directory, including subdirectories

\16. Modify the file name of the file

rename test.jpg test2.JPG

rename *.jpg *.888.JPG

\17. Review the DNS, IP, Mac, etc.

1) Win98: winipcfg

2) Win2000 above: Ipconfig/all

3) NSLOOKUP

\18. The view shared resources on IP, you can

net view 192.168.10.8

\19. Share

A. Check your machine's resources to share: net share

B. manually delete the shared

net share shared resource name $/d

Note After $ spaces.

C. add a share:

net share mymovie=e:\downloads\movie/users:3

mymovie shared success. While limiting the number of users link up to 3 people.

\20. Open a website

start iexplore.exe [http://www.baidu.com](http://www.baidu.com/)

## Examples

\1. Generate a reg file, run it, and then delete it

echo "change windows installation file path"

echo Windows Registry Editor Version 5.00 > c:\setupreg.reg

echo [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Setup] >> c:\setupreg.reg

echo "ServicePackSourcePath"="D:\\Win2003\\" >> c:\setupreg.reg

echo "SourcePath"="D:\\Win2003\\" >> c:\setupreg.reg

Write to the registry ::

regedit/S c:\setupreg.reg

:: delete the registry files

del c:\setupreg.reg

\2. Call the exe file is not closed after the end of the solution

With the start command to run the file, such as:

start LeapFTP.exe 192.168.0.100

### 3. Set the system environment variables

:: have this environment variable, you do not need to set up direct end

if not "%JAVA_HOME%" == "" exit

:: set environment variables address

set inputJavaHome=%cd%\jdk1.6.0_07

:: set environment variables, you can also set the current user variables

set EnvironmentHome=HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment

echo is set environment variables, please wait ......

reg add "%EnvironmentHome%"/v JAVA_HOME/t reg_sz/d "%inputJavaHome%"/f

reg add "%EnvironmentHome%"/v ClassPath/t reg_sz/d ".;%%JAVA_HOME%%\lib"/f

reg add "%EnvironmentHome%"/v Path/t reg_sz/d "%%JAVA_HOME%%\bin;%Path%"/f]

:: refresh, so that the environment variables to take effect

taskkill/f/im explorer.exe >nul

start "" "explorer.exe"

### 4. hide a directory of all the files and folders

cd/d for a hidden directory (such as: D :)

for/f "usebackq delims=" %%A in (`dir/a/b`) do (attrib "%%A" -r +h -s)

\5. Use a password in the batch. Password admin, and enter the correct jump to next1, if the wrong password three times, the lock screen. .

@echo off

set num=0

:11

set/p pass = Enter password:

if "%pass%"=="admin" goto next1

set/a num=%num% + 1

if %num%==3 goto no1

goto 11

:no1

%windir%\system32\rundll32.exe user32.dll,LockWorkStation

goto 11

:next1

echo the password is correct, execute the following program

pause

### 6. Empty the Recycle Bin (unsuccessfully)

@echo off

del/f/s/q c:\recycler\*.*

:: refresh the screen

taskkill/f/im explorer.exe >nul

start "" "explorer.exe"

### 7. Allow the system off and tweet

@echo off

:begin

:: send out tweets ( "" special characters ASCII code is the actual value of 7 (key beep beep)

echo

:: let the program halted a little time around

ping -n 1 -l 1 127.1>nul

goto :begin

### 8. convert the FAT volume to NTFS

Using "CONVERT.exe" for, interpreted as follows:

CONVERT volume/FS:NTFS [/V] [/CvtArea:filename] [/NoSecurity] [/X]

volume Specifies the drive letter (followed by a colon), mount point or volume name.

/FS: NTFS NTFS specified to be converted into volumes.

/V should be run with the specified detailed Convert mode.

/CvtArea:filename

Specifies a root directory file placeholder connection NTFS file system.

/NoSecurity specify security settings that everyone can access the converted files and directories.

/X, if necessary, to force the volume to dismount. All opened handles to the volume would be invalid.

#### Procedures are as follows:

@ ECHO OFF

@ ECHO.

@ ECHO. Description

@ ECHO --------------------------------------------------------------------------

@ ECHO NTFS is a disk format. This format can store a single file (such as HD movie file) is greater than the 4G, and for

@ ECHO folder encryption, but there is a drawback is not accessible under DOS. Recommended that the D drive and the disk using NTFS format,

@ ECHO C plate may not be necessary, such as non-conversion, FAT32 and NTFS format, both read and write speed is almost no difference.

@ ECHO --------------------------------------------------------------------------

@ ECHO.

convert c:/fs:ntfs

:: D disc can be turned to NTFS

convert d:/fs:ntfs

### 9. Get My Documents

SET SF="HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders"

FOR/F "tokens=2,*" %%I IN ('REG QUERY %SF%/v Personal 2^>NUL^|FIND/I "Personal"') DO SET "myDoc=%%~J"

:: copy files to the My Documents

XCOPY/D/E/R/Y/C "%cd%\test.txt" "%myDoc%\test\"

### 10 get the current directory path

cd ./

set CURR_PATH=%cd%

==========================================

### Example:

3.IF-ERRORLEVEL

@ECHO OFF

XCOPY C:\AUTOEXEC.BAT D: IF ERRORLEVEL 1 ECHO file copy failed

IF ERRORLEVEL 0 ECHO successfully copy files

If the files are copied successfully, the screen will display "Success copy file", otherwise it will display the "File copy failed."

IF ERRORLEVEL is used to test it on a DOS command return value, the return value attention only on a command, and the return value must be determined in accordance with a descending sequential order. Therefore, the following batch file is wrong:

@ECHO OFF

XCOPY C:\AUTOEXEC.BAT D:\

CHO successfully copied files

IF ERRORLEVEL 1 ECHO copy files found

IF ERRORLEVEL 2 ECHO abort a copy operation by a user ctrl-c

IF ERRORLEVEL 3 ECHO preset error prevents the file copy operation

IF ERRORLEVEL 4 ECHO writes the copy disk error

Whether the copy is successful, the latter:

Copy File not found

Abort a copy operation by a user ctrl-c

Preset error prevents the file copy operation

Writes the copy disk error

They will be displayed.

The following is the return value and their representatives significance of several commonly used commands:

backup

0 backup success

1 backup file not found

2 file sharing conflict to stop the backup is complete

3 user aborts the backup ctrl-c

4 due to the fatal error aborted the backup operation

diskcomp

0 Comparison of the same

A comparison of different

2 operated by a user abort Comparative ctrl-c

3 As the fatal error of the comparator operation aborts

4 preset error abort compare

diskcopy

0 copy operation successful

1 non-fatal disk read/wrong

2 users ctrl-c copy operation ends

3 due to a fatal error processing the disk copy suspended

4 preset error prevents copying operations

format

0 Formatting success

3 formatting process by the user aborts ctrl-c

4 due to a fatal error handling abort the formatting

5 In the prompt "proceed with format (y/n)?" At the end user to type n

xcopy

0 Success copy files

1 copy of the file not found

2 abort a copy operation by a user ctrl-c

4 preset error prevents the file copy operation

5 copies writes the disk error

=============================================================

@echo off//shell command is not displayed.

Setlocal//environmental changes apply only to this document.

% OS%//for the current operating system.

Rem//comment line of text.

Goto label//change the order of execution, to the label position.

://define a Label tag.

Set variable name = value//define the variable

Not//negated

Netstat -na//display the current port is the point of use.

2% 0% 1% 0//for indicating the parameter for the command of the batch file, a total of 1-9 parameters.

Shift//forward for a parameter, the original 1 to 0, change the original 2 1. Each call to a mobile one shift forward.

Call//call other batch files or commands.

//Start command parameter indicates the start command is running in another window.

=============================================================

:: This batch program can automatically set the Java environment variables

@echo off

IF EXIST %1\bin\java.exe (

Enter the correct Java2SDK rem such as installation directory, start setting environment variables

@setx JAVA_HOME %1

@setx path %path%;%JAVA_HOME%\bin

@setx classpath %classpath%;.

@setx classpath %classpath%;%JAVA_HOME%\lib\tools.jar

@setx classpath %classpath%;%JAVA_HOME%\lib\dt.jar

@setx classpath %classpath%;%JAVA_HOME%\jre\lib\rt.jar

@echo on

@echo Java 2 SDK environment parameters are set, the normal exit.

) ELSE (

IF "%1"=="" (

rem fails to provide the installation directory, quit after tips

@echo on

@echo not provide Java2SDK install directory, do not do any settings, now environment variable settings.

) ELSE (

If you provide a non-rem empty installation directory but no bin\java.exe, the specified directory is wrong directory

@echo on

@echo illegal installation directory Java2SDK, do not do any settings, now environment variable settings.

)

)

## You may experience problems

### Chinese garbled

The coding bat file changed ANSI, UTF-8 garbled in win10 I would be Chinese here.

## Explanation

Part of this article reprinted from: http://m18333611647.blog.163.com/blog/static/225533041201422111365439/