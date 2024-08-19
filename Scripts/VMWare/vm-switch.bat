@ECHO off
::mode con cols=90 lines=20
title Windows SERVICE MANAGEMENT TOOL

ECHO ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ 
ECHO +              AUTOMATICALLY ESCALATE RUNNING PERMISSIONS              +
ECHO ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
ECHO.
%1 %2
ver|find "5.">nul && goto :Admin
mshta vbscript:createobject("shell.application").shellexecute("%~s0","goto :Admin","","runas",1)(window.close) & goto :eof
:Admin
ECHO ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

ECHO ------------------------------------
ECHO      LISTING SERVICES STATUS
ECHO ------------------------------------
for /f "skip=3 tokens=4" %%i in ('sc query "VMAuthdService"') do set "zt=%%i" & goto :next
:next
if /i "%zt%"=="RUNNING" (
  ECHO SERVICE OF === VMware Authorization Service === IS RUNNING ...
) else (
  ECHO SERVICE OF === VMware Authorization Service === STOPPPED.
)
for /f "skip=3 tokens=4" %%i in ('sc query "VMnetDHCP"') do set "zt=%%i" & goto :next
:next
if /i "%zt%"=="RUNNING" (
  ECHO SERVICE OF === VMware DHCP Service === IS RUNNING ...
) else (
  ECHO SERVICE OF === VMware DHCP Service === STOPPPED.
)
for /f "skip=3 tokens=4" %%i in ('sc query "VMware NAT Service"') do set "zt=%%i" & goto :next
:next
if /i "%zt%"=="RUNNING" (
  ECHO SERVICE OF === VMware NAT Service === IS RUNNING ...
) else (
  ECHO SERVICE OF === VMware NAT Service === STOPPPED.
)
for /f "skip=3 tokens=4" %%i in ('sc query "VMUSBArbService"') do set "zt=%%i" & goto :next
:next
if /i "%zt%"=="RUNNING" (
  ECHO SERVICE OF === VMUSBArbService Service === IS RUNNING ...
) else (
  ECHO SERVICE OF === VMUSBArbService Service === STOPPPED.
)
for /f "skip=3 tokens=4" %%i in ('sc query "VMwareHostd"') do set "zt=%%i" & goto :next
:next
if /i "%zt%"=="RUNNING" (
  ECHO SERVICE OF === VVMware Workstation Server === IS RUNNING ...
) else (
  ECHO SERVICE OF === VMware Workstation Server === STOPPPED.
)

ECHO #########################################################################
ECHO +   1: Enable SERVICES and NETWORKS   2: Disable SERVICES and NETWORKS  +
ECHO #########################################################################
CHOICE /c:12 /m "Input your Choice:"
if errorlevel 2 goto two
if errorlevel 1 goto one

:one
ECHO ++++++++++++++++++++++++++++++++++++ STARTING SERVICES ++++++++++++++++++++++++++++++++++++
net start "VMAuthdService"
net start "VMnetDHCP"
net start "VMware NAT Service"
net start "VMUSBArbService"
net start "VMwareHostd"

ECHO ++++++++++++++++++++++++++++++++++++ STARTING NETWORKS ++++++++++++++++++++++++++++++++++++
ECHO Starting VMnet1 ...
NETSH INTERFACE SET INTERFACE "VMware Network Adapter VMnet1" ADMIN=ENABLE
ECHO Starting VMnet8 ...
NETSH INTERFACE SET INTERFACE "VMware Network Adapter VMnet8" ADMIN=ENABLE

ECHO.
ECHO ++++++++++++++++++++++++++++++++++++ STARTING MAIN PROGRAM ++++++++++++++++++++++++++++++++++++
start D:\Programs\VMware\vmware.exe
ECHO.
@REM ECHO TASK FINISHED, PRESS ANY KEY TO CONTINUE ...
@REM pause>nul
exit

:two
ECHO.
ECHO ++++++++++++++++++++++++++++++++++++ STOPPING SERVICES ++++++++++++++++++++++++++++++++++++
for /f "skip=3 tokens=4" %%i in ('sc query "VMwareHostd"') do set "zt=%%i" & goto :next
:next
if /i "%zt%"=="RUNNING" (
  ECHO SERVICE OF === VVMware Workstation Server === IS RUNNING, Stopping ...
  NET STOP "VMwareHostd"
) else (
  ECHO SERVICE OF === VMware Workstation Server === Already STOPPPED.
)
for /f "skip=3 tokens=4" %%i in ('sc query "VMAuthdService"') do set "zt=%%i" & goto :next
:next
if /i "%zt%"=="RUNNING" (
  ECHO SERVICE OF === VMware Authorization Service === IS RUNNING, Stopping ...
  NET STOP "VMAuthdService"
) else (
  ECHO SERVICE OF === VMware Authorization Service === Already STOPPPED.
)
for /f "skip=3 tokens=4" %%i in ('sc query "VMnetDHCP"') do set "zt=%%i" & goto :next
:next
if /i "%zt%"=="RUNNING" (
  ECHO SERVICE OF === VMware DHCP Service === IS RUNNING, Stopping ...
  NET STOP "VMnetDHCP"
) else (
  ECHO SERVICE OF === VMware DHCP Service === Already STOPPPED.
)
for /f "skip=3 tokens=4" %%i in ('sc query "VMware NAT Service"') do set "zt=%%i" & goto :next
:next
if /i "%zt%"=="RUNNING" (
  ECHO SERVICE OF === VMware NAT Service === IS RUNNING, Stopping ...
  NET STOP "VMware NAT Service"
) else (
  ECHO SERVICE OF === VMware NAT Service === Already STOPPPED.
)
for /f "skip=3 tokens=4" %%i in ('sc query "VMUSBArbService"') do set "zt=%%i" & goto :next
:next
if /i "%zt%"=="RUNNING" (
  ECHO SERVICE OF === VMware USB Arbitration Service === Service IS RUNNING, Stopping ...
  NET STOP "VMUSBArbService"
) else (
  ECHO SERVICE OF === VMware USB Arbitration Service === Service Already STOPPPED.
)

ECHO.
ECHO +++++++++++++++++++++++++++++++++ STOPPING Main Programs ++++++++++++++++++++++++++++++++++
TASKKILL /F /IM vmware-tray.exe /T
TASKKILL /F /IM vmware.exe /T

ECHO.
ECHO ++++++++++++++++++++++++++++++++++++ STOPPING NETWORKS ++++++++++++++++++++++++++++++++++++
ECHO Stopping VMnet1 ...
NETSH INTERFACE SET INTERFACE "VMware Network Adapter VMnet1" ADMIN=DISABLE
ECHO Stopping VMnet8 ...
NETSH INTERFACE SET INTERFACE "VMware Network Adapter VMnet8" ADMIN=DISABLE

@REM ECHO TASK FINISHED, PRESS ANY KEY TO CONTINUE ...
@REM pause>nul
exit
