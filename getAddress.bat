::
:: Read starting address (ORG) from assembly file
::
:: Arguments: SOURCE.ASM GOTHIC-BASE-VERSION(1, 112, 130, or 2)
::
@ECHO OFF
SETLOCAL ENABLEEXTENSIONS ENABLEDELAYEDEXPANSION

:: Sanity check
IF [%1] == [] GOTO usage
IF [%2] == [] GOTO usage
IF %2 EQU 1   SET gId=1&& GOTO start
IF %2 EQU 112 SET gId=2&& GOTO start
IF %2 EQU 130 SET gId=3&& GOTO start
IF %2 EQU 2   SET gId=4&& GOTO start
GOTO usage

:start

:: Parse file name
SET filefull=%~f1
SET filename=%~nx1
SET fileextn=%~x1
SET filebase=%~n1

:: Assertions on file name
IF /I NOT "%fileextn%"==".asm" ECHO Incorrect file extension. *.asm expected.&& EXIT /B 1
IF NOT EXIST %filefull% ECHO File '%filefull%' not found.&& EXIT /B 2

:: Grep addresses from org decorator
set LC_ALL="en_US.utf8"
type %filefull% ^
    | grep -iP "[[:blank:]]*org[[:blank:]]+(\w+\()?[[:blank:]]*((0x)?[[:xdigit:]]{6,8})" ^
    | grep -ioP "(?:0x)?[[:xdigit:]]{6,8}" ^
    > tmp.text

SET i=0
FOR /F "tokens=*" %%A IN (tmp.text) DO (
    SET /A i=i+1
    SET addr=%%A
    IF !i!==%gId% GOTO break
)
:: Only one address found
IF %i% LSS %gId% GOTO break

:: None found
DEL /Q tmp.text
ECHO Requested address not found&& EXIT /B 3

:break
DEL /Q tmp.text
ECHO %addr%
EXIT /B 0

:usage
ECHO Usage: %~nx0 SOURCE.ASM GOTHIC-BASE-VERSION(1, 112, 130, or 2)
