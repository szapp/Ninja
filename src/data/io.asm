char_ikarus              db   'IKARUS', 0
char_lego                db   'LEGO', 0
char_rb                  db   'rb', 0
char_g1g2                db   '_G', g1g2('1','2'), 0
char_bin                 db   '.BIN', 0
char_csl                 db   '.CSL', 0
char_zOPT_ignorePatches  db   'IncompatibleNinjaPatches', 0
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
NINJA_PATH_VDF           db   'DATA\*.VDF', 0
NINJA_PATH_IKARUS        db   '\NINJA\_INTERN\IKARUS\IKARUS.D', 0
NINJA_PATH_LEGO          db   '\NINJA\_INTERN\LEGO\LEGO.D', 0
NINJA_PATH_IKARUSSRC     db   '\NINJA\_INTERN\IKARUS\IKARUS_G', g1g2('1','2'), '.SRC', 0
NINJA_PATH_LEGOSRC       db   '\NINJA\_INTERN\LEGO\HEADER_G', g1g2('1','2'),'.SRC', 0
NINJA_MDS_PREFIX         db   'ANIMS_', 0
NINJA_FILE               db   '\SYSTEM\BUGSLAYERUTIL.DLL', 0
NINJA_VDF_DIR_NAME       db   'NINJA'
                 times 5 db   ' '
