%ifndef ENGINE_G130_INC
    %define ENGINE_G130_INC

    %define     _atexit                                   0x     ; void (__cdecl *)()
    %define     _exit                                     0x     ; void
    %define     operator_new                              0x     ; uint

    %define     operator_delete                           0x     ; void *
    %define     _memset                                   0x     ; void *, int, size_t
    %define     dynamic_cast                              0x     ; void **, int, TypeDescriptor *, TypeDescriptor *, int
    %define     operator_StrPlusChar                      0x     ; zSTRING const &, char const *
    %define     zCArray_int___zCArray_int_                0x     ; void
    %define     zCArray_int___InsertEnd                   0x     ; int const &
    %define     zCArray_int____zCArray_int_               0x     ; void
    %define     zCArraySort_zCMenu___InsertSort           0x     ; zCMenu *
    %define     zCArraySort_int___QuickSort               0x     ; void
    %define     _qsort                                    0x     ; void *, size_t, size_t, int (__cdecl *)(const void *, const void *)
    %define     _fopen                                    0x     ; const char *, const char *
    %define     _fseek                                    0x     ; FILE *, __int32, int
    %define     _fread                                    0x     ; void *, size_t, size_t, FILE *
    %define     _fclose                                   0x     ; FILE *
    %define     _findfirst                                0x     ; const char *, finddata_t *
    %define     _findnext                                 0x     ; int, _finddata_t *
    %define     _findclose                                0x     ; int
    %define     zFILE_VDFS__LockCriticalSection           0x     ; void
    %define     zFILE_VDFS__UnlockCriticalSection         0x     ; void
    %define     zFILE_cur_mds_file                        0x     ; zFILE *
    %define     zFILE_VDFS__DeinitFileSystem              0x     ; void
    %define     std__basic_string__assign                 0x     ; char const *, uint
    %define     _atol                                     0x     ; const char *
    %define     _itoa                                     0x     ; int, char *, int
    %define     zSTRING__zSTRING                          0x     ; char const *
    %define     zSTRING__zSTRING_void                     0x     ; void
    %define     zSTRING___zSTRING                         0x     ; void
    %define     zSTRING__Sprintf                          0x     ; char const *, ...
    %define     zSTRING__Upper                            0x     ; void
    %define     zSTRING__Search                           0x     ; int, char const *, uint
    %define     zSTRING__TrimRight                        0x     ; char
    %define     zSTRING__Delete                           0x     ; uint, ulong
    %define     zSTRING__DeleteRight                      0x     ; uint
    %define     zSTRING__operator_eq                      0x     ; char const *
    %define     zSTRING__operator_plusEq                  0x     ; char const *
    %define     ds_lstrcatA                               0x     ; LPTSTR, LPTSTR
    %define     ds_lstrcpyA                               0x     ; LPTSTR, LPTSTR
    %define     ds_lstrlenA                               0x     ; LPCSTR
    %define     ds_lstrcmpiA                              0x     ; LPCSTR, LPCSTR
    %define     _strncmp                                  0x     ; char *, char *, int
    %define     ds_vdf_fexists                            0x     ; const char*, long
    %define     sysEvent                                  0x     ; void
    %define     zCParser_parser                           0x     ; zCParser
    %define     zCParser__CallFunc                        0x     ; zSTRING const &
    %define     zCParser__ParseBlock                      0x     ; void
    %define     zCParser__Error                           0x     ; zSTRING &, int
    %define     zCParser__MergeFile                       0x     ; zSTRING &
    %define     zCParser__GetIndex                        0x     ; zSTRING const &
    %define     zCParser__GetSymbol_str                   0x     ; zSTRING const &
    %define     zCParser__GetSymbolInfo                   0x     ; int, int &, int &
    %define     zCParser__GetInstance                     0x     ; int, int
    %define     zCParser__CreateInstance                  0x     ; int, void *
    %define     zCParser__cur_parser                      0x     ; zCParser *
    %define     zCParser__enableParsing                   0x     ; int
    %define     zCParser__ClearInstanceRefs               0x     ; void *
    %define     zCPar_SymbolTable__Insert                 0x     ; zCPar_Symbol *
    %define     zCPar_SymbolTable__GetIndex               0x     ; zCPar_Symbol *
    %define     zCPar_SymbolTable__GetIndex_str           0x     ; zSTRING const &
    %define     zCPar_SymbolTable__GetSymbol_int          0x     ; int
    %define     zCPar_SymbolTable__GetSymbol_str          0x     ; zSTRING const &
    %define     zCPar_SymbolTable__cur_table              0x     ; zCPar_SymbolTable *
    %define     zCPar_Symbol__zCPar_Symbol                0x     ; void
    %define     zCPar_Symbol__SetFlag                     0x     ; int
    %define     zCPar_Symbol__GetValue                    0x     ; int &, int
    %define     zCPar_Symbol__SetValue_int                0x     ; int, int
    %define     zCPar_Symbol__SetValue_str                0x     ; zSTRING &, int
    %define     zCPar_Symbol__SetStackPos                 0x     ; int, int
    %define     zCMusicSys_DirectMusic__musicParser       0x     ; zCParser *
    %define     zCSndSys_MSS__sfxParser                   0x     ; zCParser *
    %define     zCParticleFX__s_pfxParser                 0x     ; zCParser *
    %define     oCVisualFX__fxParser                      0x     ; zCParser *
    %define     zCMenu__menuParser                        0x     ; zCParser *
    %define     zCAICamera__cameraParser                  0x     ; zCParser *
    %define     zCSoundSystem_zsound                      0x     ; zCSoundSystem *
    %define     oCGame_ogame                              0x     ; oCGame *
    %define     oCGame__GetInfoManager                    0x     ; void
    %define     oCMissionManager_misMan                   0x     ; oCMissionManager*
    %define     oCNpc__classDef                           0x     ; zCClassDef
    %define     oCItem__classDef                          0x     ; zCClassDef
    %define     zCObject__CheckInheritance                0x     ; zCClassDef const *, zCClassDef const *
    %define     oCWorld__InsertInLists                    0x     ; zCVob *
    %define     oCWorld__RemoveFromLists                  0x     ; zCVob *
    %define     zCConsole_zcon                            0x     ; zCConsole *
    %define     zCConsole__AddEvalFunc                    0x     ; int (*)(zSTRING const &, zSTRING &)
    %define     zCConsole__Register                       0x     ; zSTRING const &, zSTRING const &
    %define     zERROR_zerr                               0x     ; zERROR *
    %define     zERROR__SearchForSpy                      0x     ; void
    %define     zERROR__Report                            0x     ; zERROR_TYPE, int, zSTRING const &, signed char, uint, int, char *, char *
    %define     zERROR__Message                           0x     ; zSTRING const &
    %define     zERROR__Fatal                             0x     ; zSTRING const &
    %define     zCOption_zoptions                         0x     ; zCOption *
    %define     zCOption_zgameoptions                     0x     ; zCOption *
    %define     zCOption__ReadString                      0x     ; zSTRING const &, char const *, char const *
    %define     zCOption__GetDirString                    0x     ; zTOptionPaths
    %define     zCOption__ParmValue                       0x     ; zSTRING const &
    %define     zCObjectFactory_zfactory                  0x     ; zCObjectFactory *
    %define     zCModelPrototype__ReadModel               0x     ; zCFileBIN &
    %define     zCModelPrototype__SearchAniIndex          0x     ; zSTRING const &
    %define     zCModelAni__deleting_destructor           0x     ; uint
    %define     zCArchiverFactory__CreateArchiverRead     0x     ; zFILE *, int
    %define     zCArchiverFactory_zarcFactory             0x     ; zCArchiverFactory
    %define     zCCSManager__LibValidateOU                0x     ; zString *
    %define     zCCSManager__LibAddOU                     0x     ; zCCSBlock *
    %define     zCCSLib___CreateNewInstance               0x     ; void
    %define     zCCSLib__deleting_destructor              0x     ; uint
    %define     zCCSBlock__deleting_destructor            0x     ; uint
    %define     zCListSort__GetNumInList                  0x     ; void
    %define     zCListSort__InsertSort                    0x     ; void *
    %define     oCInfo__oCInfo                            0x     ; void
    %define     oCInfo__SetInstance                       0x     ; int
    %define     oCInfo__DoCheck                           0x     ; void
    %define     oCNpc_RTTI_Type_Descriptor                0x     ; TypeDescriptor

    %define     SystemPack_version_info                   0x     ; char
    %define     NINJA_PATCH_ARRAY                         0x     ; zCArray

    %define     char_NUL                                  0x     ; 0
    %define     char_space                                0x     ; ' ', 0
    %define     char_cnpc                                 0x     ; 'C_NPC', 0
    %define     char_model                                0x     ; 'MODEL', 0
    %define     char_mds                                  0x     ; '.MDS', 0
    %define     char_src                                  0x     ; '.SRC', 0
    %define     char_dot                                  0x     ; '.', 0
    %define     char_commaSpace                           0x     ; ', ', 0
    %define     char_BSlash                               0x     ; '\', 0
    %define     char_doubleFSlash                         0x     ; '//', 0
    %define     char_lf                                   0x     ; 0xA, 0
    %define     char_line                                 0x     ; ' line ( ', 0
    %define     char_spaceClosingParanthesis              0x     ; ' )', 0
    %define     char_npc                                  0x     ; 'npc', 0
    %define     char_spawnPos                             0x     ; 'spawnPos', 0
    %define     char_timer                                0x     ; 'timer', 0
    %define     char_noOfEntries                          0x     ; 'NoOfEntries', 0
    %define     char_spawningEnabled                      0x     ; 'spawningEnabled', 0
    %define     char_spawnFlags                           0x     ; 'spawnFlags', 0
    %define     char_zStartupWindowed                     0x     ; 'zStartupWindowed', 0
    %define     char_settings                             0x     ; 'SETTINGS', 0
    %define     char_meatbug_mds                          0x     ; 'Meatbug.mds', 0
    %define     char_redefinedIdentifier                  0x     ; 'Redefined identifier : ', 0
    %define     zSTRING_mdlBuffer                         0x     ; zSTRING *
    %define     zSTRING_infoClass                         0x     ; zSTRING
    %define     zSTRING_empty                             0x     ; zSTRING const
    %define     zOPT_SEC_GAME                             0x     ; zSTRING const

    %define     zCObjectFactory__CreateZFile_offset       0x14         ; zSTRING const &
    %define     zFILE_VDFS__Exists_offset                 0x94         ; void
    %define     zFILE_VDFS__Open_offset                   0x8C         ; bool
    %define     zFILE_VDFS__Eof_offset                    0xB0         ; void
    %define     zFILE_VDFS__Read_offset                   0xC4         ; zSTRING &
    %define     zFILE_VDFS__Close_offset                  0x98         ; void
    %define     zFILE_VDFS__deleting_destructor_offset    0x0          ; uint

    %define     zCArchiver__ReadObject_offset             0xB0         ; zCObject *
    %define     zCArchiver__Close_offset                  0xE0         ; void
    %define     zCArchiver__deleting_destructor_offset    0xC          ; uint

    %define     zCParser_file_offset                      0x4
    %define     zCParser_table_offset                     0x10
    %define     zCParser_lastsym_offset                   0x34
    %define     zCParser_stackpos_offset                  0x48
    %define     zCParser_stringcount_offset               0x
    %define     zCParser_in_func_offset                   0x       ; zCPar_Symbol *
    %define     zCParser_in_class_offset                  0x       ; zCPar_Symbol *
    %define     zCParser_datsave_offset                   0x
    %define     zCParser_mergemode_offset                 0x


    %define     zCPar_Symbol_content_offset               0x18
    %define     zCPar_Symbol_offset_offset                0x1C
    %define     zCPar_Symbol_bitfield_offset              0x20

    %define     zPAR_TOK_RET                              0x3C
    %define     zPAR_TOK_JUMP                             0x4B

    %define     zPAR_TYPE_INT                             2<<12
    %define     zPAR_TYPE_STRING                          3<<12
    %define     zPAR_TYPE_PROTOTYPE                       6<<12
    %define     zPAR_TYPE_INSTANCE                        7<<12

    %define     zPAR_FLAG_CONST                           1<<16

    %define     char_sep                                  0x1A
    %define     INVALID_HANDLE_VALUE                      0xFFFFFFFF
    %define     VDF_VIRTUAL                               1
    %define     VDF_PHYSICAL                              2
    %define     VDF_PHYSICALFIRST                         4
    %define     VDF_TYPE_DIR                              0x80000000
    %define     VDF_TYPE_LAST                             0x40000000

    %define     DIR_ANIMS                                 4

    %define     SEEK_SET                                  0

    struc zCArray
        .array:           resd 0x1                                     ; 0x0 T*
        .numAlloc:        resd 0x1                                     ; 0x4 int
        .numInArray:      resd 0x1                                     ; 0x8 int
    endstruc

    struc zCArraySort
        .array:           resd 0x1                                     ; 0x0 T*
        .numAlloc:        resd 0x1                                     ; 0x4 int
        .numInArray:      resd 0x1                                     ; 0x8 int
        .compare:         resd 0x1                                     ; 0xC int (__cdecl *)(void *, void *)
    endstruc

    struc finddata_t
        .attrib           resd 0x1                                     ; 0x00
        .time_create      resd 0x1                                     ; 0x04
        .time_access      resd 0x1                                     ; 0x08
        .time_write       resd 0x1                                     ; 0x0C
        .size             resd 0x1                                     ; 0x10
        .name             resb 0x104                                   ; 0x14
    endstruc

    struc VDFheader
        .comment          resb 0x100                                   ; 0x000 char[]
        .signature        resb 0x10                                    ; 0x100 char[]
        .numEntries       resd 0x1                                     ; 0x110 int
        .numFiles         resd 0x1                                     ; 0x114 int
        .timestamp        resd 0x1                                     ; 0x118 int
        .datasize         resd 0x1                                     ; 0x11C int
        .rootOffset       resd 0x1                                     ; 0x120 int
        .entrySize        resd 0x1                                     ; 0x124 int
    endstruc

    struc VDFentry
        .name             resb 0x40                                    ; 0x00 char[]
        .offset           resd 0x1                                     ; 0x40 int
        .size             resd 0x1                                     ; 0x44 int
        .type             resd 0x1                                     ; 0x48 int
        .attrib           resd 0x1                                     ; 0x4C int
    endstruc

%endif
