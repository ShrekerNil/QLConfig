# Get-ItemProperty HKLM:\SYSTEM\CurrentControlSet\Enum\HID\*\*\Device` Parameters FlipFlopWheel -EA 0 | ForEach-Object { Set-ItemProperty $_.PSPath FlipFlopWheel 1 }
# Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope CurrentUser

Write-Host "===================================================================="
Write-Host "Checking script permissions, please wait ..."
Write-Host "`n"

if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "This script requires administrator privileges. Please re-run this script as an administrator." -ForegroundColor Red
    Start-Process powershell.exe "-File `"$PSCommandPath`"" -Verb RunAs
    exit
}


Write-Host "Changing the direction of the mouse wheel to forward, a second ..."
Write-Host "`n"

Get-ItemProperty HKLM:\SYSTEM\CurrentControlSet\Enum\HID\*\*\Device` Parameters FlipFlopWheel -EA 0 | ForEach-Object { Set-ItemProperty $_.PSPath FlipFlopWheel 1 }

Read-Host -Prompt "Press Enter to continue ... "
