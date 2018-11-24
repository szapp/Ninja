char_repeat              db   'REPEAT', 0
char_while               db   'WHILE', 0
char_mem_label           db   'MEM_LABEL', 0
char_mem_goto            db   'MEM_GOTO', 0
char_lego                db   'LEGO_VERSION', 0
char_lego_version        db   'LeGo 2.5.0-Ninja-v1.2', 0
char_rb                  db   'rb', 0
char_g1g2                db   '_G', g1g2('1','2'), 0
NINJA_PATH_MUSIC         db   '\NINJA\MUSIC_', 0
NINJA_PATH_SFX           db   '\NINJA\SFX_', 0
NINJA_PATH_PFX           db   '\NINJA\PFX_', 0
NINJA_PATH_VFX           db   '\NINJA\VFX_', 0
NINJA_PATH_CONTENT       db   '\NINJA\CONTENT_', 0
NINJA_PATH_FIGHT         db   '\NINJA\FIGHT_', 0
NINJA_PATH_MENU          db   '\NINJA\MENU_', 0
NINJA_PATH_CAMERA        db   '\NINJA\CAMERA_', 0
NINJA_PATH_ANIMATION     db   '\NINJA\ANIMATION_', 0
NINJA_PATH_DATA          db   'DATA\', 0
NINJA_PATH_VDF           db   'DATA\NINJA_*.VDF', 0
NINJA_AUTHOR_PREFIX      db   AUTHOR_PREFIX, ':', 0
NINJA_LOAD_ANIM          db   AUTHOR_PREFIX, ': MDS: Appending animations from ', 0
NINJA_VERSION_CHAR       db   'Ninja ', NINJA_VERSION, ' (built ', __UTC_DATE__, ' ', __UTC_TIME__, ' UTC) '
                         db   '<http://tiny.cc/GothicNinja>', 0
NINJA_VERSION_CHAR_len   equ  $-NINJA_VERSION_CHAR
NINJA_CON_COMMAND        db   'NINJA', 0
NINJA_CON_DESCR          db   'List all found Ninja patches in order', 0
NINJA_CON_NOTFOUND       db   0xA, 'No patches active.', 0
NINJA_PARSER_FAILED      db   AUTHOR_PREFIX, ':PAR:  Ninja patch uses invalid LeGo version. ', 10, 13
                         db   'Please use the version specifically for Ninja ', 10, 13
                         db   'found at <http://tiny.cc/GothicNinjaTemplate>', 0
