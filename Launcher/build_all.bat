@echo off
setlocal
cd /d "%~dp0"
cd ..\Editor
py -3.11 -m PyInstaller --noconfirm --clean --windowed --name editor --icon "..\storyweaver.ico" --add-data "DejaVuSans.ttf;." --add-data "..\storyweaver.ico;." --hidden-import docx --hidden-import _socket editor.py
if errorlevel 1 exit /b 1
cd ..\Launcher
if exist editor rmdir /s /q editor
xcopy /e /i /y ..\Editor\dist\editor editor
rem embed icon and ship ico for runtime (taskbar/window)
PyInstaller ^ --noconfirm --clean ^ --name "StoryWeaverLauncher" ^ --windowed ^ --onedir ^ --icon "..\storyweaver.ico" ^ --add-data "editor;editor" ^ --add-data "..\storyweaver.ico;." ^ --collect-submodules PySide6 ^ --collect-data certifi ^ --hidden-import _socket launcher.py
endlocal
