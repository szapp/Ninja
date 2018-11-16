::
:: Write formatted patch file from all binary files
::
:: Arguments: OUTFILE GOTHIC_BASE_VERSION(1 or 2) SOURCEDIR [INFILE]
::
@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION ENABLEEXTENSIONS

:: Path to sub scripts
SET getAddress=%~pd0getAddress
SET getOrigHex=%~pd0getOrigHex
SET getVersion=%~pd0getVersion

:: Sanity check
IF [%1] == [] GOTO usage
IF [%2] == [] GOTO usage
IF [%3] == [] GOTO usage
IF %2 LSS 1   GOTO usage
IF %2 GTR 2   GOTO usage
SET gothic=%2

:: Verify indir
SET indir=%3
IF "%indir:~-1%"=="*" SET indir=%indir:~0,-1%
IF "%indir:~-1%"=="\" SET indir=%indir:~0,-1%
SET "indir=%indir%\*"
SET attr=%~a3
SET attr=%attr:~0,1%
IF /I NOT "%attr%"=="d" ECHO %3 is not a directory.&& EXIT /B 1

:: Verify outfile
SET outfile=%1
SET outextn=%~x1
SET outpath=%~dp1
IF /I NOT "%outextn%"==".patch" ECHO %1: Incorrect file extension. *.patch expected.&&  EXIT /B 2
IF NOT EXIST %outpath% MKDIR %outpath%

:: Verify infile if present
IF NOT [%4] == [] (
    IF /I NOT "%~x4"==".patch" ECHO %4: Incorrect file extension. *.patch expected.&&  EXIT /B 3
    IF NOT EXIST "%4" ECHO %4: File not found.&& EXIT /B 4
    COPY /Y %4 %outfile% >NUL
    ECHO.>> %outfile%
    ECHO.>> %outfile%
    ECHO.>> %outfile%
    ECHO.>> %outfile%
    ECHO.>> %outfile%
) ELSE (
    COPY /Y NUL %outfile% >NUL
)

:: Get date, locale independent, inspired by https://ss64.com/nt/syntax-getdate.html
WMIC.EXE Alias /? >NUL 2>&1 || ECHO Could not locate WMIC.EXE.&& EXIT /B 5
FOR /F "skip=1 tokens=1-6" %%G IN (
        'WMIC Path Win32_LocalTime Get Day^,Hour^,Minute^,Month^,Second^,Year /Format:table') DO (
    IF "%%~L"=="" GOTO s_done
    SET _yyyy=%%L
    SET _mm=%%J
)
:s_done
SET yearmonth=%_yyyy%-%_mm%

:: Get version
SET ERRORLEVEL=0
FOR /F "tokens=*" %%a IN ('%getVersion%') DO (
    IF %ERRORLEVEL% NEQ 0 ECHO %getVersion% failed: Error code #%ERRORLEVEL%&& EXIT /B 6
    SET version=%%a
)
IF NOT DEFINED version ECHO %getVersion% failed to execute.&& EXIT /B 7

:: Write outfile header
ECHO ////////////////////////////////>>                        %outfile%
IF %gothic% EQU 1 ECHO // NINJA %version% (GothicMOD.exe) //>> %outfile%
IF %gothic% EQU 2 ECHO //  NINJA %version% (Gothic2.exe)  //>> %outfile%
ECHO // mud-freak (@szapp) %yearmonth% //>>                    %outfile%
ECHO // http://tiny.cc/GothicNinja //>>                        %outfile%
ECHO ////////////////////////////////>>                        %outfile%

:: Process files
FOR %%N IN ("%indir%") DO CALL :fileloop %%N || EXIT /B 8

EXIT /B 0


:fileloop filefull

:: Parse file name
SET filefull=%1
SET filename=%~nx1
SET fileextn=%~x1
SET filebase=%~n1
SET fileobin=%~pd0bin\%filebase%_g%gothic%

:: Assertions on file name
IF /I not "%fileextn%"==".asm" EXIT /B
IF NOT EXIST %filefull% EXIT /B
IF NOT EXIST %fileobin% ECHO Warning: File '%fileobin%' not found.&& EXIT /B

:: Retrieve address
SET ERRORLEVEL=0
FOR /F "tokens=*" %%a IN ('%getAddress% %filefull% %gothic%') DO (
    IF %ERRORLEVEL% NEQ 0 ECHO %filename%: %getAddress% failed: Error code #%ERRORLEVEL%&& EXIT /B 9
    SET address=%%a
)
IF NOT DEFINED address ECHO %filename%: %getAddress% failed to execute.&& EXIT /B 10

:: Format binary to hex literals
certutil -encodehex -f %fileobin% tmp.text 12
FOR /F "delims=" %%x IN (tmp.text) DO SET hexstr=%%x
DEL /Q tmp.text

:: Add spaces, inspired by https://stackoverflow.com/questions/27297848/#27305899
SET "out="
SET i=1
FOR /F delims^=^ eol^= %%A IN ('cmd /U /V:on /C ECHO(^^!hexstr^^!^|more') DO (
    SET /A i=i+1
    IF !i!==2 (
        SET i=0 && SET "out=!out! ^%%A"
    ) ELSE (
        SET "out=!out!^%%A"
    )
)
SET "hexstr=!out:~1!"

:: Turn hex string upper case
SET hexstr=%hexstr:a=A%
SET hexstr=%hexstr:b=B%
SET hexstr=%hexstr:c=C%
SET hexstr=%hexstr:d=D%
SET hexstr=%hexstr:e=E%
SET hexstr=%hexstr:f=F%

:: Retrieve original hex string, if present
SET ERRORLEVEL=0
SET orghex=
FOR /F "tokens=*" %%a IN ('%getOrigHex% %filefull% %gothic%') DO (
    IF %ERRORLEVEL% NEQ 0 ECHO %filename%: %getOrigHex% failed: Error code #%ERRORLEVEL%&& EXIT /B 11
    SET orghex=%%a
)

:: Write to output file
ECHO.>>                                       %outfile%
ECHO [ninja_%version%_%filebase%]>>           %outfile%
ECHO Addr = "%address%">>                     %outfile%
ECHO Type = "hex">>                           %outfile%
IF NOT "%orghex%"=="" ECHO Org = "%orghex%">> %outfile%
ECHO New = "%hexstr%">>                       %outfile%

EXIT /B 0

:usage
ECHO Usage: %~nx0 OUTFILE GOTHIC_BASE_VERSION(1 or 2) SOURCEDIR [INFILE]
