@echo off
echo FROM:http://www.taodudu.cc/news/show-3033261.html
pushd %~dp0
if exist app.ini (del app.ini)
powershell.exe -command ^
  "& {Get-AppxPackage | Select PackageFullName >>.\app.ini}"
popd
setlocal enabledelayedexpansion
for /f "skip=3 delims= tokens=*" %%a in ('type ".\app.ini" ^|find "Microsoft."') do (
powershell.exe -command ^
  "& {Remove-AppxPackage %%a }"
)

echo 内置APP已经全部检索并卸载完毕，回车关闭窗口。
pause>nul