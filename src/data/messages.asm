NINJA_AUTHOR_PREFIX      db   AUTHOR_PREFIX, ':', 0
NINJA_LOADING_MSG        db   AUTHOR_PREFIX, ': NINJA: Loading Ninja ', NINJA_VERSION, ' ', 0
NINJA_LOADING_PREFIX     db   AUTHOR_PREFIX, ': NINJA:   ', 0
NINJA_IGNORING           db   AUTHOR_PREFIX, ': NINJA:   Ignoring ', 0
NINJA_LOOKING_FOR        db   AUTHOR_PREFIX, ':NINJA: Checking if file exists: ', 0
NINJA_INJECT             db   AUTHOR_PREFIX, ':NINJA: Injecting ', 0
NINJA_CALL_FUNC          db   AUTHOR_PREFIX, ': NINJA: Calling function ', 0
NINJA_OU_OVERWRITE       db   AUTHOR_PREFIX, ':   NINJA: Overwriting OU: ', 0
NINJA_OU_ADD             db   AUTHOR_PREFIX, ':   NINJA: Adding OU:      ', 0
NINJA_OU_BEFORE          db   AUTHOR_PREFIX, ':   NINJA: OU blocks before: ', 0
NINJA_OU_AFTER           db   AUTHOR_PREFIX, ':   NINJA: OU blocks after:  ', 0
NIJNA_INFO_ADD           db   AUTHOR_PREFIX, ':  NINJA: Adding info: ', 0
NINJA_INFO_BEFORE        db   AUTHOR_PREFIX, ':  NINJA: Infos before: ', 0
NINJA_INFO_AFTER         db   AUTHOR_PREFIX, ':  NINJA: Infos after:  ', 0
NINJA_SYMBOL_FAILED      db   AUTHOR_PREFIX, ':NINJA: Failed to add helper symbol to symbol table!', 0
NINJA_SKIPPING           db   AUTHOR_PREFIX, ':NINJA: Skipping : ', 0
NINJA_OUTDATED_PATCH     db   AUTHOR_PREFIX, ':NINJA: One of your patches is outdated (Ninja <= 1.2)', 0
NINJA_PARSER_FAILED      db   AUTHOR_PREFIX, ':NINJA: Version mismatch of ', 0
NINJA_PARSER_FAILED_2    db   '. ', 10, 13
NINJA_PATH_INVALID       db   'One of your patches contains Ikarus or LeGo. ', 10, 13
                         db   'This is not allowed. Ninja already provides the latest ', 10, 13
                         db   'versions of both - including necessary adjustments. ', 10, 13
                         db   'For more information on creating patches with Ninja, ', 10, 13
                         db   'visit <', NINJA_TEMPLATE, '>', 0
NINJA_LEGO_END           db   AUTHOR_PREFIX, ':NINJA: LeGo version not understood: onset not found.', 0
NINJA_LEGO_BMM           db   AUTHOR_PREFIX, ':NINJA: LeGo version not understood: base-major-minor incomplete.', 0
NINJA_VERSION_INVALID    db   AUTHOR_PREFIX, ':NINJA: The %s version of the game is newer than that of Ninja. ', 10, 13
                         db   'Game: %09d, Ninja: %09d ', 10, 13
                         db   'Please update your version of Ninja or report this error at ', 10, 13
                         db   '<', NINJA_WEBSITE, '>', 0
