NINJA_AUTHOR_PREFIX      db   AUTHOR_PREFIX, ':', 0
NINJA_LOADING_MSG        db   AUTHOR_PREFIX, ': NINJA: Loading '
NINJA_VERSION_CHAR_1     db   'Ninja ', NINJA_VERSION, ', built ', BUILD_TIME, ', ', 0
NINJA_VERSION_CHAR_1_len equ  $-NINJA_VERSION_CHAR_1
NINJA_REGISTER_CONSOLE   db   AUTHOR_PREFIX, ': NINJA: Adding console command', 0
NINJA_READING_INI        db   AUTHOR_PREFIX, ': NINJA: Reading ini ignore list', 0
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
NINJA_RENAME_SYMB        db   AUTHOR_PREFIX, ':NINJA: Renaming symbol', 0
NINJA_SYMBOL_ADD_DIV     db   AUTHOR_PREFIX, ':NINJA: Adding divider symbol', 0
NINJA_SYMBOL_ADD_HLP     db   AUTHOR_PREFIX, ':NINJA: Adding helper symbols', 0
NINJA_SYMBOL_FAILED      db   AUTHOR_PREFIX, ':NINJA: Failed to add symbol: ', 0
NINJA_STRINGCOUNT_APPLY  db   AUTHOR_PREFIX, ':NINJA: Adjusting string count to ', 0
NINJA_STRINGCOUNT_FAILED db   AUTHOR_PREFIX, ':NINJA: Failed to adjust string count', 0
NINJA_SKIPPING           db   AUTHOR_PREFIX, ':NINJA: Skipping : ', 0
NINJA_VERIFY_PATH        db   AUTHOR_PREFIX, ':NINJA: Verifying file path', 0
NINJA_VERIFY_VERSION     db   AUTHOR_PREFIX, ':NINJA: Verifying version', 0
NINJA_COMPARE_VERSIONS   db   AUTHOR_PREFIX, ':NINJA: Comparing versions', 0

; Fatal errors
NINJA_INVALID_PATCH      db   'Illegal VDF found "%s.VDF". ', 10, 13
                         db   'Remove it from /Data/ to continue.', 0
NINJA_MISSING_TOOLKIT    db   'Missing dependency. Please install Toolkit. ', 10, 13
                         db   NINJA_WEBSITE, '/toolkit', 0
NINJA_PATH_INVALID       db   'Ikarus/LeGo must not be contained in any patch.', 0
NINJA_LEGO_VER_ERROR     db   'LeGo version invalid.', 0
NINJA_VERSION_INVALID    db   'Version mismatch of %s. ', 10, 13
                         db   'Expected: %09d, Toolkit: %09d ', 10, 13
                         db   'Please update Ninja and Toolkit or report this to ', 10, 13
                         db   NINJA_WEBSITE, 0
