::
:: Read original hex bytes from assembly file
::
:: Arguments: SOURCE.ASM GOTHIC-BASE-VERSION(1 or 2)
::
@ECHO OFF
SETLOCAL ENABLEEXTENSIONS ENABLEDELAYEDEXPANSION

:: Sanity check
IF [%1] == [] GOTO usage
IF [%2] == [] GOTO usage
IF %2 LSS 1   GOTO usage
IF %2 GTR 2   GOTO usage

:: Parse file name
SET filefull=%~f1
SET filename=%~nx1
SET fileextn=%~x1
SET filebase=%~n1

:: Assertions on file name
IF /I NOT "%fileextn%"==".asm" ECHO Incorrect file extension. *.asm expected.&& EXIT /B 1
IF NOT EXIST %filefull% ECHO File '%filefull%' not found.&& EXIT /B 2

:: Grep hex string from comment
type %filefull% ^
    | grep -ioP "[[:blank:]]*;[[:blank:]]*orig[[:blank:]]+g%2:[[:blank:]]*(?:[[:xdigit:]]{2}[[:blank:]]*)+" ^
    | grep -ioP "(?:[[:xdigit:]]{2}[[:blank:]]*)+"

EXIT /B 0

:usage
ECHO Usage: %~nx0 SOURCE.ASM GOTHIC-BASE-VERSION(1 or 2)
