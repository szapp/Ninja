::
:: Read global version information from the macro file
::
:: Arguments: None
::
@ECHO OFF

:: Macro file
SET filefull=%~pd0src\inc\macros.mac

:: Assertions on file name
IF NOT EXIST %filefull% ECHO File '%filefull%' not found.&& EXIT /B 1

:: Grep hex string from comment
type %filefull% ^
    | grep -ioP "[[:blank:]]*.define[[:blank:]]+NINJA_VERSION[[:blank:]]+'v[\w\.-]+'" ^
    | grep -ioP "(?<=')v[\w\.-]+(?=')"
