::
:: Patch build files to remove non-deterministic properties for reproducible builds
:: This batch file complements ducible which does not fix .rscr section timestamps of sub tables
:: and the import table ordinals and DLL name capitalization that differ between machine versions
::
:: Arguments: DLLFILE
::
@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION
SET LC_ALL=en_US.utf8

:: Sanity check
IF [%1] == [] GOTO usage
SET "file=%~1"
SET filebase=%~n1

:: Use objdump to get a summary of the file to later compare patched bytes
objdump -x %file% > %file%.txt

:: First: Zero out the hints and ordinal values in the import table

:: Find image base
TYPE %file%.txt ^
    | grep -oiP "^ImageBase[[:blank:]]+[[:xdigit:]]+[[:space:]]?$" ^
    > base.txt
FOR /F "tokens=2" %%a IN (base.txt) DO (
    SET /A "image_base=0x%%a"
)
DEL /Q base.txt

ECHO ImageBase: %image_base%

:: Find VMA and file offset of .idata section
objdump -h -j .idata %file% | findstr "\.idata" > header.txt 2>nul
FOR /F "tokens=3,4,6" %%a IN (header.txt) DO (
    SET /A "idata_size=0x%%a"
    SET /A "idata_vma=0x%%b"
    SET /A "idata_offset=0x%%c"
)
DEL /Q header.txt

:: Subtract image base from VMA for relative addresses
SET /A "idata_vma=idata_vma-image_base"

ECHO Import table: %idata_vma% at offset %idata_offset%

:: Find the addresses of IAT entries
TYPE %file%.txt ^
    | grep -zoiP "(?<=The Import Tables)(.|\r|\n)*(?=(?:0{8}\s){5})" ^
    | grep -aoiP "^[[:blank:]]+[[:xdigit:]]+[[:blank:]]+\d+[[:blank:]]+[\w\d@_]+[[:space:]]?$" ^
    > iat.txt
FOR /F "tokens=1" %%A IN (iat.txt) DO (
    :: Calculate the file offset from VMA
    SET "hex=%%A"
    SET /A "hex_dec=0x!hex!"
    SET /A "addr=!hex_dec!-!idata_vma!+!idata_offset!"
    :: Zero out ordinal number at address (WORD)
    ECHO -n 0000 | xxd -r -p | dd of=%file% bs=1 seek=!addr! count=2 conv=notrunc > nul 2>&1
)
DEL /Q iat.txt

:: Next: Change DLL names upper case for consistency

:: First extract the list of DLL names
TYPE %file%.txt ^
    | grep -zoiP "(?<=The Import Tables)(.|\r|\n)*(?=(?:0{8}\s){5})" ^
    | grep -aoiP "^[[:blank:]]+Dll Name:[[:blank:]]\K.*[[:space:]]?$" ^
    > dllnames.txt
SET "dllnames="
FOR /F "delims=" %%A IN (dllnames.txt) DO SET "dllnames=!dllnames! %%A"
DEL /Q dllnames.txt

:: Then extract the import tables
TYPE %file%.txt ^
    | grep -zoiP "(?<=The Import Tables)(.|\r|\n)*(?=(?:0{8}\s){5})" ^
    | grep -aoiP "^[[:blank:]]+([[:xdigit:]]{8}[[:blank:]]+){5}[[:xdigit:]]{8}[[:space:]]?$" ^
    > dlltables.txt

SET /A dll_count=0
FOR /F "tokens=5" %%A IN (dlltables.txt) DO (
    SET /A dll_count=dll_count+1
    :: Calculate the file offset from VMA
    SET "hex=%%A"
    SET /A "hex_dec=0x!hex!"
    SET /A "addr=!hex_dec!-!idata_vma!+!idata_offset!"
    :: Find the length of the DLL name
    SET /A name_idx=0
    FOR %%N IN (%dllnames%) DO (
        SET /A name_idx=name_idx+1
        IF !name_idx! EQU !dll_count! SET "name=%%N"
    )
    CALL :strlen name len
    :: Convert name to uppercase
    dd if=%file% of=%file% bs=1 seek=!addr! skip=!addr! count=!len! conv=ucase,notrunc > nul 2>&1
)
DEL /Q dlltables.txt

:: Next: Remove time stamps from resource table

:: Find size and offset of .rsrc section
objdump -h -j .rsrc %file% | findstr "\.rsrc" > header.txt
FOR /F "tokens=3,6" %%a IN (header.txt) DO (
    SET /A "rsrc_size=0x%%a"
    SET /A "rsrc_offset=0x%%b"
)
DEL /Q header.txt

:: Better safe than sorry: Assert the section size
IF "%rsrc_size%" == "" GOTO :CLEANUP
IF "%rsrc_size%" NEQ "768" ECHO Warning: Resource directory sections is of unexpected size: %rsrc_size%. Cannot make build reproducible.&& GOTO :CLEANUP

:: CAUTION the following is hard-coded to match the offsets of the resource (see Makefile)

:: Type Table Time
SET /A "timestamp_offset=rsrc_offset + 4"
ECHO -n 003b3d4b | xxd -r -p | dd of=%file% bs=1 seek=%timestamp_offset% count=4 conv=notrunc > nul 2>&1

:: Name Table Time
SET /A "timestamp_offset=rsrc_offset + 28"
ECHO -n 003b3d4b | xxd -r -p | dd of=%file% bs=1 seek=%timestamp_offset% count=4 conv=notrunc > nul 2>&1

:: Language Table Time
SET /A "timestamp_offset=rsrc_offset + 52"
ECHO -n 003b3d4b | xxd -r -p | dd of=%file% bs=1 seek=%timestamp_offset% count=4 conv=notrunc > nul 2>&1

:CLEANUP

:: Show the differences
objdump -x %file% > %file%_patched.txt
FC %file%.txt %file%_patched.txt

:: Cleanup
DEL /Q %file%.txt
DEL /Q %file%_patched.txt

EXIT /B 0

:usage
ECHO Usage: %~nx0 DLLFILE
EXIT /B 0

:: Source: https://ss64.com/nt/syntax-strlen.html
:strlen  StrVar  [RtnVar]
  SETLOCAL ENABLEDELAYEDEXPANSION
  SET "s=#!%~1!"
  SET "len=0"
  FOR %%N IN (4096 2048 1024 512 256 128 64 32 16 8 4 2 1) DO (
    IF "!s:~%%N,1!" NEQ "" (
      SET /A "len+=%%N"
      SET "s=!s:~%%N!"
    )
  )
  ENDLOCAL&if "%~2" NEQ "" (SET %~2=%len%) ELSE ECHO %len%
EXIT /B
