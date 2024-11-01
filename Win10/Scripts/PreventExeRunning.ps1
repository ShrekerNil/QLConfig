# 定义组策略路径
$registryPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer"

# 检查组策略路径是否存在
if (-not (Test-Path -Path $registryPath)) {
    New-Item -Path $registryPath -Force
}

# 检查DisallowRun键是否存在
if (-not (Test-Path -Path "$registryPath\DisallowRun")) {
    New-Item -Path "$registryPath\DisallowRun" -Force
}

# 定义DisallowRun键的完整路径
$disallowRunPath = "$registryPath\DisallowRun"

# 显示当前阻止运行的EXE列表
function Show-BlockedExes {
    Write-Output "Current list of blocked EXE files:"
    $disallowedExes = Get-ItemProperty -Path $disallowRunPath
    $disallowedExes.PSObject.Properties | Where-Object { $_.Name -like "DisallowRun*" } | ForEach-Object {
        Write-Output "$($_.Name): $($_.Value)"
    }
    Write-Output "`n"
}

# 添加一个要阻止的EXE
function Add-BlockedExe {
    param (
        [Parameter(Mandatory = $true)]
        [string]$exePath
    )
    # 获取当前DisallowRun键的数量
    $currentDisallowRunCount = (Get-ItemProperty -Path $disallowRunPath).PSObject.Properties | Where-Object { $_.Name -like "DisallowRun*" } | Measure-Object | Select-Object -ExpandProperty Count
    $newDisallowRunIndex = $currentDisallowRunCount + 1
    Set-ItemProperty -Path $disallowRunPath -Name "DisallowRun$newDisallowRunIndex" -Value $exePath
    Write-Output "Added $exePath to the list of blocked EXE files.`n"
}

# 移除已阻止的EXE
function Remove-BlockedExe {
    param (
        [Parameter(Mandatory = $true)]
        [string]$exePath
    )
    # 获取所有DisallowRun键
    $disallowRunProperties = Get-ItemProperty -Path $disallowRunPath | Select-Object -ExpandProperty PSObject.Properties | Where-Object { $_.Name -like "DisallowRun*" }
    foreach ($property in $disallowRunProperties) {
        if ($property.Value -eq $exePath) {
            Remove-ItemProperty -Path $disallowRunPath -Name $property.Name
            Write-Output "Removed $exePath from the list of blocked EXE files.`n"
            return
        }
    }
    Write-Output "$exePath not found in the list of blocked EXE files.`n"
}

# 主菜单
do {
    Write-Output "========================================="
    Write-Output " Please select an option:"
    Write-Output " 1. Show current list of blocked EXE files"
    Write-Output " 2. Add an EXE file to block"
    Write-Output " 3. Remove a blocked EXE file"
    Write-Output " 4. Exit"
    Write-Output "========================================="
    $choice = Read-Host "Enter your choice"

    switch ($choice) {
        "1" {
            Show-BlockedExes
        }
        "2" {
            $exeToBlock = Read-Host "Enter the full path of the EXE file to block"
            Add-BlockedExe -exePath $exeToBlock
        }
        "3" {
            Show-BlockedExes
            $exeToUnblockNumber = Read-Host "Enter the number of the EXE file to unblock"
            $disallowedExes = Get-ItemProperty -Path $disallowRunPath | Select-Object -ExpandProperty PSObject.Properties | Where-Object { $_.Name -like "DisallowRun*" } | Select-Object Name, Value
            if ($exeToUnblockNumber -le $disallowedExes.Count) {
                $exeToUnblock = $disallowedExes[$exeToUnblockNumber - 1].Value
                Remove-BlockedExe -exePath $exeToUnblock
            } else {
                Write-Output "Invalid number. Please try again."
            }
        }
        "4" {
            Write-Output "Goodbye!"
        }
        default {
            Write-Output "Invalid choice, please try again."
        }
    }
} while ($choice -ne "4")