# ���������·��
$registryPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer"

# ��������·���Ƿ����
if (-not (Test-Path -Path $registryPath)) {
    New-Item -Path $registryPath -Force
}

# ���DisallowRun���Ƿ����
if (-not (Test-Path -Path "$registryPath\DisallowRun")) {
    New-Item -Path "$registryPath\DisallowRun" -Force
}

# ����DisallowRun��������·��
$disallowRunPath = "$registryPath\DisallowRun"

# ��ʾ��ǰ��ֹ���е�EXE�б�
function Show-BlockedExes {
    Write-Output "Current list of blocked EXE files:"
    $disallowedExes = Get-ItemProperty -Path $disallowRunPath
    $disallowedExes.PSObject.Properties | Where-Object { $_.Name -like "DisallowRun*" } | ForEach-Object {
        Write-Output "$($_.Name): $($_.Value)"
    }
    Write-Output "`n"
}

# ���һ��Ҫ��ֹ��EXE
function Add-BlockedExe {
    param (
        [Parameter(Mandatory = $true)]
        [string]$exePath
    )
    # ��ȡ��ǰDisallowRun��������
    $currentDisallowRunCount = (Get-ItemProperty -Path $disallowRunPath).PSObject.Properties | Where-Object { $_.Name -like "DisallowRun*" } | Measure-Object | Select-Object -ExpandProperty Count
    $newDisallowRunIndex = $currentDisallowRunCount + 1
    Set-ItemProperty -Path $disallowRunPath -Name "DisallowRun$newDisallowRunIndex" -Value $exePath
    Write-Output "Added $exePath to the list of blocked EXE files.`n"
}

# �Ƴ�����ֹ��EXE
function Remove-BlockedExe {
    param (
        [Parameter(Mandatory = $true)]
        [string]$exePath
    )
    # ��ȡ����DisallowRun��
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

# ���˵�
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