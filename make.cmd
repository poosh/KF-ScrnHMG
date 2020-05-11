@echo off

setlocal
color 07

set KFDIR=C:\Games\kf
set STEAMDIR=c:\Steam\steamapps\common\KillingFloor
rem remember current directory
set CURDIR=%~dp0

cd /D %KFDIR%\System
del ScrnHMG.u

rem ucc make > %CURDIR%\make.log
REM ucc make > %CURDIR%\make.log
ucc make
set ERR=%ERRORLEVEL%
if %ERR% NEQ 0 goto error
color 0A


del KillingFloor.log
del steam_appid.txt
copy ScrnHMG.* %STEAMDIR%\System\

echo --------------------------------
echo Compile successful.
echo --------------------------------
goto end

:error
color 0C
REM type %CURDIR%\make.log
echo ################################
echo Compile ERROR! Code = %ERR%.
echo ################################
pause

:end
REM pause

rem return to the previous directory
cd /D %CURDIR%

endlocal & SET EC=%ERR%
exit /b %EC%
