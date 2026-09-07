@echo off
setlocal enabledelayedexpansion

set target_folder=%1
echo %target_folder%
 
REM 检查文件夹是否存在
if not exist "%target_folder%" (
    echo 文件夹不存在: %target_folder%
    exit /b 1
)
 
REM 遍历文件夹及其子文件夹，删除所有文件
for /r "%target_folder%" %%i in (*) do (
    REM 检查是否有扩展名（即是否为文件），因为文件夹没有扩展名
    if "%%~xi" neq "" (
        del /F /S /Q "%%i"
    )
)
 
echo 所有文件已删除，文件夹结构保留.
endlocal
pause