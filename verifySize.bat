::
:: Verify file size
::
:: Arguments: BINFILE GOTHIC-BASE-VERSION(1, 112, 130, or 2)
::
@ECHO OFF

:: Sanity check
IF [%1] == [] GOTO usage
IF [%2] == [] GOTO usage
IF %2 EQU 1   GOTO start
IF %2 EQU 112 GOTO start
IF %2 EQU 130 GOTO start
IF %2 NEQ 2   GOTO usage

:start
SET gothic=%2

:: Parse file name
SET filefull=%~f1
SET filename=%~nx1

:: Assertions on file name
IF NOT EXIST %filefull% ECHO File '%filefull%' not found.&& EXIT /B 1

:: Set size limits in bytes corresponding to the available address range
IF %gothic% == 1   SET SIZELIMIT=11280
IF %gothic% == 112 SET SIZELIMIT=12096
IF %gothic% == 130 SET SIZELIMIT=0
IF %gothic% == 2   SET SIZELIMIT=11904

:: Check file size against limit
SET FILESIZE=%~z1
IF %FILESIZE% GTR %SIZELIMIT% ECHO %filename% exceeds %SIZELIMIT% bytes (%FILESIZE%).&& DEL /Q %filefull% && EXIT /B 2

EXIT /B

:usage
ECHO Usage: %~nx0 BINFILE GOTHIC-BASE-VERSION(1, 112, 130, or 2)
