::
:: Verify file size
::
:: Arguments: BINFILE GOTHIC-BASE-VERSION(1 or 2)
::
@ECHO OFF

:: Sanity check
IF [%1] == [] GOTO usage
IF [%2] == [] GOTO usage
IF %2 LSS 1   GOTO usage
IF %2 GTR 2   GOTO usage
SET gothic=%2

:: Parse file name
SET filefull=%~f1
SET filename=%~nx1

:: Assertions on file name
IF NOT EXIST %filefull% ECHO File '%filefull%' not found.&& EXIT /B 1

:: Set size limits in bytes corresponding to the available address range
IF %gothic% == 1 SET SIZELIMIT=10160
IF %gothic% == 2 SET SIZELIMIT=10736

:: Check file size against limit
SET FILESIZE=%~z1
IF %FILESIZE% GTR %SIZELIMIT% ECHO %filename% exceeds %SIZELIMIT% bytes (%FILESIZE%).&& DEL /Q %filefull% && EXIT /B 2

EXIT /B

:usage
ECHO Usage: %~nx0 BINFILE GOTHIC-BASE-VERSION(1 or 2)
