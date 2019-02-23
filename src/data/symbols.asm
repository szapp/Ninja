; Version symbols
char_ikarus_symb         db   'IKARUS_VERSION', 0
char_lego_symb           db   'LEGO_VERSION', 0

; Preserved Gothic symbols
keep_func_symbol_start   db   'INIT_GLOBAL', 0
                         db   'INITPERCEPTIONS', 0

; Preserved Ikarus symbols
                         db   'REPEAT', 0
                         db   'WHILE', 0
                         db   'MEM_LABEL', 0
                         db   'MEM_GOTO', 0

; Preserved misc. symbols
                         db   'ALLOWSAVING', 0

; Preserved LeGo symbols
                         db   'FOCUSNAMES_COLOR_FRIENDLY', 0
                         db   'FOCUSNAMES_COLOR_NEUTRAL', 0
                         db   'FOCUSNAMES_COLOR_ANGRY', 0
                         db   'FOCUSNAMES_COLOR_HOSTILE', 0
                         db   '_FOCUSNAMES', 0
                         db   'BW_SAVEGAME', 0
keep_func_symbol_end     db   'BR_SAVEGAME', 0
keep_string_symbol_start db   'CURSOR_TEXTURE', 0
                         db   'PF_FONT', 0
                         db   'PRINT_LINESEPERATOR', 0
                         db   'DIAG_PREFIX', 0
keep_string_symbol_end   db   'DIAG_SUFFIX', 0
keep_int_symbol_start    db   'BLOODSPLAT_NUM', 0
                         db   'BLOODSPLAT_TEX', 0
                         db   'BLOODSPLAT_DAM', 0
                         db   'BUFFS_DISPLAYFORHERO', 0
                         db   'PF_PRINTX', 0
                         db   'PF_PRINTY', 0
                         db   'PF_TEXTHEIGHT', 0
                         db   'PF_FADEINTIME', 0
                         db   'PF_FADEOUTTIME', 0
                         db   'PF_MOVEYTIME', 0
                         db   'PF_WAITTIME', 0
                         db   'AIV_TALENT_INDEX', 0
                         db   'AIV_TALENT', 0

; Ninja helper symbols
char_ndivider_symb       db   'NINJA_SYMBOLS_START', 0
char_nversion_symb       db   'NINJA_VERSION', 0
char_narray_symb         db   'NINJA_PATCHES', 0
char_modname_symb        db   'NINJA_MODNAME', 0
