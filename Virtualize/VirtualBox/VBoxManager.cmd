@echo off
setlocal enabledelayedexpansion

:: Define the list of virtual machine names
set VM_LIST=(k8s-master k8s-node1 k8s-node2 k8s-registry)

:: List all running virtual machines
:LIST_VMS
cls
echo ----------------------------------------------------
echo ---------------- VirtualBox Manager ----------------
echo ----------------------------------------------------
echo Available Virtual Machines:
echo --------------------------
VBoxManage list runningvms
echo.

:: Provide options
echo ----------------------------------------------------
echo CHOOSE AN ACTION:
echo *  1. Start VMs ...
echo *  2. Stop VMs ...
echo *  3. Restart VMs ...
echo *  4. Restore and Restart VMs ...
echo *  5. Exit
echo ----------------------------------------------------
echo.
set /p action=* Enter your choice (1-5):

if %action%==1 (
  goto START_VMS
) else if %action%==2 (
  goto STOP_VMS
) else if %action%==3 (
  goto RESTART_VMS
) else if %action%==4 (
  goto RESTORE_BACKUP_VMS
) else if %action%==5 (
  goto END
) else (
  echo Invalid option. Default is goto RESTORE_BACKUP_VMS .
  pause
  goto RESTORE_BACKUP_VMS
)

:: Start the specified virtual machines
:START_VMS
cls
echo * Starting virtual machines ...
echo.
for %%v in %VM_LIST% do (
  echo *******************************
  echo Starting %%v ...
  VBoxManage startvm %%v
  echo.
)
echo.
echo * All virtual machines have been started.
pause
goto LIST_VMS

:: Stop the specified virtual machines
:STOP_VMS
cls
echo * Stopping virtual machines ...
echo.
for %%v in %VM_LIST% do (
  echo *******************************
  echo ** Stopping %%v ...
  VBoxManage controlvm %%v poweroff
  echo.
)
echo.
echo * All virtual machines have been stopped.
pause
goto LIST_VMS

:RESTART_VMS
cls
echo * Restarting virtual machines ...
echo.
for %%v in %VM_LIST% do (
  echo *******************************
  echo ** Restarting %%v ...
  VBoxManage controlvm %%v reset
  echo.
)
echo.
echo * All virtual machines have been restarted.
pause
goto LIST_VMS

:RESTORE_VMS
cls
echo * Restoring virtual machines ...
echo.
for %%v in %VM_LIST% do (
    echo "*******************************"
    echo Restoring virtual machine "%%v" to backup "%backup_name%"...
    VBoxManage snapshot "%%v" restore "%backup_name%"
    if !errorlevel! neq 0 (
        echo Unable to restore "%%v" to backup "%backup_name%". Please check the backup name and try again.
    ) else (
        echo Successfully restored "%%v" to backup "%backup_name%".
    )
    echo.
)
echo.
echo * All virtual machines have been restored.
pause
goto LIST_VMS

:RESTORE_BACKUP_VMS
echo -----------------------------------------------
echo ------------  VBox BACKUP RESTORE  ------------
echo -----------------------------------------------
echo Please select the Backup Name to restore to:
echo 1. perfect-init
echo 2. before-cni
echo -----------------------------------------------
echo.
set /p option=Enter option (1 or 2) for backup name:
if %option%==1 (
  set backup_name=perfect-init
) else if %option%==2 (
  set backup_name=before-cni
) else (
  echo Invalid option. Please enter 1 or 2.
  pause
  set backup_name=perfect-init
)

echo * Stopping virtual machines ...
echo.
for %%v in %VM_LIST% do (
  echo *******************************************
  echo ** Stopping %%v ...
  VBoxManage controlvm %%v poweroff
  echo.
)
echo.
echo * All virtual machines have been stopped.
echo.

echo * Restoring virtual machines ...
echo.
for %%v in %VM_LIST% do (
    echo *******************************************
    echo Restoring virtual machine "%%v" to backup "%backup_name%"...
    VBoxManage snapshot "%%v" restore "%backup_name%"
    if !errorlevel! neq 0 (
        echo Unable to restore "%%v" to backup "%backup_name%". Please check the backup name and try again.
    ) else (
        echo Successfully restored "%%v" to backup "%backup_name%".
    )
    echo.
)
echo.
echo * All virtual machines have been restored.

echo * Starting virtual machines ...
echo.
for %%v in %VM_LIST% do (
  echo *******************************************
  echo Starting %%v ...
  VBoxManage startvm %%v
  echo.
)
echo.
echo * All virtual machines have been started.

echo All virtual machines have been restored and started.
echo Press any key to continue running the script...
pause > nul
goto LIST_VMS

:: End the script
:END
echo * Exiting ...
endlocal
exit /b