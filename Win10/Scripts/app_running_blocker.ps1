# AppLocker 管理脚本

# 函数：修改 PowerShell Execution Policy
function Set-ExecutionPolicyOption {
    Write-Host "`nPowerShell Execution Policy 设置" -ForegroundColor Cyan
    Write-Host "1. 修改 Execution Policy 为 RemoteSigned（允许本地脚本执行）"
    Write-Host "2. 保持当前 Execution Policy 不变"
    $choice = Read-Host "请选择一个操作（1-2）"

    switch ($choice) {
        1 {
            try {
                Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
                Write-Host "Execution Policy 已修改为 RemoteSigned。" -ForegroundColor Green
            } catch {
                Write-Host "修改 Execution Policy 失败: $_" -ForegroundColor Red
            }
        }
        2 {
            Write-Host "保持当前 Execution Policy 不变。" -ForegroundColor Yellow
        }
        default {
            Write-Host "无效的选择，保持当前 Execution Policy 不变。" -ForegroundColor Red
        }
    }
}

# 函数：列出所有已禁用的应用
function ListBlockedApps {
    Write-Host "`n已禁用的应用列表：" -ForegroundColor Cyan

    # 获取 AppLocker 可执行文件规则
    $executableRules = Get-AppLockerPolicy -Effective | Select-Object -ExpandProperty RuleCollections | Where-Object { $_.RuleCollectionType -eq 'Exe' }

    if ($executableRules) {
        foreach ($rule in $executableRules) {
            if ($rule.Name -like "*Block*") {
                Write-Host "- $($rule.Name): $($rule.Conditions.Path.Path)" -ForegroundColor Yellow
            }
        }
    } else {
        Write-Host "没有已禁用的应用。" -ForegroundColor Yellow
    }
}

# 函数：添加禁止运行的应用
function AddBlockedApp {
    Write-Host "`n添加禁止运行的应用" -ForegroundColor Cyan

    # 输入应用路径
    $appPath = Read-Host "请输入要禁止运行的应用程序的完整路径（例如：C:\Path\To\YourApp.exe）"
    
    if (-Not (Test-Path $appPath)) {
        Write-Host "路径无效或文件不存在。" -ForegroundColor Red
        return
    }

    # 创建新的阻止规则
    try {
        New-AppLockerPolicy -RuleType Exe -User Everyone -Path $appPath -Action Deny -ErrorAction Stop | Out-Null
        Write-Host "已成功添加禁止规则：$appPath" -ForegroundColor Green
    } catch {
        Write-Host "添加规则失败: $_" -ForegroundColor Red
    }
}

# 函数：删除禁止运行的应用
function RemoveBlockedApp {
    Write-Host "`n删除禁止运行的应用" -ForegroundColor Cyan

    # 输入要删除的应用路径
    $appPath = Read-Host "请输入要删除的禁止运行的应用程序的完整路径（例如：C:\Path\To\YourApp.exe）"

    # 获取当前 AppLocker 策略
    $policy = Get-AppLockerPolicy -Effective

    # 查找并删除匹配的规则
    $rulesToRemove = $policy.RuleCollections.Exe | Where-Object { $_.Conditions.Path.Path -eq $appPath }

    if ($rulesToRemove) {
        try {
            $policy.RuleCollections.Exe = $policy.RuleCollections.Exe | Where-Object { $_.Conditions.Path.Path -ne $appPath }
            Set-AppLockerPolicy -PolicyObject $policy -ErrorAction Stop
            Write-Host "已成功删除禁止规则：$appPath" -ForegroundColor Green
        } catch {
            Write-Host "删除规则失败: $_" -ForegroundColor Red
        }
    } else {
        Write-Host "未找到匹配的禁止规则。" -ForegroundColor Yellow
    }
}

# 设置 Execution Policy
Set-ExecutionPolicyOption

# 主循环
while ($true) {
    Write-Host "`nAppLocker 管理菜单" -ForegroundColor Blue
    Write-Host "1. 列出所有已禁用的应用"
    Write-Host "2. 添加禁止运行的应用"
    Write-Host "3. 删除禁止运行的应用"
    Write-Host "4. 退出"
    $choice = Read-Host "请选择一个操作（1-4）"

    switch ($choice) {
        1 {
            ListBlockedApps
        }
        2 {
            AddBlockedApp
        }
        3 {
            RemoveBlockedApp
        }
        4 {
            Write-Host "退出。" -ForegroundColor Green
            exit
        }
        default {
            Write-Host "无效的选择，请重新输入。" -ForegroundColor Red
        }
    }
}