::
:: Write formatted list of all binary files
::
:: Arguments: OUTFILE SOURCEDIR
::
@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION ENABLEEXTENSIONS

:: Path to sub scripts
SET getAddress=%~pd0getAddress

:: Sanity check
IF [%1] == [] GOTO usage
IF [%2] == [] GOTO usage

:: Verify indir
SET indir=%2
IF "%indir:~-1%"=="*" SET indir=%indir:~0,-1%
IF "%indir:~-1%"=="\" SET indir=%indir:~0,-1%
SET "indir=%indir%\*"
SET attr=%~a2
SET attr=%attr:~0,1%
IF /I NOT "%attr%"=="d" ECHO %2 is not a directory.&& EXIT /B 1

:: Verify outfile
SET outfile=%1
SET outextn=%~x1
SET outpath=%~dp1
IF /I NOT "%outextn%"==".inc" ECHO %1: Incorrect file extension. *.inc expected.&& EXIT /B 2
IF NOT EXIST "%outpath%" MKDIR "%outpath%"
COPY /Y NUL "%outfile%" >NUL

:: Process files
SET gothic=1
FOR %%N IN ("%indir%") DO CALL :fileloop %%N || EXIT /B 3
ECHO/>> %outfile%
SET gothic=2
FOR %%N IN ("%indir%") DO CALL :fileloop %%N || EXIT /B 3

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
    IF %ERRORLEVEL% NEQ 0 ECHO %filename%: %getAddress% failed: Error code #%ERRORLEVEL%&& EXIT /B 4
    SET address=%%a
)
IF NOT DEFINED address ECHO %filename%: %getAddress% failed to execute.&& EXIT /B 5

:: Write to output file
ECHO add_inject_g%gothic% %address%,"../bin/%filebase%_g%gothic%">> "%outfile%"

EXIT /B 0

:usage
ECHO Usage: %~nx0 OUTFILE SOURCEDIR
