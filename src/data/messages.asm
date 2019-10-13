NINJA_AUTHOR_PREFIX      db   AUTHOR_PREFIX, ':', 0
NINJA_LOADING_MSG        db   AUTHOR_PREFIX, ': NINJA: Loading '
NINJA_VERSION_CHAR_1     db   'Ninja ', NINJA_VERSION, ', built ', __UTC_DATE__, ' ', __UTC_TIME__, ', ', 0
NINJA_VERSION_CHAR_1_len equ  $-NINJA_VERSION_CHAR_1
NINJA_REGISTER_CONSOLE   db   AUTHOR_PREFIX, ': NINJA: Registering console command', 0
NINJA_READING_INI        db   AUTHOR_PREFIX, ': NINJA: Reading ignore list from ini', 0
NINJA_LOADING_PREFIX     db   AUTHOR_PREFIX, ': NINJA:   ', 0
NINJA_IGNORING           db   AUTHOR_PREFIX, ': NINJA:   Ignoring ', 0
NINJA_DETECTING_SORTING  db   AUTHOR_PREFIX, ': NINJA: Detecting/sorting patches', 0
NINJA_PATCHES_FOUND      db   AUTHOR_PREFIX, ': NINJA: Patches found (sorted):', 0
NINJA_RELEASE_ARRAY      db   AUTHOR_PREFIX, ': NINJA: Releasing array', 0
NINJA_LOOKING_FOR        db   AUTHOR_PREFIX, ':NINJA: Checking if file exists: ', 0
NINJA_INJECT             db   AUTHOR_PREFIX, ':NINJA: Injecting ', 0
NINJA_OVERWRITING        db   AUTHOR_PREFIX, ':   NINJA: Overwriting : ', 0
NINJA_CALL_FUNC          db   AUTHOR_PREFIX, ': NINJA: Calling function ', 0
NINJA_OU_ADD             db   AUTHOR_PREFIX, ':   NINJA: Adding OU:      ', 0
NINJA_OU_BEFORE          db   AUTHOR_PREFIX, ':   NINJA: OUs before: ', 0
NINJA_OU_AFTER           db   AUTHOR_PREFIX, ':   NINJA: OUs after:  ', 0
NINJA_INFO_INJECT        db   AUTHOR_PREFIX, ': NINJA: Injecting infos', 0
NIJNA_INFO_ADD           db   AUTHOR_PREFIX, ':  NINJA: Adding info: ', 0
NINJA_INFO_BEFORE        db   AUTHOR_PREFIX, ':  NINJA: Infos before: ', 0
NINJA_INFO_AFTER         db   AUTHOR_PREFIX, ':  NINJA: Infos after:  ', 0
NINJA_REMOVE_NPC         db   AUTHOR_PREFIX, ':NINJA: Removing invalid NPC', 0
NINJA_SYMBOL_ADD_DIV     db   AUTHOR_PREFIX, ':NINJA: Adding divider symbol', 0
NINJA_SYMBOL_ADD_HLP     db   AUTHOR_PREFIX, ':NINJA: Adding helper symbols', 0
NINJA_SYMBOL_FAILED      db   AUTHOR_PREFIX, ':NINJA: Failed to add symbol: ', 0
NINJA_SKIPPING           db   AUTHOR_PREFIX, ':NINJA: Skipping : ', 0
NINJA_OUTDATED_PATCH     db   AUTHOR_PREFIX, ':NINJA: One of your patches is outdated (Ninja <= 1.2)', 0
NINJA_MOUNTFAIL          db   AUTHOR_PREFIX, ':NINJA: Ninja was attached too late (after VDFS)', 0
NINJA_VERIFY_PATH        db   AUTHOR_PREFIX, ':NINJA: Verifying file path', 0
NINJA_VERIFY_VERSION     db   AUTHOR_PREFIX, ':NINJA: Verifying version', 0
NINJA_COMPARE_VERSIONS   db   AUTHOR_PREFIX, ':NINJA: Comparing versions', 0
NINJA_PARSER_FAILED      db   AUTHOR_PREFIX, ':NINJA: Version mismatch of ', 0
NINJA_PARSER_FAILED_2    db   '. ', 10, 13
NINJA_PATH_INVALID       db   'One of your patches contains Ikarus/LeGo. ', 10, 13
                         db   'This is not allowed. Ninja already provides the latest ', 10, 13
                         db   'versions of both - including necessary adjustments.', 0
NINJA_LEGO_VER_ERROR     db   AUTHOR_PREFIX, ':NINJA: LeGo version not understood: ', 0
NINJA_LEGO_END           db   'Onset not found.', 0
NINJA_LEGO_BMM           db   'BMM incomplete.', 0
NINJA_VERSION_INVALID    db   AUTHOR_PREFIX, ':NINJA: The %s version of the game is newer than that of Ninja. ', 10, 13
                         db   'Game: %09d, Ninja: %09d ', 10, 13
                         db   'Please update Ninja or report this error at ', 10, 13
                         db   '<', NINJA_WEBSITE, '>', 0
