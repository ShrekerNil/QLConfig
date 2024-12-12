# AppLocker ����ű�

# �������޸� PowerShell Execution Policy
function Set-ExecutionPolicyOption {
    Write-Host "`nPowerShell Execution Policy ����" -ForegroundColor Cyan
    Write-Host "1. �޸� Execution Policy Ϊ RemoteSigned�������ؽű�ִ�У�"
    Write-Host "2. ���ֵ�ǰ Execution Policy ����"
    $choice = Read-Host "��ѡ��һ��������1-2��"

    switch ($choice) {
        1 {
            try {
                Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
                Write-Host "Execution Policy ���޸�Ϊ RemoteSigned��" -ForegroundColor Green
            } catch {
                Write-Host "�޸� Execution Policy ʧ��: $_" -ForegroundColor Red
            }
        }
        2 {
            Write-Host "���ֵ�ǰ Execution Policy ���䡣" -ForegroundColor Yellow
        }
        default {
            Write-Host "��Ч��ѡ�񣬱��ֵ�ǰ Execution Policy ���䡣" -ForegroundColor Red
        }
    }
}

# �������г������ѽ��õ�Ӧ��
function ListBlockedApps {
    Write-Host "`n�ѽ��õ�Ӧ���б�" -ForegroundColor Cyan

    # ��ȡ AppLocker ��ִ���ļ�����
    $executableRules = Get-AppLockerPolicy -Effective | Select-Object -ExpandProperty RuleCollections | Where-Object { $_.RuleCollectionType -eq 'Exe' }

    if ($executableRules) {
        foreach ($rule in $executableRules) {
            if ($rule.Name -like "*Block*") {
                Write-Host "- $($rule.Name): $($rule.Conditions.Path.Path)" -ForegroundColor Yellow
            }
        }
    } else {
        Write-Host "û���ѽ��õ�Ӧ�á�" -ForegroundColor Yellow
    }
}

# ��������ӽ�ֹ���е�Ӧ��
function AddBlockedApp {
    Write-Host "`n��ӽ�ֹ���е�Ӧ��" -ForegroundColor Cyan

    # ����Ӧ��·��
    $appPath = Read-Host "������Ҫ��ֹ���е�Ӧ�ó��������·�������磺C:\Path\To\YourApp.exe��"
    
    if (-Not (Test-Path $appPath)) {
        Write-Host "·����Ч���ļ������ڡ�" -ForegroundColor Red
        return
    }

    # �����µ���ֹ����
    try {
        New-AppLockerPolicy -RuleType Exe -User Everyone -Path $appPath -Action Deny -ErrorAction Stop | Out-Null
        Write-Host "�ѳɹ���ӽ�ֹ����$appPath" -ForegroundColor Green
    } catch {
        Write-Host "��ӹ���ʧ��: $_" -ForegroundColor Red
    }
}

# ������ɾ����ֹ���е�Ӧ��
function RemoveBlockedApp {
    Write-Host "`nɾ����ֹ���е�Ӧ��" -ForegroundColor Cyan

    # ����Ҫɾ����Ӧ��·��
    $appPath = Read-Host "������Ҫɾ���Ľ�ֹ���е�Ӧ�ó��������·�������磺C:\Path\To\YourApp.exe��"

    # ��ȡ��ǰ AppLocker ����
    $policy = Get-AppLockerPolicy -Effective

    # ���Ҳ�ɾ��ƥ��Ĺ���
    $rulesToRemove = $policy.RuleCollections.Exe | Where-Object { $_.Conditions.Path.Path -eq $appPath }

    if ($rulesToRemove) {
        try {
            $policy.RuleCollections.Exe = $policy.RuleCollections.Exe | Where-Object { $_.Conditions.Path.Path -ne $appPath }
            Set-AppLockerPolicy -PolicyObject $policy -ErrorAction Stop
            Write-Host "�ѳɹ�ɾ����ֹ����$appPath" -ForegroundColor Green
        } catch {
            Write-Host "ɾ������ʧ��: $_" -ForegroundColor Red
        }
    } else {
        Write-Host "δ�ҵ�ƥ��Ľ�ֹ����" -ForegroundColor Yellow
    }
}

# ���� Execution Policy
Set-ExecutionPolicyOption

# ��ѭ��
while ($true) {
    Write-Host "`nAppLocker ����˵�" -ForegroundColor Blue
    Write-Host "1. �г������ѽ��õ�Ӧ��"
    Write-Host "2. ��ӽ�ֹ���е�Ӧ��"
    Write-Host "3. ɾ����ֹ���е�Ӧ��"
    Write-Host "4. �˳�"
    $choice = Read-Host "��ѡ��һ��������1-4��"

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
            Write-Host "�˳���" -ForegroundColor Green
            exit
        }
        default {
            Write-Host "��Ч��ѡ�����������롣" -ForegroundColor Red
        }
    }
}