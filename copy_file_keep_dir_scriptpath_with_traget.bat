@echo off
set path_source=%~dp0
set path_target=%1
echo %path_source%
echo %path_target%
echo "复制中"
robocopy %path_source% %path_target% *.* /S /MOV /V /xf copy_file_keep_dir_scriptpath_with_traget.bat /LOG:"C:\Users\Administrator\Desktop\copy_log.log"
echo "复制完毕"
echo "处理完毕"