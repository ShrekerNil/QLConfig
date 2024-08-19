# PowerShell

> PowerShell完全可以替代cmd，又称cmdlet
>
> PowerShell中把cmd命令采用alias的方式映射到PowerShell的命令上，查看这些命令：`Get-Command <cmd-command>`
>
> 所有支持的命令请使用命令`Get-Command`，可以查看同目录`PowerShell-Cmds.txt`，包含了所有的Alias、Function、Cmdlet

## Remove app

1. 获取所有已经安装的应用名称

   ```powershell
   Get-AppxPackage | Select Name, PackageFullName
   ```

2. 直接使用命令卸载/移除

   ```powershell
   Get-AppxPackage *<short-name>*| Remove-AppxPackage
   ```

   

## Full Using

> [Remove All Built-In Apps in Windows 10 (All at once / Individually)](https://www.youtube.com/watch?v=4lltMrJngCw)

### Using

1. To get a list of all the installed apps of the current user in your Windows 10 system. 

   ```powershell
   Get-AppxPackage | ft Name, PackageFullName -AutoSize
   ```

2. To get a list of all the apps of all the users, then use this command. 

   ```
   Get-AppxPackage -AllUsers | ft Name, PackageFullName -AutoSize
   ```

3. To remove the app from your computer, you'll need to run following command: 

   ```
   Get-AppxPackage PackageFullName | Remove-AppxPackage 
   ```

4. To uninstall the app from all user accounts, you can use following command format: 

   ```
   Get-AppxPackage -allusers PackageFullName | Remove-AppxPackage
   ```

5. To remove the app from any particular user account, use following command: 

   ```
   Get-AppxPackage -user username PackageFullName | Remove-AppxPackage
   ```

6. To get rid of all the pre-installed apps:  

   ```
   Get-AppxPackage | Remove-AppxPackage
   ```

7. To uninstall all built-in apps for all user accounts: 

   ```
   Get-AppxPackage -allusers | Remove-AppxPackage
   ```

8. To uninstall all built-in apps for a particular user account: 

   ```
   Get-AppxPackage -user username | Remove-AppxPackage
   ```

9. To remove all apps but want to keep a few apps such as Windows Store, etc, you can use this command: 

   ```
   Get-AppxPackage | where-object {$_.name –notlike "*store*"} | Remove-AppxPackage
   ```

10. To keep more than one apps, you can use following syntax: 

    ```
    Get-AppxPackage | where-object {$_.name –notlike "*store*"} | where-object {$_.name –notlike "*communicationsapps*"} | where-object {$_.name –notlike "*people*"} | Remove-AppxPackage
    ```

11. To stop this default behaviour of Windows: 

    ```
    Get-AppXProvisionedPackage -online | Remove-AppxProvisionedPackage –online
    ```

### Practice

```powershell
To uninstall 3D Builder:
get-appxpackage *3dbuilder* | remove-appxpackage

To uninstall Alarms & Clock:
get-appxpackage *alarms* | remove-appxpackage

To uninstall App Connector:
get-appxpackage *appconnector* | remove-appxpackage

To uninstall App Installer:
get-appxpackage *appinstaller* | remove- appxpackage

To uninstall Calendar and Mail apps together:
get-appxpackage *communicationsapps* | remove-appxpackage

To uninstall Calculator:
get-appxpackage *calculator* | remove-appxpackage

To uninstall Camera:
get-appxpackage *camera* | remove-appxpackage

To uninstall Feedback Hub:
get-appxpackage *feedback* | remove-appxpackage

To uninstall Get Office:
get-appxpackage *officehub* | remove-appxpackage

To uninstall Get Started or Tips:
get-appxpackage *getstarted* | remove-appxpackage

To uninstall Get Skype:
get-appxpackage *skypeapp* | remove-appxpackage

To uninstall Groove Music:
get-appxpackage *zunemusic* | remove-appxpackage

To uninstall Groove Music and Movies & TV apps together:
get-appxpackage *zune* | remove-appxpackage

To uninstall Maps:
get-appxpackage *maps* | remove-appxpackage

To uninstall Messaging and Skype Video apps together:
get-appxpackage *messaging* | remove-appxpackage

To uninstall Microsoft Solitaire Collection:
get-appxpackage *solitaire* | remove-appxpackage

To uninstall Microsoft Wallet:
get-appxpackage *wallet* | remove-appxpackage

To uninstall Microsoft Wi-Fi:
get-appxpackage *connectivitystore* | remove-appxpackage

To uninstall Money:
get-appxpackage *bingfinance* | remove-appxpackage

To uninstall Money, News, Sports and Weather apps together:
get-appxpackage *bing* | remove-appxpackage

To uninstall Movies & TV:
get-appxpackage *zunevideo* | remove-appxpackage

To uninstall News:
get-appxpackage *bingnews* | remove-appxpackage

To uninstall OneNote:
get-appxpackage *onenote* | remove-appxpackage

To uninstall Paid Wi-Fi & Cellular:
get-appxpackage *oneconnect* | remove-appxpackage

To uninstall Paint 3D:
get-appxpackage *mspaint* | remove-appxpackage

To uninstall Phone:
get-appxpackage *commsphone* | remove-appxpackage

To uninstall Phone Companion:
get-appxpackage *windowsphone* | remove-appxpackage

To uninstall Phone and Phone Companion apps together:
get-appxpackage *phone* | remove-appxpackage

To uninstall Photos:
get-appxpackage *photos* | remove-appxpackage

To uninstall Sports:
get-appxpackage *bingsports* | remove-appxpackage

To uninstall Sticky Notes:
get-appxpackage *sticky* | remove-appxpackage

To uninstall Sway:
get-appxpackage *sway* | remove-appxpackage

To uninstall View 3D:
get-appxpackage *3d* | remove-appxpackage

To uninstall Voice Recorder:
get-appxpackage *soundrecorder* | remove-appxpackage

To uninstall Weather:
get-appxpackage *bingweather* | remove-appxpackage

To uninstall Windows Holographic:
get-appxpackage *holographic* | remove-appxpackage

To uninstall Windows Store: (Be very careful!)
get-appxpackage *windowsstore* | remove-appxpackage
```

These actions are Failed：

```
To uninstall People:
get-appxpackage *people* | remove-appxpackage

To uninstall Xbox:
get-appxpackage *xbox* | remove-appxpackage
```

## 常用命令

### 实战案例

1. 获取CPU占用前五的进程：`Get-Process | Sort-Object CPU -Descending | Select-Object -First 5`
2. 计算Windows目录下所有exe文件的大小：`Get-ChildItem $env:windir -Filter *.exe | Measure-Object -Sum Length`
3. 将所有的进程信息导出到csv文件：`ps | export-csv -Path test.csv` / `ps | export-html -Path test.csv`

### 其他命令

1. `Get-Command［ <cmd>］`：获取所有支持的命令，或者某个命令/方法
2. `Update-Help［ <cmd>］`：更新帮助文档
3. `Get-Alias <cmd>`：获取某个命令的别名
4. 与Linux相同的命令
   - pwd
   - ls
   - clear
   - cat
   - mkdir
   - mv
   - cp
   - rm



# Win10 Built-in Apps

| Name                                         | PackageFullName                                              |
| -------------------------------------------- | ------------------------------------------------------------ |
| Microsoft.BioEnrollment                      | Microsoft.BioEnrollment_10.0.19041.1023_neutral__cw5n1h2txyewy |
| Microsoft.Windows.CloudExperienceHost        | Microsoft.Windows.CloudExperienceHost_10.0.19041.1266_neutral_neutral_cw... |
| Microsoft.Windows.OOBENetworkConnectionFlow  | Microsoft.Windows.OOBENetworkConnectionFlow_10.0.19041.1023_neutral__cw5... |
| Microsoft.AAD.BrokerPlugin                   | Microsoft.AAD.BrokerPlugin_1000.19041.1023.0_neutral_neutral_cw5n1h2txyewy |
| Microsoft.Windows.OOBENetworkCaptivePortal   | Microsoft.Windows.OOBENetworkCaptivePortal_10.0.19041.1023_neutral__cw5n... |
| MicrosoftWindows.UndockedDevKit              | MicrosoftWindows.UndockedDevKit_10.0.19041.1023_neutral_neutral_cw5n1h2t... |
| Microsoft.Windows.StartMenuExperienceHost    | Microsoft.Windows.StartMenuExperienceHost_10.0.19041.1023_neutral_neutra... |
| Microsoft.Windows.ShellExperienceHost        | Microsoft.Windows.ShellExperienceHost_10.0.19041.1949_neutral_neutral_cw... |
| windows.immersivecontrolpanel                | windows.immersivecontrolpanel_10.0.2.1000_neutral_neutral_cw5n1h2txyewy |
| Microsoft.Windows.Search                     | Microsoft.Windows.Search_1.14.7.19041_neutral_neutral_cw5n1h2txyewy |
| Microsoft.549981C3F5F10                      | Microsoft.549981C3F5F10_1.1911.21713.0_x64__8wekyb3d8bbwe    |
| Microsoft.VCLibs.140.00.UWPDesktop           | Microsoft.VCLibs.140.00.UWPDesktop_14.0.27629.0_x64__8wekyb3d8bbwe |
| Microsoft.MicrosoftEdge                      | Microsoft.MicrosoftEdge_44.19041.1266.0_neutral__8wekyb3d8bbwe |
| Microsoft.Windows.ContentDeliveryManager     | Microsoft.Windows.ContentDeliveryManager_10.0.19041.1023_neutral_neutral... |
| Microsoft.DesktopAppInstaller                | Microsoft.DesktopAppInstaller_1.0.30251.0_x64__8wekyb3d8bbwe |
| Microsoft.UI.Xaml.2.0                        | Microsoft.UI.Xaml.2.0_2.1810.18004.0_x64__8wekyb3d8bbwe      |
| Microsoft.Windows.Photos                     | Microsoft.Windows.Photos_2019.19071.12548.0_x64__8wekyb3d8bbwe |
| Microsoft.Advertising.Xaml                   | Microsoft.Advertising.Xaml_10.1808.3.0_x64__8wekyb3d8bbwe    |
| microsoft.windowscommunicationsapps          | microsoft.windowscommunicationsapps_16005.11629.20316.0_x64__8wekyb3d8bbwe |
| Microsoft.NET.Native.Framework.1.7           | Microsoft.NET.Native.Framework.1.7_1.7.25531.0_x64__8wekyb3d8bbwe |
| Microsoft.NET.Native.Runtime.1.7             | Microsoft.NET.Native.Runtime.1.7_1.7.25531.0_x64__8wekyb3d8bbwe |
| Microsoft.WindowsStore                       | Microsoft.WindowsStore_11910.1002.5.0_x64__8wekyb3d8bbwe     |
| Microsoft.WindowsCamera                      | Microsoft.WindowsCamera_2018.826.98.0_x64__8wekyb3d8bbwe     |
| Microsoft.XboxIdentityProvider               | Microsoft.XboxIdentityProvider_12.50.6001.0_x64__8wekyb3d8bbwe |
| MicrosoftWindows.Client.CBS                  | MicrosoftWindows.Client.CBS_120.2212.4180.0_x64__cw5n1h2txyewy |
| Microsoft.MicrosoftEdge.Stable               | Microsoft.MicrosoftEdge.Stable_92.0.902.67_neutral__8wekyb3d8bbwe |
| AppUp.ThunderboltControlCenter               | AppUp.ThunderboltControlCenter_1.0.36.0_x64__8j3eq9eme6ctt   |
| Microsoft.VCLibs.140.00                      | Microsoft.VCLibs.140.00_14.0.30704.0_x64__8wekyb3d8bbwe      |
| Microsoft.VCLibs.140.00                      | Microsoft.VCLibs.140.00_14.0.30704.0_x86__8wekyb3d8bbwe      |
| Microsoft.NET.Native.Framework.2.1           | Microsoft.NET.Native.Framework.2.1_2.1.27427.0_x64__8wekyb3d8bbwe |
| Microsoft.NET.Native.Framework.2.1           | Microsoft.NET.Native.Framework.2.1_2.1.27427.0_x86__8wekyb3d8bbwe |
| Microsoft.NET.Native.Runtime.2.1             | Microsoft.NET.Native.Runtime.2.1_2.1.26424.0_x64__8wekyb3d8bbwe |
| Microsoft.NET.Native.Runtime.2.1             | Microsoft.NET.Native.Runtime.2.1_2.1.26424.0_x86__8wekyb3d8bbwe |
| Microsoft.NET.Native.Runtime.2.2             | Microsoft.NET.Native.Runtime.2.2_2.2.28604.0_x86__8wekyb3d8bbwe |
| Microsoft.NET.Native.Runtime.2.2             | Microsoft.NET.Native.Runtime.2.2_2.2.28604.0_x64__8wekyb3d8bbwe |
| Microsoft.NET.Native.Framework.2.2           | Microsoft.NET.Native.Framework.2.2_2.2.29512.0_x86__8wekyb3d8bbwe |
| Microsoft.NET.Native.Framework.2.2           | Microsoft.NET.Native.Framework.2.2_2.2.29512.0_x64__8wekyb3d8bbwe |
| AppUp.IntelGraphicsExperience                | AppUp.IntelGraphicsExperience_1.100.3408.0_x64__8j3eq9eme6ctt |
| Microsoft.AccountsControl                    | Microsoft.AccountsControl_10.0.19041.1023_neutral__cw5n1h2txyewy |
| Microsoft.MicrosoftStickyNotes               | Microsoft.MicrosoftStickyNotes_4.5.7.0_x64__8wekyb3d8bbwe    |
| NcsiUwpApp                                   | NcsiUwpApp_1000.19041.1023.0_neutral_neutral_8wekyb3d8bbwe   |
| Microsoft.Windows.SecureAssessmentBrowser    | Microsoft.Windows.SecureAssessmentBrowser_10.0.19041.1023_neutral_neutra... |
| Windows.PrintDialog                          | Windows.PrintDialog_6.2.1.0_neutral_neutral_cw5n1h2txyewy    |
| Windows.CBSPreview                           | Windows.CBSPreview_10.0.19041.1023_neutral_neutral_cw5n1h2txyewy |
| Microsoft.XboxGameCallableUI                 | Microsoft.XboxGameCallableUI_1000.19041.1023.0_neutral_neutral_cw5n1h2tx... |
| Microsoft.Windows.XGpuEjectDialog            | Microsoft.Windows.XGpuEjectDialog_10.0.19041.1023_neutral_neutral_cw5n1h... |
| Microsoft.Windows.SecHealthUI                | Microsoft.Windows.SecHealthUI_10.0.19041.1865_neutral__cw5n1h2txyewy |
| Microsoft.Windows.PinningConfirmationDialog  | Microsoft.Windows.PinningConfirmationDialog_1000.19041.1023.0_neutral__c... |
| Microsoft.Windows.PeopleExperienceHost       | Microsoft.Windows.PeopleExperienceHost_10.0.19041.1023_neutral_neutral_c... |
| Microsoft.Windows.ParentalControls           | Microsoft.Windows.ParentalControls_1000.19041.1023.0_neutral_neutral_cw5... |
| Microsoft.Windows.NarratorQuickStart         | Microsoft.Windows.NarratorQuickStart_10.0.19041.1023_neutral_neutral_8we... |
| Microsoft.Windows.CapturePicker              | Microsoft.Windows.CapturePicker_10.0.19041.1023_neutral__cw5n1h2txyewy |
| Microsoft.Windows.CallingShellApp            | Microsoft.Windows.CallingShellApp_1000.19041.1023.0_neutral_neutral_cw5n... |
| Microsoft.Windows.AssignedAccessLockApp      | Microsoft.Windows.AssignedAccessLockApp_1000.19041.1023.0_neutral_neutra... |
| Microsoft.CredDialogHost                     | Microsoft.CredDialogHost_10.0.19041.1023_neutral__cw5n1h2txyewy |
| Microsoft.ECApp                              | Microsoft.ECApp_10.0.19041.1023_neutral__8wekyb3d8bbwe       |
| Microsoft.MicrosoftEdgeDevToolsClient        | Microsoft.MicrosoftEdgeDevToolsClient_1000.19041.1023.0_neutral_neutral_... |
| Microsoft.AsyncTextService                   | Microsoft.AsyncTextService_10.0.19041.1023_neutral__8wekyb3d8bbwe |
| 1527c705-839a-4832-9118-54d4Bd6a0c89         | 1527c705-839a-4832-9118-54d4Bd6a0c89_10.0.19041.1023_neutral_neutral_cw5... |
| c5e2524a-ea46-4f67-841f-6a9465d9d515         | c5e2524a-ea46-4f67-841f-6a9465d9d515_10.0.19041.1949_neutral_neutral_cw5... |
| E2A4F912-2574-4A75-9BB0-0D023378592B         | E2A4F912-2574-4A75-9BB0-0D023378592B_10.0.19041.1023_neutral_neutral_cw5... |
| F46D4000-FD22-4DB4-AC8E-4E1DDDE828FE         | F46D4000-FD22-4DB4-AC8E-4E1DDDE828FE_10.0.19041.1023_neutral_neutral_cw5... |
| Microsoft.LockApp                            | Microsoft.LockApp_10.0.19041.1023_neutral__cw5n1h2txyewy     |
| Microsoft.Win32WebViewHost                   | Microsoft.Win32WebViewHost_10.0.19041.1023_neutral_neutral_cw5n1h2txyewy |
| Microsoft.Windows.Apprep.ChxApp              | Microsoft.Windows.Apprep.ChxApp_1000.19041.1023.0_neutral_neutral_cw5n1h... |
| Microsoft.WindowsAlarms                      | Microsoft.WindowsAlarms_10.1906.2182.0_x64__8wekyb3d8bbwe    |
| RealtekSemiconductorCorp.RealtekAudioControl | RealtekSemiconductorCorp.RealtekAudioControl_1.26.251.0_x64__dt26b99r8h8gj |
| Microsoft.ZuneVideo                          | Microsoft.ZuneVideo_10.19071.19011.0_x64__8wekyb3d8bbwe      |
| Microsoft.ZuneMusic                          | Microsoft.ZuneMusic_10.19071.19011.0_x64__8wekyb3d8bbwe      |
| Microsoft.YourPhone                          | Microsoft.YourPhone_0.19051.7.0_x64__8wekyb3d8bbwe           |
| Microsoft.XboxSpeechToTextOverlay            | Microsoft.XboxSpeechToTextOverlay_1.17.29001.0_x64__8wekyb3d8bbwe |
| Microsoft.XboxGamingOverlay                  | Microsoft.XboxGamingOverlay_2.34.28001.0_x64__8wekyb3d8bbwe  |
| Microsoft.XboxGameOverlay                    | Microsoft.XboxGameOverlay_1.46.11001.0_x64__8wekyb3d8bbwe    |
| Microsoft.WindowsSoundRecorder               | Microsoft.WindowsSoundRecorder_10.1906.1972.0_x64__8wekyb3d8bbwe |
| Microsoft.WindowsMaps                        | Microsoft.WindowsMaps_5.1906.1972.0_x64__8wekyb3d8bbwe       |
| Microsoft.WindowsFeedbackHub                 | Microsoft.WindowsFeedbackHub_1.1907.3152.0_x64__8wekyb3d8bbwe |
| Microsoft.WindowsCalculator                  | Microsoft.WindowsCalculator_10.1906.55.0_x64__8wekyb3d8bbwe  |
| Microsoft.WebpImageExtension                 | Microsoft.WebpImageExtension_1.0.22753.0_x64__8wekyb3d8bbwe  |
| Microsoft.WebMediaExtensions                 | Microsoft.WebMediaExtensions_1.0.20875.0_x64__8wekyb3d8bbwe  |
| Microsoft.Wallet                             | Microsoft.Wallet_2.4.18324.0_x64__8wekyb3d8bbwe              |
| Microsoft.VP9VideoExtensions                 | Microsoft.VP9VideoExtensions_1.0.22681.0_x64__8wekyb3d8bbwe  |
| Microsoft.StorePurchaseApp                   | Microsoft.StorePurchaseApp_11811.1001.18.0_x64__8wekyb3d8bbwe |
| Microsoft.ScreenSketch                       | Microsoft.ScreenSketch_10.1907.2471.0_x64__8wekyb3d8bbwe     |
| Microsoft.People                             | Microsoft.People_10.1902.633.0_x64__8wekyb3d8bbwe            |
| Microsoft.MSPaint                            | Microsoft.MSPaint_6.1907.29027.0_x64__8wekyb3d8bbwe          |
| Microsoft.MixedReality.Portal                | Microsoft.MixedReality.Portal_2000.19081.1301.0_x64__8wekyb3d8bbwe |
| Microsoft.HEIFImageExtension                 | Microsoft.HEIFImageExtension_1.0.22742.0_x64__8wekyb3d8bbwe  |
| Microsoft.Getstarted                         | Microsoft.Getstarted_8.2.22942.0_x64__8wekyb3d8bbwe          |
| Microsoft.GetHelp                            | Microsoft.GetHelp_10.1706.13331.0_x64__8wekyb3d8bbwe         |
