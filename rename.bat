@echo off
setlocal enabledelayedexpansion
 
REM 设置目标文件夹路径
set target_folder=%1
 
REM 切换到目标文件夹
cd /d "%target_folder%"

echo %target_folder%
 
REM 遍历目标文件夹中的所有文件
for %%f in (*.mp4) do (
    REM 获取文件名（不带扩展名）
    set "filename=%%~nf"
    
    REM 查找 @ 符号并提取后面的部分
    for /f "tokens=2 delims=@" %%a in ("!filename!") do (
        set "part_after_at=%%a"
        
        REM 查找 . 并提取前面的部分（如果 .H265 存在，则去掉它）
        for /f "tokens=1* delims=." %%x in ("!part_after_at!") do (
            set "new_name_part=%%x"
            set "rest_of_part=%%y"
            
            REM 检查 new_name_part 是否以 - 开头，如果不是，则使用整个 part_after_at（但我们已经去掉了 .H265）
            for /f "tokens=1* delims=-" %%m in ("!new_name_part!") do (
                if not defined %%m (
                    set "new_name=!part_after_at!"
                ) else (
                    set "new_name=%%n"
                )
            )
            
            REM 如果 rest_of_part 不为空且不以 H265 开头（虽然我们已经处理过了，但这里是为了保险起见），则忽略它
            REM 实际上，由于我们的逻辑，rest_of_part 在这里不会被使用到，因为我们已经有了 new_name
            
            REM 构造新的完整文件名（加上 .mp4 扩展名）
            set "new_full_name=!new_name!.mp4"
            
            REM 重命名文件
            ren "%%f" "!new_full_name!"
        )
    )
)
 
echo 完成！但请注意，上面的脚本可能不是100%准确，因为它没有处理所有可能的边缘情况。
echo 对于更复杂的文件名处理，建议使用更强大的脚本语言，如PowerShell。
pause