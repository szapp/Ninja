char_initglobal          db   'INIT_GLOBAL', 0
char_initperceptions     db   'INITPERCEPTIONS', 0
char_repeat              db   'REPEAT', 0
char_while               db   'WHILE', 0
char_mem_label           db   'MEM_LABEL', 0
char_mem_goto            db   'MEM_GOTO', 0
char_ikarus              db   'IKARUS', 0
char_lego                db   'LEGO', 0
char_ikarus_symb         db   'IKARUS_VERSION', 0
char_lego_symb           db   'LEGO_VERSION', 0
char_nversion_symb       db   'NINJA_VERSION', 0
char_narray_symb         db   'NINJA_PATCHES', 0
char_ndivider_symb       db   'NINJA_SYMBOLS_START', 0
char_rb                  db   'rb', 0
char_g1g2                db   '_G', g1g2('1','2'), 0
char_zOPT_ignorePatches  db   'IncompatibleNinjaPatches', 0
char_prevDir             db   '\..', 0
NINJA_PATH               db   '\NINJA\', 0
NINJA_PATH_MUSIC         db   'MUSIC', 0
NINJA_PATH_SFX           db   'SFX', 0
NINJA_PATH_PFX           db   'PFX', 0
NINJA_PATH_VFX           db   'VFX', 0
NINJA_PATH_OU            db   'OU', 0
NINJA_PATH_CONTENT       db   'CONTENT', 0
NINJA_PATH_FIGHT         db   'FIGHT', 0
NINJA_PATH_MENU          db   'MENU', 0
NINJA_PATH_CAMERA        db   'CAMERA', 0
NINJA_PATH_DATA          db   'DATA\', 0
NINJA_PATH_VDF           db   'DATA\NINJA_*.VDF', 0
NINJA_PATH_IKARUS        db   '\NINJA\IKARUS\IKARUS.D', 0
NINJA_PATH_LEGO          db   '\NINJA\LEGO\LEGO.D', 0
NINJA_MDS_PREFIX         db   'ANIMS_', 0
NINJA_AUTHOR_PREFIX      db   AUTHOR_PREFIX, ':', 0
NINJA_LOOKING_FOR        db   AUTHOR_PREFIX, ':NINJA: Checking if file exists: ', 0
NINJA_IGNORING           db   AUTHOR_PREFIX, ':    Ignoring ', 0
NINJA_INJECT             db   AUTHOR_PREFIX, ':NINJA: Injecting ', 0
NINJA_CALL_FUNC          db   AUTHOR_PREFIX, ': NINJA: Calling function ', 0
NINJA_OU_OVERWRITE       db   AUTHOR_PREFIX, ':   NINJA: Overwriting OU: ', 0
NINJA_OU_ADD             db   AUTHOR_PREFIX, ':   NINJA: Adding OU:      ', 0
NINJA_OU_BEFORE          db   AUTHOR_PREFIX, ':   NINJA: OU blocks before: ', 0
NINJA_OU_AFTER           db   AUTHOR_PREFIX, ':   NINJA: OU blocks after:  ', 0
NINJA_VERSION_CHAR       db   'Ninja ', NINJA_VERSION, ' (built ', __UTC_DATE__, ' ', __UTC_TIME__, ' UTC) '
                         db   '<', NINJA_WEBSITE, '>', 0
NINJA_VERSION_CHAR_len   equ  $-NINJA_VERSION_CHAR
NINJA_CON_COMMAND        db   'NINJA', 0
NINJA_CON_DESCR          db   'List active Ninja patches in order', 0
NINJA_CON_NOTFOUND       db   0xA, 'No patches active.', 0
NINJA_SYMBOL_FAILED      db   AUTHOR_PREFIX, ':NINJA: Failed to add helper symbol to symbol table!', 0
NINJA_PARSER_FAILED      db   AUTHOR_PREFIX, ':NINJA: Ninja patch uses an invalid ', 0
NINJA_PARSER_FAILED_2    db   ' version. ', 10, 13
                         db   'Please use the version specifically for Ninja ', 10, 13
                         db   'found at <', NINJA_TEMPLATE, '>', 0
NINJA_PATH_INVALID       db   AUTHOR_PREFIX, ':NINJA: The directory \NINJA\ is reserved for Ikarus and LeGo. ', 10, 13
                         db   'Please keep Ikarus and LeGo in \NINJA\IKARUS\ and \NINJA\LEGO\ and ', 10, 13
                         db   'all other files within the patch directory \NINJA\[PATCHNAME]\. ', 10, 13
                         db   'For more information about Ninja patches, ', 10, 13
                         db   'visit <', NINJA_TEMPLATE, '>', 0
NINJA_LEGO_END           db   AUTHOR_PREFIX, ':NINJA: LeGo version not understood (Onset not found)', 0
NINJA_LEGO_BMM           db   AUTHOR_PREFIX, ':NINJA: LeGo version not understood (Base-major-minor incomplete)', 0
NINJA_VERSION_INVALID    db   AUTHOR_PREFIX, ':NINJA: The %s version of the game is newer than the patch. ', 10, 13
                         db   'Game: %09d, patch: %09d ', 10, 13
                         db   'Please update your Ninja patches or report outdated patches at ', 10, 13
                         db   '<', NINJA_WEBSITE, '>', 0
