@echo off
set path_source=%1
set path_target=%2
echo %path_source%%path_target%
echo "复制中"
robocopy %path_source% %path_target% *.* /S /MOV /V /LOG:"C:\Users\Administrator\Desktop\copy_log.log"
echo "复制完毕"
echo "处理完毕"