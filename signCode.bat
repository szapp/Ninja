::
:: Perform code signing on Windows binaries.
::
:: Arguments: BINARY [BINARY ...]
::
@ECHO OFF
SETLOCAL

where signtool> nul 2>&1
IF %ERRORLEVEL%==0 GOTO sign
ECHO WARNING: Signtool not found. Skipping code signing.
EXIT /B 0

:sign
signtool sign /sha1 "09A16CBB7BCC28B5D9F27015FA7BCB6AF71C57B9" /tr http://time.certum.pl /td sha256 /fd sha1       /v "%*" && ^
signtool sign /sha1 "09A16CBB7BCC28B5D9F27015FA7BCB6AF71C57B9" /tr http://time.certum.pl /td sha256 /fd sha256 /as /v "%*" || REM Ignore exit code

EXIT /B 0
