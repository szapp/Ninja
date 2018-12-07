char_repeat              db   'REPEAT', 0
char_while               db   'WHILE', 0
char_mem_label           db   'MEM_LABEL', 0
char_mem_goto            db   'MEM_GOTO', 0
char_ikarus              db   'IKARUS', 0
char_lego                db   'LEGO', 0
char_lego_symb           db   'LEGO_VERSION', 0
char_lego_version        db   'LeGo 2.5.0-N', NINJA_VERSION, 0
char_rb                  db   'rb', 0
char_g1g2                db   '_G', g1g2('1','2'), 0
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
NINJA_PATH_LEGO          db   '\NINJA\LEGO\LEGO.D', 0
NINJA_AUTHOR_PREFIX      db   AUTHOR_PREFIX, ':', 0
NINJA_LOOKING_FOR        db   AUTHOR_PREFIX, ':NINJA: Checking if file exists: ', 0
NINJA_INJECT             db   AUTHOR_PREFIX, ':NINJA: Injecting ', 0
NINJA_CALL_FUNC          db   AUTHOR_PREFIX, ': NINJA: Calling function ', 0
NINJA_LOAD_ANIM          db   AUTHOR_PREFIX, ': NINJA: Appending animations from ', 0
NINJA_OU_OVERWRITE       db   AUTHOR_PREFIX, ':   NINJA: Overwriting OU: ', 0
NINJA_OU_ADD             db   AUTHOR_PREFIX, ':   NINJA: Adding OU:      ', 0
NINJA_OU_BEFORE          db   AUTHOR_PREFIX, ':   NINJA: OU blocks before: ', 0
NINJA_OU_AFTER           db   AUTHOR_PREFIX, ':   NINJA: OU blocks after:  ', 0
NINJA_VERSION_CHAR       db   'Ninja ', NINJA_VERSION, ' (built ', __UTC_DATE__, ' ', __UTC_TIME__, ' UTC) '
                         db   '<', NINJA_WEBSITE, '>', 0
NINJA_VERSION_CHAR_len   equ  $-NINJA_VERSION_CHAR
NINJA_CON_COMMAND        db   'NINJA', 0
NINJA_CON_DESCR          db   'List all found Ninja patches in order', 0
NINJA_CON_NOTFOUND       db   0xA, 'No patches active.', 0
NINJA_PARSER_FAILED      db   AUTHOR_PREFIX, ':NINJA: Ninja patch uses invalid LeGo version. ', 10, 13
                         db   'Please use the version specifically for Ninja ', 10, 13
                         db   'found at <', NINJA_TEMPLATE, '>', 0
NINJA_PATH_INVALID       db   AUTHOR_PREFIX, ':NINJA: The directory \NINJA\ is reserved for Ikarus and LeGo. ', 10, 13
                         db   'Please keep all other files within the patch directory \NINJA\[PATCHNAME]\. ', 10, 13
                         db   'For more information about Ninja patches and their file structure, ', 10, 13
                         db   'see <', NINJA_TEMPLATE, '>', 0
NINJA_LEGO_INVALID_PATH  db   AUTHOR_PREFIX, ':NINJA: Invalid script file path.', 10, 13
                         db   'Please keep LeGo and Ikarus within their reserved directories ', 10, 13
                         db   '\NINJA\IKARUS\ and \NINJA\LEGO\. ', 10, 13
                         db   'For more information about Ninja patches and their file structure, ', 10, 13
                         db   'see <', NINJA_TEMPLATE, '>', 0
NINJA_LEGO_END           db   AUTHOR_PREFIX, ':NINJA: LeGo version not understood (Reached end of string while '
                         db   'searching for onset)', 0
NINJA_LEGO_BMM           db   AUTHOR_PREFIX, ':NINJA: LeGo version not understood (Base-major-minor incomplete)', 0
NINJA_LEGO_INVALID       db   AUTHOR_PREFIX, ':NINJA: The LeGo version of the game is newer then that of the patch. '
                         db   10, 13
                         db   'Game: %09d, patch: %09d ', 10, 13
                         db   'Please update your Ninja patches or report the outdated patch at ', 10, 13
                         db   '<', NINJA_WEBSITE, '>', 0
