@echo off
setlocal

:: 获取右键传递的第一个参数（即目标exe文件路径）
set "TargetFile=%~1"

:: 检查是否传入了参数
if "%TargetFile%"=="" (
    echo 未检测到目标文件，请通过右键“发送到”菜单使用此脚本。
    pause
    exit /b
)

:: 检查文件是否存在
if not exist "%TargetFile%" (
    echo 错误：文件不存在 - %TargetFile%
    pause
    exit /b
)

:: 定义临时VBS文件路径
set "TempVBS=%temp%\CreateLnk.vbs"

:: 动态生成VBScript代码
:: 使用 PowerShell 获取开始菜单路径比纯BAT更稳定，但为了纯BAT兼容性，这里使用环境变量
:: %APPDATA%\Microsoft\Windows\Start Menu\Programs 是标准用户开始菜单程序目录
set "StartMenuPath=C:\ProgramData\Microsoft\Windows\Start Menu\Programs"

:: 提取文件名（不含扩展名）用于快捷方式命名
for %%F in ("%TargetFile%") do set "LinkName=%%~nF.lnk"

:: 写入VBS内容到临时文件
(
    echo Dim objShell, objFSO, objLink, strTarget, strLinkPath
    echo Set objShell = CreateObject("WScript.Shell"^)
    echo Set objFSO = CreateObject("Scripting.FileSystemObject"^)
    echo.
    echo strTarget = WScript.Arguments(0^)
    echo strLinkPath = WScript.Arguments(1^)
    echo.
    echo ' 创建快捷方式对象
    echo Set objLink = objShell.CreateShortcut(strLinkPath^)
    echo.
    echo ' 设置目标路径
    echo objLink.TargetPath = strTarget
    echo.
    echo ' 设置起始位置（工作目录）
    echo objLink.WorkingDirectory = objFSO.GetParentFolderName(strTarget^)
    echo.
    echo ' 保存快捷方式
    echo objLink.Save
    echo.
    echo Set objLink = Nothing
    echo Set objFSO = Nothing
    echo Set objShell = Nothing
) > "%TempVBS%"

:: 执行VBS脚本，传入目标文件路径和快捷方式完整路径
cscript //nologo "%TempVBS%" "%TargetFile%" "%StartMenuPath%\%LinkName%"

:: 清理临时文件
del "%TempVBS%"

:: 提示完成
echo 成功创建快捷方式到开始菜单！
timeout /t 2 >nul
exit /b
