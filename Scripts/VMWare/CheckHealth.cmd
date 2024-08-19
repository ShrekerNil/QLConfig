@echo off
color 2E
set YYYYmmdd=%date:~0,4%%date:~5,2%%date:~8,2%
set hhmiss=%time:~0,2%%time:~3,2%%time:~6,2%
set filename=healthcheck.log
REM set "filename=healthcheck_%YYYYmmdd%_%hhmiss%.log"
set allCount=0
set errorCount=0
set checkList="VMwareHostd" "VMAuthdService" "VMnetDHCP" "VMware NAT Service" "VMUSBArbService"
echo ============================================
echo Health Checking
echo ============================================
echo.
echo.
for %%L in (%checkList%) do call :health_check %%L
echo ============================================
echo Checking Finish.
echo.
echo Error : %errorCount% of %allCount%
echo.
echo ============================================
call :check_status
echo ============================================
pause
goto:end

:health_check
sc query | find /i %1 >nul 2>nul
if not errorlevel 1 (
 echo Success   ...... %1
)else (
 echo FAILD   ........ %1 IS NOT RUNNING, CHECKING IT WHEN U SEEE ME!!!!!!!!!!
 set /a errorCount+=1
)
set /a allCount+=1
goto:eof

:check_status
if %errorCount% gtr 0 (
 echo ###### THIS SERVER IS NOT HEALTH
) else (
 echo ###### This server is Good.
)
goto:eof

:end
