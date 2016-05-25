@echo off
echo.
echo.Operation Construction
echo.
echo.[1] Start Services     [2] Stop Services
echo.
set /p in=Make Your Choice[1/2]£º
if /i "%in%"=="1" goto 1
if /i "%in%"=="2" goto 2
:1
net start mysql
goto :3
:2
net stop mysql
goto :3
:3
echo.Press ankey to exit
echo. 
echo.waiting for processing...
pause >nul