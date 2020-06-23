;===============================================================================
;
;                                Setup-Script
;                       Modified from g2mod.nsh template
;
;                    System:  NSIS 2.0  http://nsis.sf.net/
;                    Editor:  HMNE 2.0  http://hmne.sf.net/
;
;===============================================================================


; Definitions

!define VER_MAJOR $%VBASE%
!define VER_MINOR $%VMAJOR%
!define VER_PATCH $%VMINOR%
!define VER_FLAGS 0
!define VER_FILE  "${VER_MAJOR}.${VER_MINOR}.${VER_PATCH}"
!define VER_TEXT  "${VER_MAJOR}.${VER_MINOR}.${VER_PATCH}"

!define APP_FILE "Ninja"
!define APP_NAME "Ninja"
!define APP_COPY "Copyright © $%RYEARS% szapp"
!define APP_LINK "$%NINJA_WEBSITE%"
!define APP_HELP "$%NINJA_WEBSITE%"

!define SRC_BASEDIR "..\build"
!define OUTDIR "..\build"


!include "TextFunc.nsh"
!include "WordFunc.nsh"


;===============================================================================
;
;   MUI
;


!include "MUI.nsh"

!include "MUI2.nsh"


Name "${APP_NAME} ${VER_TEXT}"
OutFile "${OUTDIR}\${APP_FILE}-${VER_FILE}.exe"
InstallDir "$PROGRAMFILES\JoWooD\Gothic II\"
!define APP_RKEY "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\${APP_NAME}"
InstallDirRegKey HKLM "${APP_RKEY}" "InstallLocation"
AllowRootDirInstall true
ShowInstDetails show
ShowUnInstDetails show


; Configuration (install)

!define MUI_WELCOMEPAGE_TITLE_3LINES
!define MUI_WELCOMEPAGE_TEXT "This wizard will guide you through the installation of\r\n$(^Name).\r\n\r\nIt is recommended to close all running programs before starting the installation.\r\n\r\n$_CLICK"
!define MUI_COMPONENTSPAGE_NODESC
!define MUI_FINISHPAGE_NOREBOOTSUPPORT
!define MUI_FINISHPAGE_TITLE_3LINES
!define MUI_FINISHPAGE_NOAUTOCLOSE

; Setup pages (install)

!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_LICENSE "..\LICENSE"
Page custom PageReinstall PageLeaveReinstall
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH

; Configuration (uninstall)

!define MUI_WELCOMEPAGE_TITLE_3LINES
!define MUI_WELCOMEPAGE_TEXT "This wizard will guide you through the uninstallation of\r\n$(^Name).\r\n\r\nPlease close Gothic/Gothic II and any related tools, before continuing.\r\n\r\n$_CLICK"
!define MUI_FINISHPAGE_NOREBOOTSUPPORT
!define MUI_FINISHPAGE_TITLE_3LINES
!define MUI_UNFINISHPAGE_NOAUTOCLOSE

; Setup pages (uninstaller)

!insertmacro MUI_UNPAGE_WELCOME
!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_COMPONENTS
!insertmacro MUI_UNPAGE_INSTFILES
!insertmacro MUI_UNPAGE_FINISH

; Setup language

!insertmacro MUI_LANGUAGE "English"
!insertmacro MUI_LANGUAGE "German"

; Reserved files

ReserveFile "setup.ini"
!insertmacro MUI_RESERVEFILE_INSTALLOPTIONS

;===============================================================================
;
;   Setup (install)
;


; Setup.exe version info
VIProductVersion "${VER_MAJOR}.${VER_MINOR}.${VER_PATCH}.0"
VIAddVersionKey /LANG=1200 "ProductName"      "${APP_NAME}"
VIAddVersionKey /LANG=1200 "ProductVersion"   "${VER_TEXT}"
VIAddVersionKey /LANG=1200 "FileVersion"      "${VER_TEXT}"
VIAddVersionKey /LANG=1200 "LegalCopyright"   "${APP_COPY}"
VIAddVersionKey /LANG=1200 "FileDescription"  "${APP_NAME} Setup <${APP_LINK}>"
VIAddVersionKey /LANG=1200 "OriginalFilename" "${APP_FILE}-${VER_FILE}.exe"


LangString NameInstFull ${LANG_ENGLISH} "Complete"
LangString NameInstFull ${LANG_GERMAN} "Vollständig"
InstType $(NameInstFull)


;-------------------------------------------------------------------------------
;
;   Init (hidden)
;


; Setup

LangString TextInsuffRights ${LANG_ENGLISH} "Setting up the uninstalling option failed.$\r$\nMake sure you have sufficient permission (administrator).$\r$\n$\r$\n(HKLM\$R0)"
LangString TextInsuffRights ${LANG_GERMAN} "Beim Schreiben der Werte für die spätere Deinstallation trat ein Fehler auf.$\r$\nStellen Sie sicher, dass Ihr Benutzerkonto über die notwendigen Rechte verfügt.$\r$\n$\r$\n(HKLM\$R0)"

Section -pre
  Push $R0

  SetDetailsPrint none
  StrCpy $R0 "${APP_RKEY}"

  ; Setup-Parameter in die Registrierung schreiben
  ClearErrors
  WriteRegExpandStr HKLM $R0 "InstallLocation" $INSTDIR
  IfErrors "" write
  MessageBox MB_OK|MB_ICONSTOP $(TextInsuffRights)
  Pop $R0
  Abort
  write:
  WriteRegDWORD     HKLM $R0 "VersionMajor"    ${VER_MAJOR}
  WriteRegDWORD     HKLM $R0 "VersionMinor"    ${VER_MINOR}
  WriteRegDWORD     HKLM $R0 "VersionPatch"    ${VER_PATCH}
  WriteRegDWORD     HKLM $R0 "VersionFlags"    ${VER_FLAGS}
  WriteRegStr       HKLM $R0 "DisplayName"     "${APP_NAME}"
  WriteRegStr       HKLM $R0 "DisplayVersion"  "${VER_TEXT}"
  WriteRegDWORD     HKLM $R0 "NoModify"        1
  WriteRegDWORD     HKLM $R0 "NoRepair"        1
  WriteRegExpandStr HKLM $R0 "UninstallString" "$INSTDIR\${APP_FILE}-uninst.exe"
  WriteRegStr       HKLM $R0 "URLInfoAbout"    "${APP_LINK}"
  WriteRegStr       HKLM $R0 "HelpLink"        "${APP_HELP}"

  Pop $R0
SectionEnd


;-------------------------------------------------------------------------------
;
;   Application
;


; Setup (install)

LangString NameSecAppFiles ${LANG_ENGLISH} "${APP_NAME}"
LangString TextSecAppFiles ${LANG_ENGLISH} "Installing ${APP_NAME}..."
LangString NameSecAppFiles ${LANG_GERMAN} "${APP_NAME}"
LangString TextSecAppFiles ${LANG_GERMAN} "Installiere ${APP_NAME}..."
LangString NameRemoveApp ${LANG_ENGLISH} "Remove ${APP_NAME}"
LangString NameRemoveApp ${LANG_GERMAN} "${APP_NAME} entfernen"

Var IniFile

Section !$(NameSecAppFiles) SecAppFiles

  SectionIn RO ; Forced

  SetDetailsPrint textonly
  DetailPrint $(TextSecAppFiles)
  SetDetailsPrint listonly

  SetOverwrite on

  ; SystemPack
  StrCmp           $OUTDIR "$INSTDIR\Data" +2
    SetOutPath     "$INSTDIR\Data"
  IfFileExists     "SystemPack.vdf" "" union

    StrCmp         $OUTDIR "$INSTDIR\System" +2
      SetOutPath   "$INSTDIR\System"

    DetailPrint    "System Pack detected"

    IfFileExists   "pre.load" +7
      DetailPrint  "Create file: pre.load..."
      FileOpen  $4 "pre.load" w
      FileWrite $4 "Ninja.dll"
      FileWrite $4 "$\r$\n"
      FileClose $4
      Goto union

  ; Searching the existing file
  FileOpen      $4 "pre.load" r
  rline:
    FileRead    $4 $1
    IfErrors    rlinened
    ${TrimNewLines} "$1" $1
    StrCmp      "$1" "Ninja.dll" rlclose rline
  rlinened:
    DetailPrint  "Add Ninja.dll to pre.load..."
    FileClose $4
    FileOpen  $4 "pre.load" a
    FileSeek  $4 0 END
    FileWrite $4 "$\r$\n"
    FileWrite $4 "Ninja.dll"
    FileWrite $4 "$\r$\n"
  rlclose:
  FileClose     $4


  ; Union
  union:
  StrCmp          $OUTDIR "$INSTDIR\System" +2
    SetOutPath    "$INSTDIR\System"
  IfFileExists    "Union.patch" "" noloader
  DetailPrint     "Union detected"
  StrCpy $IniFile "Union.ini"
  IfFileExists    "$IniFile" unionadd

  unionsp:
  StrCpy $IniFile "SystemPack.ini"
  IfFileExists    "$IniFile" unionadd
    DetailPrint   "Assuming 1.0h or higher"
    DetailPrint   "Create file: $IniFile..."
    FileOpen  $4  "$IniFile" w
    FileWrite $4  "[PLUGINS]"
    FileWrite $4  "$\r$\n"
    FileWrite $4  "PluginList = Ninja.dll**"
    FileWrite $4  "$\r$\n"
    FileClose $4
    Goto main

  unionadd:
    ${ConfigRead} "$IniFile" "PluginList" $4
    ${TrimNewLines} "$4" $4

    ; Check if already existing
    ${WordFind}   "$4" "Ninja.dll**" "E#" $3
    IfErrors "" main

    ; Add comma if necessary
    StrCmp  "$4" "" +2
      StrCpy $4 "$4,"

    ; Append to list
    DetailPrint "Add Ninja.dll to PluginList ($IniFile)..."
    ${WordAdd}  "$4" " " "+Ninja.dll**" $5
    StrCmp      "$4" "$5" main
      ${ConfigWrite} "$IniFile" "PluginList" "$5" $0
    StrCmp      "$IniFile" "SystemPack.ini" main unionsp


  ; No DLL loader
  noloader:
  StrCmp          $OUTDIR "$INSTDIR\System" +2
    SetOutPath    "$INSTDIR\System"

  ; Check SystemPack again (for lack of Else-If)
  IfFileExists    "pre.load" main

  DetailPrint     "No loader found"
  DetailPrint     "Apply BugslayerUtil workaround..."

  ; Remove/Rename old backup file
  IfFileExists    "BugslayerUtilG.dll" "" +4
    IfFileExists  "BugslayerUtil.dll" "" +2
      Delete      "BugslayerUtil.dll"
    Rename        "BugslayerUtilG.dll" "BugslayerUtil.dll"

  ; Backup old BugslayerUtil
  IfFileExists    "BugslayerUtil.dll" "" +2
    Rename        "BugslayerUtil.dll" "BugslayerUtilG.dll"

  File            "${SRC_BASEDIR}\BugslayerUtil.dll"

  ; Ninja itself
  main:
  StrCmp         $OUTDIR "$INSTDIR\System" +2
    SetOutPath   "$INSTDIR\System"
  IfFileExists    "Ninja.dll" "" +2
    Delete        "Ninja.dll"
  File            "${SRC_BASEDIR}\Ninja.dll"

  ; Start menu entries
  SetShellVarContext current
  IfFileExists "$SMPROGRAMS\Gothic" +2
    CreateDirectory "$SMPROGRAMS\Gothic"
  CreateShortCut "$SMPROGRAMS\Gothic\$(NameRemoveApp).lnk" "$INSTDIR\${APP_FILE}-uninst.exe"

  DetailPrint    "Done"

SectionEnd


; Uninstall

Section !un.$(NameSecAppFiles) unSecAppFiles

  SectionIn RO  ; Forced


  ; SystemPack
  StrCmp         $OUTDIR "$INSTDIR\System" +2
    SetOutPath   "$INSTDIR\System"
  IfFileExists   "pre.load" "" union

  ; Searching the existing file
  StrCpy        $3 ""
  FileOpen      $4 "pre.load" r
  rline:
    FileRead    $4 $1
    IfErrors    rlinened
    ${TrimNewLines} "$1" $2
    StrCmp      "$2" "Ninja.dll" rline
    StrCpy      $3 "$3$1"
    Goto rline
  rlinened:
    FileClose $4

    DetailPrint "Remove Ninja.dll from pre.load..."

    ${TrimNewLines} "$3" $3
    StrLen    $4 "$3"
    IntCmp    $4 0 "" "" +3
    Delete    "pre.load"
    Goto union

    StrCpy    $3 "$3$\r$\n"
    FileOpen  $4 "pre.load" w
    FileWrite $4 "$3"
    FileClose $4


  ; Union
  union:
  StrCmp          $OUTDIR "$INSTDIR\System" +2
    SetOutPath    "$INSTDIR\System"
  StrCpy $IniFile "Union.ini"
  IfFileExists    "$IniFile" removeini

  removesp:
  StrCpy $IniFile "SystemPack.ini"
  IfFileExists    "$IniFile" "" loaderhelper

  removeini:
  ${ConfigRead} "$IniFile" "PluginList" $4
  ${TrimNewLines} "$4" $4

  DetailPrint   "Remove Ninja.dll from PluginList ($IniFile)..."

  ; Remove from list (many combinations of commas and spaces to be sure)
  ${WordAdd}  "$4" "," "-Ninja.dll**," $4  ; Comma front and end
  ${WordAdd}  "$4" " " "-Ninja.dll**," $4  ; Comma end
  ${WordAdd}  "$4" "," "-Ninja.dll**"  $4  ; Comma front
  ${WordAdd}  "$4" " " "-Ninja.dll**"  $4  ; No comma

  ${WordAdd}  "$4" "," "-Ninja.dll," $4  ; Comma front and end
  ${WordAdd}  "$4" " " "-Ninja.dll," $4  ; Comma end
  ${WordAdd}  "$4" "," "-Ninja.dll"  $4  ; Comma front
  ${WordAdd}  "$4" " " "-Ninja.dll"  $4  ; No comma

  ${ConfigWrite} "$IniFile" "PluginList" "$4" $0

  StrCmp      "$IniFile" "SystemPack.ini" "" removesp


  loaderhelper:
  StrCmp          $OUTDIR "$INSTDIR\System" +2
    SetOutPath    "$INSTDIR\System"

  ; Remove/Rename old backup file
  IfFileExists    "BugslayerUtilG.dll" "" +4
    IfFileExists  "BugslayerUtil.dll" "" +2
      Delete      "BugslayerUtil.dll"
    Rename        "BugslayerUtilG.dll" "BugslayerUtil.dll"

  ; Remove Ninja
  IfFileExists    "Ninja.dll" "" +2
      Delete      "Ninja.dll"

  ; Remove temporary VDF if present
  StrCmp          $OUTDIR "$INSTDIR\Data" +2
    SetOutPath    "$INSTDIR\Data"
  IfFileExists    "_delete_me.vdf" "" +2
      Delete      "_delete_me.vdf"

  ; Start menu entries
  SetShellVarContext current
  IfFileExists "$SMPROGRAMS\Gothic\$(NameRemoveApp).lnk" "" +2
    Delete "$SMPROGRAMS\Gothic\$(NameRemoveApp).lnk"
  IfFileExists "$SMPROGRAMS\Gothic\*.*" "" +2
    RMDir "$SMPROGRAMS\Gothic"

  DetailPrint   "Done"

SectionEnd


;-------------------------------------------------------------------------------
;
;   Cleanup (hidden)
;


; Setup

Section -post

  SetDetailsPrint none

  Delete           "$INSTDIR\${APP_FILE}-uninst.exe"
  WriteUninstaller "$INSTDIR\${APP_FILE}-uninst.exe"

SectionEnd


; Uninstall setup

Section -un.post

  SetDetailsPrint none

  DeleteRegKey HKLM "${APP_RKEY}"
  Delete "$INSTDIR\${APP_FILE}-uninst.exe"

SectionEnd


;===============================================================================
;
;   Functions
;


; Setup (init)

Function .onInit
  Push $R0

  SetCurInstType 0

  !insertmacro MUI_INSTALLOPTIONS_EXTRACT "setup.ini"

  SetSilent normal

  Pop $R0
FunctionEnd


; Uninstall (init)

LangString TextInvalidUninstall ${LANG_ENGLISH} "The installation directory is invalid.$\r$\nContinue uninstalling anyway?"
LangString TextInvalidUninstall ${LANG_GERMAN} "Das Installationsverzeichnis scheint ungültig zu sein.$\r$\nSoll die Deinstallation trotzdem fortgesetzt werden?"

Function un.onInit
  Push $R0

  ; Validate $INSTDIR
  IfFileExists "$INSTDIR\System\Ninja.dll" done

  ; Search registry
  ReadRegStr $R0 HKLM "${APP_RKEY}" "InstallLocation"
  StrCmp $R0 "" invalid
  StrCpy $INSTDIR $R0
  IfFileExists "$INSTDIR\System\Ninja.dll" done

  invalid:
  MessageBox MB_YESNO|MB_ICONQUESTION $(TextInvalidUninstall) IDYES done
    Pop $R0
    Abort

  done:
  Pop $R0
FunctionEnd


; Reinstall

LangString TextReinstTitle ${LANG_ENGLISH} "Previous Installation"
LangString TextReinstHead1 ${LANG_ENGLISH} "Choose how $(^Name) should be installed."
LangString TextReinstOpt1A ${LANG_ENGLISH} "Uninstall first"
LangString TextReinstOpt1B ${LANG_ENGLISH} "Do not uninstall"
LangString TextReinstHead2 ${LANG_ENGLISH} "Choose the repair option."
LangString TextReinstOpt2A ${LANG_ENGLISH} "Re-install"
LangString TextReinstOpt2B ${LANG_ENGLISH} "Uninstall $(^Name)"
LangString TextReinstWrong ${LANG_ENGLISH} "An incompatible version is already installed!\r\nIf you want to install this version,\r\nyou should uninstall the current version first."
LangString TextReinstOlder ${LANG_ENGLISH} "An older version is installed on your system.\r\nIt is recommended to uninstall the current version first."
LangString TextReinstNewer ${LANG_ENGLISH} "A newer version is already installed on your system!\r\nIt is not recommended to install an older version. If you really want to install the older version, you should uninstall the current version first."
LangString TextReinstEqual ${LANG_ENGLISH} "$(^Name) is already installed."

LangString TextReinstTitle ${LANG_GERMAN} "Vorherige Installation"
LangString TextReinstHead1 ${LANG_GERMAN} "Wählen Sie aus, wie $(^Name) installiert werden soll."
LangString TextReinstOpt1A ${LANG_GERMAN} "Vorher deinstallieren"
LangString TextReinstOpt1B ${LANG_GERMAN} "Nicht deinstallieren"
LangString TextReinstHead2 ${LANG_GERMAN} "Wählen Sie die auszuführende Wartungsoption aus."
LangString TextReinstOpt2A ${LANG_GERMAN} "Erneut installieren"
LangString TextReinstOpt2B ${LANG_GERMAN} "$(^Name) deinstallieren"
LangString TextReinstWrong ${LANG_GERMAN} "Eine inkompatible Version ist bereits installiert!\r\nWenn Sie diese Version wirklich installieren wollen,\r\nsollten Sie die aktuelle Version vorher deinstallieren."
LangString TextReinstOlder ${LANG_GERMAN} "Eine ältere Version ist auf Ihrem System installiert.\r\nEs wird empfohlen die aktuelle Version vorher zu deinstallieren."
LangString TextReinstNewer ${LANG_GERMAN} "Eine neuere Version ist bereits auf Ihrem System installiert!\r\nEs wird empfohlen die ältere Version nicht zu installieren. Wenn Sie diese ältere Version wirklich installieren wollen, sollten Sie die aktuelle Version vorher deinstallieren."
LangString TextReinstEqual ${LANG_GERMAN} "$(^Name) ist bereits installiert."

Function PageReinstall

  ; Read previous installation directory
  ReadRegStr $R0 HKLM "${APP_RKEY}" "InstallLocation"
  StrCmp $R0 "" 0 +2
  Abort

  ; Validate version
  ReadRegDWORD $R0 HKLM "${APP_RKEY}" "VersionFlags"
  IntCmp $R0 ${VER_FLAGS} major wrong wrong
  major:
  ReadRegDWORD $R0 HKLM "${APP_RKEY}" "VersionMajor"
  IntCmp $R0 ${VER_MAJOR} minor older newer
  minor:
  ReadRegDWORD $R0 HKLM "${APP_RKEY}" "VersionMinor"
  IntCmp $R0 ${VER_MINOR} patch older newer
  patch:
  ReadRegDWORD $R0 HKLM "${APP_RKEY}" "VersionPatch"
  IntCmp $R0 ${VER_PATCH} equal older newer
  wrong:
  !insertmacro MUI_INSTALLOPTIONS_WRITE "setup.ini" "Field 1" "Text" "$(TextReinstWrong)"
  !insertmacro MUI_INSTALLOPTIONS_WRITE "setup.ini" "Field 2" "Text" "$(TextReinstOpt1A)"
  !insertmacro MUI_INSTALLOPTIONS_WRITE "setup.ini" "Field 3" "Text" "$(TextReinstOpt1B)"
  !insertmacro MUI_HEADER_TEXT "$(TextReinstTitle)" "$(TextReinstHead1)"
  StrCpy $R0 "1"
  Goto start
  older:
  !insertmacro MUI_INSTALLOPTIONS_WRITE "setup.ini" "Field 1" "Text" "$(TextReinstOlder)"
  !insertmacro MUI_INSTALLOPTIONS_WRITE "setup.ini" "Field 2" "Text" "$(TextReinstOpt1A)"
  !insertmacro MUI_INSTALLOPTIONS_WRITE "setup.ini" "Field 3" "Text" "$(TextReinstOpt1B)"
  !insertmacro MUI_HEADER_TEXT "$(TextReinstTitle)" "$(TextReinstHead1)"
  StrCpy $R0 "1"
  Goto start
  newer:
  !insertmacro MUI_INSTALLOPTIONS_WRITE "setup.ini" "Field 1" "Text" "$(TextReinstNewer)"
  !insertmacro MUI_INSTALLOPTIONS_WRITE "setup.ini" "Field 2" "Text" "$(TextReinstOpt1A)"
  !insertmacro MUI_INSTALLOPTIONS_WRITE "setup.ini" "Field 3" "Text" "$(TextReinstOpt1B)"
  !insertmacro MUI_HEADER_TEXT "$(TextReinstTitle)" "$(TextReinstHead1)"
  StrCpy $R0 "1"
  Goto start
  equal:
  !insertmacro MUI_INSTALLOPTIONS_WRITE "setup.ini" "Field 1" "Text" "$(TextReinstEqual)"
  !insertmacro MUI_INSTALLOPTIONS_WRITE "setup.ini" "Field 2" "Text" "$(TextReinstOpt2A)"
  !insertmacro MUI_INSTALLOPTIONS_WRITE "setup.ini" "Field 3" "Text" "$(TextReinstOpt2B)"
  !insertmacro MUI_HEADER_TEXT "$(TextReinstTitle)" "$(TextReinstHead2)"
  StrCpy $R0 "2"
  start:
  !insertmacro MUI_INSTALLOPTIONS_DISPLAY "setup.ini"

FunctionEnd

Function PageLeaveReinstall

  !insertmacro MUI_INSTALLOPTIONS_READ $R1 "setup.ini" "Field 2" "State"
  StrCmp $R0 "1" 0 +2
  StrCmp $R1 "1" inst done
  StrCmp $R0 "2" 0 +3
  StrCmp $R1 "1" done inst
  inst:
  HideWindow
  ReadRegStr $R1 HKLM "${APP_RKEY}" "UninstallString"
  ClearErrors
  ExecWait '$R1 _?=$INSTDIR'
  IfErrors nope
  IfFileExists $R1 "" nope
  Delete $R1
  nope:
  StrCmp $R0 "2" 0 +2
  Quit
  BringToFront

  done:
FunctionEnd


; Setup (directory validation)

LangString TextVerifyDir ${LANG_ENGLISH} "Choose the installation directory of 'Gothic' 1.08k or 'Gothic II - Night of the Raven' 2.6."
LangString TextVerifyDir ${LANG_GERMAN} "Wählen Sie das Verzeichnis aus, in welchem sich 'Gothic' 1.08k oder 'Gothic II - Die Nacht des Raben' 2.6 befindet."

Var VerifyMessageOnce

Function .onVerifyInstDir

  IfFileExists "$INSTDIR\*.*" "" nope
  IfFileExists "$INSTDIR\System\*.*" "" nope
  IfFileExists "$INSTDIR\Data\*.*" "" nope

  Goto done

  nope:
  ; Show only once
  StrCmp $VerifyMessageOnce "done" +3
  MessageBox MB_OK|MB_ICONINFORMATION $(TextVerifyDir)
  StrCpy $VerifyMessageOnce "done"
  Abort

  done:
FunctionEnd
