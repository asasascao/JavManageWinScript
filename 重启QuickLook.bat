@echo off
taskkill /F /IM QuickLook.exe >nul 2>&1
timeout /t 2 /nobreak >nul
start "" "E:\ProgramFile\FileManage\FilePreview\QuickLook-4.5.0\QuickLook.exe"