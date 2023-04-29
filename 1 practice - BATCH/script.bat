@echo off
setlocal enabledelayedexpansion

if "%1"=="" (set "dir=%USERPROFILE%") else (set "dir=%1")
if "%2"=="" (set "ext=.bat") else (set "ext=%2")

set "logfile=%dir%\filelist.log"
set "filearray="

for /r "%dir%" %%f in (*%ext%) do (
  set "filename=%%~nxf"
  set "filepath=%%~dpnxvf"
  set "filearray=!filearray!!filename!!filepath!"
)

echo %date% > "%logfile%"
echo %time% >> "%logfile%"

for %%a in ("%filearray:=" "%") do (
    echo %%~a >> "%logfile%"
)

start /wait notepad.exe "%logfile%"
pause

del "%logfile%"
echo FINISH
endlocal
