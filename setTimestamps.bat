::
:: Reset timestamps of files for setup
:: To be effetive, requires the environment variable BUILD_TIME to be set
::
:: Arguments: FILE [FILE ...]
::
@ECHO OFF
SETLOCAL

:: Sanity check
IF [%1] == [] GOTO usage

:: Format time stamp
IF NOT DEFINED BUILD_TIME ECHO Environment variable BUILD_TIME not set. Files unaltered.&& EXIT /B 0

:: Iterate over all input files
FOR %%F IN (%*) DO CALL :processfile %%F
EXIT /B 0

:: Outsourced into a function to be more verbose
:processfile filefull
SET filefull=%~f1
SET filename=%~nx1
touch -d "%BUILD_TIME% +0000" "%filefull%"
ECHO Set file time of %filename% to %BUILD_TIME% UTC
EXIT /B

:usage
ECHO Usage: %~nx0 FILE [FILE ...]
