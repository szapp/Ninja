NINJA_AUTHOR_PREFIX      db   AUTHOR_PREFIX, ':', 0
NINJA_LOADING_PREFIX     db   AUTHOR_PREFIX, ': NINJA:   ', 0
NINJA_IGNORING           db   AUTHOR_PREFIX, ': NINJA:   Ignoring ', 0
NINJA_LOOKING_FOR        db   AUTHOR_PREFIX, ':NINJA: Checking if file exists: ', 0
NINJA_INJECT             db   AUTHOR_PREFIX, ':NINJA: Injecting ', 0
NINJA_CALL_FUNC          db   AUTHOR_PREFIX, ': NINJA: Calling function ', 0
NINJA_OU_OVERWRITE       db   AUTHOR_PREFIX, ':   NINJA: Overwriting OU: ', 0
NINJA_OU_ADD             db   AUTHOR_PREFIX, ':   NINJA: Adding OU:      ', 0
NINJA_OU_BEFORE          db   AUTHOR_PREFIX, ':   NINJA: OU blocks before: ', 0
NINJA_OU_AFTER           db   AUTHOR_PREFIX, ':   NINJA: OU blocks after:  ', 0
NINJA_SYMBOL_FAILED      db   AUTHOR_PREFIX, ':NINJA: Failed to add helper symbol to symbol table!', 0
NINJA_SKIPPING           db   AUTHOR_PREFIX, ':NINJA: Skipping : ', 0
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
