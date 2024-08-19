@ echo off

%1 %2
ver|find "5.">nul && goto :Admin
mshta vbscript:createobject("shell.application").shellexecute("%~s0","goto :Admin","","runas",1)(window.close) & goto :eof
:Admin

set path=%~dp0
echo install mysql service...
echo %path%
cd %path%\bin\
mysqld.exe --remove mysql
mysqld.exe --install mysql
echo start mysql Service
"%SystemRoot%"\system32\net start mysql