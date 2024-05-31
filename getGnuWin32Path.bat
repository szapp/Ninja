::
:: Find and add GnuWin32 from Git for windows to path
::
:: Arguments: none
::
@ECHO OFF
SETLOCAL

SET add_paths=

:: Check for git
where git> nul 2>&1
IF NOT %ERRORLEVEL%==0 GOTO :nasm
FOR /F "usebackq tokens=*" %%i IN (`where git`) DO SET "git_path=%%i"
:: Strip the /cmd/git.exe part and append /usr/bin/ instead
SET "git_install_dir=%git_path:\cmd\git.exe=%"
SET "gnu_path=%git_install_dir%\usr\bin"
IF EXIST "%gnu_path%\*" SET "add_paths=%gnu_path%;"&& GOTO :nasm
:: Strip the /mingw64/bin/git.exe part and append /usr/bin/ instead
SET "git_install_dir=%git_path:\mingw64\bin\git.exe=%"
SET "gnu_path=%git_install_dir%\usr\bin"
IF EXIST "%gnu_path%\*" SET "add_paths=%gnu_path%;"

:: Also check for NASM
:nasm
where nasm> nul 2>&1
IF %ERRORLEVEL%==0 GOTO :nsis
SET "nasm_path=C:\Program Files\NASM"
IF EXIST "%nasm_path%\*" SET "add_paths=%add_paths%%nasm_path%;"

:: Also check for NSIS
:nsis
where makensis> nul 2>&1
IF %ERRORLEVEL%==0 GOTO :output
SET "nsis_path=C:\Program Files (x86)\NSIS"
IF EXIST "%nsis_path%\*" SET "add_paths=%add_paths%%nsis_path%;"

:output
IF "%add_paths%" NEQ "" ECHO %add_paths%
