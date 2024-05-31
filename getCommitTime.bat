::
:: Get build time from last git revision
:: To be effetive, requires git and this project to be cloned
::
:: Arguments: none
::
@ECHO OFF
SETLOCAL

:: Check for git
where git> nul 2>&1
IF NOT %ERRORLEVEL%==0 EXIT /B 0

:: Check if this is a git repository
git status> nul 2>&1
IF NOT %ERRORLEVEL%==0 EXIT /B 0

:: Get unix time stamp from git commit
FOR /F "usebackq" %%i IN (`git log -1 --format^=%%at`) DO SET "timestamp=%%i"
SET parameters=-u -d @"%timestamp%" +"%%Y-%%m-%%d %%H:%%M:%%S"

:: Attempt to find unix "date"
where date> nul 2>&1
IF NOT %ERRORLEVEL%==0 EXIT /B 0
FOR /F "usebackq tokens=*" %%i IN (`where date`) DO SET "date_path=%%i"
"%date_path%" %parameters% || EXIT /B 0
