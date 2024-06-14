%ifndef ENGINE_G112_INC
    %define ENGINE_G112_INC

    %define     _atexit                                   0x7BA3DB     ; void (__cdecl *)()
    %define     _exit                                     0x7BB68A     ; void
    %define     operator_new                              0x5670A0     ; uint
    %define     operator_new_len                          0x5670E0     ; uint, char const *, char const *, int
    %define     operator_delete                           0x5670B0     ; void *
    %define     _memset                                   0x7C6DB0     ; void *, int, size_t
    %define     dynamic_cast                              0x7BAE5A     ; void **, int, TypeDescriptor *, TypeDescriptor *, int
    %define     operator_StrPlusChar                      0x404F30     ; zSTRING const &, char const *
    %define     zCArray_int___zCArray_int_                0x5619C0     ; void
    %define     zCArray_int___InsertEnd                   0x4D9010     ; int const &
    %define     zCArray_int____zCArray_int_               0x546860     ; void
    %define     zCArraySort_zCMenu___InsertSort           0x4E19B0     ; zCMenu *
    %define     zCArraySort_int___QuickSort               0x631890     ; void
    %define     _qsort                                    0x7BB33F     ; void *, size_t, size_t, int (__cdecl *)(const void *, const void *)
    %define     _fopen                                    0x7BC432     ; const char *, const char *
    %define     _fseek                                    0x7BC348     ; FILE *, __int32, int
    %define     _fread                                    0x7BC811     ; void *, size_t, size_t, FILE *
    %define     _fclose                                   0x7BC57E     ; FILE *
    %define     _findfirst                                0x7BC928     ; const char *, finddata_t *
    %define     _findnext                                 0x7BC9F5     ; int, _finddata_t *
    %define     _findclose                                0x7BCABD     ; int
    %define     zFILE_VDFS__LockCriticalSection           0x44D120     ; void
    %define     zFILE_VDFS__UnlockCriticalSection         0x44D140     ; void
    %define     zFILE_cur_mds_file                        0x8B9BC4     ; zFILE *
    %define     zFILE_VDFS__DeinitFileSystem              0x44CD90     ; void
    %define     std__basic_string__assign                 0x403480     ; char const *, uint
    %define     _atol                                     0x7BB50D     ; const char *
    %define     _itoa                                     0x7CC64A     ; int, char *, int
    %define     zSTRING__zSTRING                          0x4010C0     ; char const *
    %define     zSTRING__zSTRING_void                     0x402F90     ; void
    %define     zSTRING___zSTRING                         0x401160     ; void
    %define     zSTRING__Sprintf                          0x46F9F0     ; char const *, ...
    %define     zSTRING__Upper                            0x46D090     ; void
    %define     zSTRING__Search                           0x46F650     ; int, char const *, uint
    %define     zSTRING__TrimRight                        0x46F4A0     ; char
    %define     zSTRING__Delete                           0x46E710     ; uint, ulong
    %define     zSTRING__DeleteRight                      0x46E600     ; uint
    %define     zSTRING__operator_eq                      0x4D5310     ; char const *
    %define     zSTRING__operator_plusEq                  0x66C7D0     ; char const *
    %define     ds_lstrcatA                               0x8132E0     ; LPTSTR, LPTSTR
    %define     ds_lstrcpyA                               0x81328C     ; LPTSTR, LPTSTR
    %define     ds_lstrlenA                               0x813278     ; LPCSTR
    %define     ds_lstrcmpiA                              0x8132D0     ; LPCSTR, LPCSTR
    %define     _strncmp                                  0x7C95F0     ; char *, char *, int
    %define     ds_vdf_fexists                            0x8134B4     ; const char*, long
    %define     sysEvent                                  0x509530     ; void
    %define     zCParser_parser                           0x925048     ; zCParser
    %define     zCParser__CallFunc                        0x722640     ; zSTRING const &
    %define     zCParser__ParseBlock                      0x71F8E0     ; void
    %define     zCParser__Error                           0x71DA20     ; zSTRING &, int
    %define     zCParser__MergeFile                       0x721270     ; zSTRING &
    %define     zCParser__GetIndex                        0x723120     ; zSTRING const &
    %define     zCParser__GetSymbol_str                   0x723580     ; zSTRING const &
    %define     zCParser__GetSymbolInfo                   0x7234A0     ; int, int &, int &
    %define     zCParser__GetInstance                     0x7233F0     ; int, int
    %define     zCParser__CreateInstance                  0x722C10     ; int, void *
    %define     zCParser__cur_parser                      0x926214     ; zCParser *
    %define     zCParser__enableParsing                   0x92620C     ; int
    %define     zCParser__ClearInstanceRefs               0x726840     ; void *
    %define     zCPar_SymbolTable__Insert                 0x7347C0     ; zCPar_Symbol *
    %define     zCPar_SymbolTable__GetIndex               0x734330     ; zCPar_Symbol *
    %define     zCPar_SymbolTable__GetIndex_str           0x734420     ; zSTRING const &
    %define     zCPar_SymbolTable__GetSymbol_int          0x7347A0     ; int
    %define     zCPar_SymbolTable__GetSymbol_str          0x734700     ; zSTRING const &
    %define     zCPar_SymbolTable__cur_table              0x9263D4     ; zCPar_SymbolTable *
    %define     zCPar_Symbol__zCPar_Symbol                0x731E80     ; void
    %define     zCPar_Symbol__SetFlag                     0x7326D0     ; int
    %define     zCPar_Symbol__GetValue                    0x732950     ; int &, int
    %define     zCPar_Symbol__SetValue_int                0x7327A0     ; int, int
    %define     zCPar_Symbol__SetValue_str                0x732800     ; zSTRING &, int
    %define     zCPar_Symbol__SetStackPos                 0x732790     ; int, int
    %define     zCMusicSys_DirectMusic__musicParser       0x8B31FC     ; zCParser *
    %define     zCSndSys_MSS__sfxParser                   0x8B38C0     ; zCParser *
    %define     zCParticleFX__s_pfxParser                 0x8BA204     ; zCParser *
    %define     oCVisualFX__fxParser                      0x8AF4EC     ; zCParser *
    %define     zCMenu__menuParser                        0x8B2F04     ; zCParser *
    %define     zCAICamera__cameraParser                  0x8AFB5C     ; zCParser *
    %define     zCSoundSystem_zsound                      0x914D14     ; zCSoundSystem *
    %define     oCGame_ogame                              0x920D8C     ; oCGame *
    %define     oCGame__GetInfoManager                    0x65F030     ; void
    %define     oCMissionManager_misMan                   0x921C50     ; oCMissionManager*
    %define     oCNpc__classDef                           0x922830     ; zCClassDef
    %define     oCItem__classDef                          0x921950     ; zCClassDef
    %define     zCObject__CheckInheritance                0x478FF0     ; zCClassDef const *, zCClassDef const *
    %define     oCWorld__InsertInLists                    0x70F1C0     ; zCVob *
    %define     oCWorld__RemoveFromLists                  0x70F2B0     ; zCVob *
    %define     zCConsole_zcon                            0x9247D8     ; zCConsole *
    %define     zCConsole__AddEvalFunc                    0x713CF0     ; int (*)(zSTRING const &, zSTRING &)
    %define     zCConsole__Register                       0x7115D0     ; zSTRING const &, zSTRING const &
    %define     zERROR_zerr                               0x8AE718     ; zERROR *
    %define     zERROR__SearchForSpy                      0x4501B0     ; void
    %define     zERROR__Report                            0x44E2B0     ; zERROR_TYPE, int, zSTRING const &, signed char, uint, int, char *, char *
    %define     zERROR__Message                           0x44F510     ; zSTRING const &
    %define     zERROR__Fatal                             0x44F580     ; zSTRING const &
    %define     zCOption_zoptions                         0x8AE3AC     ; zCOption *

    %define     zCOption__ReadString                      0x4648E0     ; zSTRING const &, char const *, char const *
    %define     zCOption__GetDirString                    0x467400     ; zTOptionPaths
    %define     zCOption__ParmValue                       0x467540     ; zSTRING const &
    %define     zCObjectFactory_zfactory                  0x8B9E00     ; zCObjectFactory *
    %define     zCModelPrototype__ReadModel               0x598C60     ; void
    %define     zCModelPrototype__SearchAniIndex          0x588C60     ; zSTRING const &
    %define     zCModelAni__deleting_destructor           0x583900     ; uint
    %define     zCArchiverFactory__CreateArchiverRead     0x51EEF0     ; zFILE *, int
    %define     zCArchiverFactory_zarcFactory             0x8B561C     ; zCArchiverFactory
    %define     zCCSManager__LibValidateOU                0x41DCB0     ; zString *
    %define     zCCSManager__LibAddOU                     0x41D930     ; zCCSBlock *
    %define     zCCSLib___CreateNewInstance               0x41A3A0     ; void
    %define     zCCSLib__deleting_destructor              0x41ADB0     ; uint
    %define     zCCSBlock__deleting_destructor            0x40E1D0     ; uint
    %define     zCListSort__GetNumInList                  0x69E530     ; void
    %define     zCListSort__InsertSort                    0x70FE00     ; void *
    %define     oCInfo__oCInfo                            0x6927A0     ; void
    %define     oCInfo__SetInstance                       0x692950     ; int
    %define     oCInfo__DoCheck                           0x692B00     ; void
    %define     oCNpc_RTTI_Type_Descriptor                0x872E80     ; TypeDescriptor


    %define     NINJA_PATCH_ARRAY                         0x875EF1     ; zCArray

    %define     char_NUL                                  0x8A2634     ; 0
    %define     char_space                                0x87719C     ; ' ', 0
    %define     char_cnpc                                 0x88EE54     ; 'C_NPC', 0
    %define     char_model                                0x8864F4     ; 'MODEL', 0
    %define     char_mds                                  0x8790A0     ; '.MDS', 0
    %define     char_src                                  0x898490     ; '.SRC', 0
    %define     char_dot                                  0x870DAC     ; '.', 0
    %define     char_commaSpace                           0x878024     ; ', ', 0
    %define     char_BSlash                               0x8738B8     ; '\', 0
    %define     char_doubleFSlash                         0x874900     ; '//', 0
    %define     char_lf                                   0x873018     ; 0xA, 0
    %define     char_line                                 0x898414     ; ' ( line ', 0
    %define     char_spaceClosingParanthesis              0x898410     ; ' )', 0
    %define     char_npc                                  0x89742C     ; 'npc', 0
    %define     char_spawnPos                             0x897420     ; 'spawnPos', 0
    %define     char_timer                                0x897418     ; 'timer', 0
    %define     char_noOfEntries                          0x897430     ; 'NoOfEntries', 0
    %define     char_spawningEnabled                      0x897408     ; 'spawningEnabled', 0
    %define     char_shortKey                             0x892FCC     ; 'shortKey', 0

    %define     char_zStartupWindowed                     0x88C634     ; 'zStartupWindowed', 0

    %define     char_meatbug_mds                          0x8944B0     ; 'Meatbug.mds', 0
    %define     char_redefinedIdentifier                  0x898934     ; 'Redefined identifier : ', 0
    %define     zSTRING_mdlBuffer                         0x8B9AA8     ; zSTRING *
    %define     zSTRING_infoClass                         0x921538     ; zSTRING
    %define     zSTRING_empty                             0x8AE6A8     ; zSTRING const
    %define     zOPT_SEC_GAME                             0x8AE058     ; zSTRING const

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
    %define     zCParser_stringcount_offset               0x10D0
    %define     zCParser_in_func_offset                   0x10D4       ; zCPar_Symbol *
    %define     zCParser_in_class_offset                  0x10D8       ; zCPar_Symbol *
    %define     zCParser_datsave_offset                   0x1090
    %define     zCParser_mergemode_offset                 0x109C
    %define     zCParser_progressBar_offset               0x1188

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
