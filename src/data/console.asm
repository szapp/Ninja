NINJA_VERSION_CHAR       db   'Ninja ', NINJA_VERSION, ' (built ', __UTC_DATE__, ' ', __UTC_TIME__, ' UTC) '
                         db   '<', NINJA_WEBSITE, '>', 0
NINJA_VERSION_CHAR_len   equ  $-NINJA_VERSION_CHAR
NINJA_CON_COMMAND        db   'NINJA', 0
NINJA_CON_DESCR          db   'List active Ninja patches in order', 0
NINJA_CON_NOTFOUND       db   0xA, 'No patches active.', 0
