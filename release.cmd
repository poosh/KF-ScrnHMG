@echo off

rem DON'T FORGET to Duplicate HumanPawn and PlayerController class code to the SZ_ScrnBalance!

setlocal
set KFDIR=d:\Games\kf
set STEAMDIR=c:\Steam\steamapps\common\KillingFloor
set outputdir=D:\KFOut\ScrnHMG

echo Removing previous release files...
del /S /Q %outputdir%\*


echo Compiling project...
call make.cmd
if %ERRORLEVEL% NEQ 0 goto end

echo Exporting .int file...
%KFDIR%\system\ucc dumpint ScrnHMG.u

echo.
echo Copying release files...
mkdir %outputdir%\Animations
mkdir %outputdir%\Sounds
mkdir %outputdir%\System
mkdir %outputdir%\Textures
mkdir %outputdir%\uz2


copy /y %KFDIR%\system\ScrnHMG.* %outputdir%\System\
copy /y %STEAMDIR%\Animations\HMG_A.ukx %outputdir%\Animations\
copy /y %STEAMDIR%\Sounds\HMG_S.uax %outputdir%\Sounds\
copy /y %STEAMDIR%\Textures\HMG_T.utx %outputdir%\Textures\
copy /y %STEAMDIR%\Textures\BDFonts.utx %outputdir%\Textures\
copy /y readme.txt  %outputdir%
copy /y changes.txt  %outputdir%


echo Compressing to .uz2...
%KFDIR%\system\ucc compress %KFDIR%\system\ScrnHMG.u
%KFDIR%\system\ucc compress %STEAMDIR%\Animations\HMG_A.ukx
%KFDIR%\system\ucc compress %STEAMDIR%\Sounds\HMG_S.uax
%KFDIR%\system\ucc compress %STEAMDIR%\Textures\HMG_T.utx
%KFDIR%\system\ucc compress %STEAMDIR%\Textures\BDFonts.utx

move /y %KFDIR%\system\ScrnHMG.u.uz2 %outputdir%\uz2
move /y %STEAMDIR%\Animations\HMG_A.ukx.uz2 %outputdir%\uz2
move /y %STEAMDIR%\Sounds\HMG_S.uax.uz2 %outputdir%\uz2
move /y %STEAMDIR%\Textures\HMG_T.utx.uz2 %outputdir%\uz2
move /y %STEAMDIR%\Textures\BDFonts.utx.uz2 %outputdir%\uz2

echo Release is ready!

endlocal

pause

:end
