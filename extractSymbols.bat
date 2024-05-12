::
:: Extract all global symbols from assembly files and format them into a macro file
::
:: Arguments: OUTFILE.ASM GOTHIC-BASE-VERSION(1, 112, 130, or 2) SOURCE.ASM [SOURCE.ASM ...]
::
@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION

:: Path to getAddress.bat
SET getAddress=%~pd0getAddress

:: Sanity check
IF [%1] == [] GOTO usage
IF [%2] == [] GOTO usage
IF [%3] == [] GOTO usage
IF %2 EQU 1   GOTO start
IF %2 EQU 112 GOTO start
IF %2 EQU 130 GOTO start
IF %2 NEQ 2   GOTO usage

:start
SET gothic=%2

:: Write file header
SET outfile=%~f1
ECHO ; This file was auto generated. Do not modify!> %outfile%

:: Iterate over source files
SET count=0
FOR %%N IN (%*) DO SET /A count+=1 && IF !count! GTR 2 CALL :processfile %%N || EXIT /B 1

EXIT /B 0


:processfile filefull

:: Parse file name
SET filefull=%~f1
SET filepath=%~dp1
SET filename=%~nx1
SET fileextn=%~x1
SET filebase=%~n1

:: Assertions on file name
IF NOT "%fileextn%"==".asm" ECHO %filename%: Incorrect file extension. *.asm expected.&& EXIT /B 2
IF NOT EXIST %filefull% ECHO File '%filefull%' not found.&& EXIT /B 3

nasm -DGOTHIC_BASE_VERSION=%gothic% -I%filepath% -f elf32 -o temp.o %filefull% || EXIT /B 4

:: Retrieve address
SET address=
SET ERRORLEVEL=0
FOR /F "tokens=*" %%a IN ('%getAddress% %filefull% %gothic%') DO (
    IF %ERRORLEVEL% NEQ 0 ECHO %filename%: %getAddress% failed: Error code #%ERRORLEVEL%&& EXIT /B 5
    SET address=%%a
)
IF NOT DEFINED address ECHO %filename%: %getAddress% failed to execute.&& EXIT /B 6

:: Retrieve all external symbols from functions elf
objdump -t temp.o --adjust-vma=%address% -j .text | find " g  "> symbols.text

:: Reformat names and addresses into NASM macro syntax
FOR /F "tokens=1,4 delims= " %%a IN (symbols.text) DO ECHO ^%%define %%b 0x%%a>> %outfile%

:: Clean up temporary files
DEL /Q symbols.text
DEL /Q temp.O

EXIT /B

:usage
ECHO Usage: %~nx0 OUTFILE.ASM GOTHIC-BASE-VERSION(1, 112, 130, or 2) SOURCE.ASM [SOURCE.ASM ...]
