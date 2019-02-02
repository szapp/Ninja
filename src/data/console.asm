NINJA_VERSION_CHAR_1     db   'Ninja ', NINJA_VERSION, ' ('
NINJA_VERSION_CHAR_built db   'built ', __UTC_DATE__, ' ', __UTC_TIME__, ', ', 0
NINJA_VERSION_CHAR_1_len equ  $-NINJA_VERSION_CHAR_1
NINJA_VERSION_CHAR_2     db   ') <', NINJA_WEBSITE, '>', 0
NINJA_CON_COMMAND        db   'NINJA', 0
NINJA_CON_DESCR          db   'List all active patches (that use Ninja) in order', 0
NINJA_CON_NOTFOUND       db   0xA, 'No patches active.', 0
