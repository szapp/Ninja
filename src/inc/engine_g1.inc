%ifndef ENGINE_G1_INC
    %define ENGINE_G1_INC

    %define     _atexit                                   0x77661B     ; void (__cdecl *)()
    %define     operator_new                              0x54EBA0     ; uint
    %define     operator_new_len                          0x54EBE0     ; uint, char const *, char const *, int
    %define     operator_delete                           0x54EBB0     ; void *
    %define     _memset                                   0x7831B0     ; void *, int, size_t
    %define     dynamic_cast                              0x77709A     ; void **, int, TypeDescriptor *, TypeDescriptor *, int
    %define     operator_StrPlusChar                      0x404740     ; zSTRING const &, char const *
    %define     zCArray_int___zCArray_int_                0x5499D0     ; void
    %define     zCArray_int___InsertEnd                   0x530010     ; int const &
    %define     zCArray_int____zCArray_int_               0x52FF50     ; void
    %define     _qsort                                    0x77757F     ; void *, size_t, size_t, int (__cdecl *)(const void *, const void *)
    %define     _fopen                                    0x778672     ; const char *, const char *
    %define     _fseek                                    0x778588     ; FILE *, __int32, int
    %define     _fread                                    0x778A51     ; void *, size_t, size_t, FILE *
    %define     _fclose                                   0x7787BE     ; FILE *
    %define     _findfirst                                0x778B68     ; const char *, finddata_t *
    %define     _findnext                                 0x778C35     ; int, _finddata_t *
    %define     _findclose                                0x778CFD     ; int
    %define     zFILE_VDFS__LockCriticalSection           0x4471C0     ; void
    %define     zFILE_VDFS__UnlockCriticalSection         0x4471E0     ; void
    %define     zFILE_cur_mds_file                        0x873D6C     ; zFILE *
    %define     std__basic_string__assign                 0x403010     ; char const *, uint
    %define     _atol                                     0x77774D     ; const char *
    %define     _itoa                                     0x789587     ; int, char *, int
    %define     zSTRING__zSTRING                          0x4013A0     ; char const *
    %define     zSTRING___zSTRING                         0x401260     ; void
    %define     zSTRING__Sprintf                          0x467A90     ; char const *, ...
    %define     zSTRING__Upper                            0x465390     ; void
    %define     zSTRING__Search                           0x467750     ; int, char const *, uint
    %define     zSTRING__TrimRight                        0x4675A0     ; char
    %define     zSTRING__Delete                           0x4668D0     ; uint, ulong
    %define     zSTRING__operator_plusEq                  0x644ED0     ; char const *
    %define     ds_lstrcatA                               0x7D02D8     ; LPTSTR, LPTSTR
    %define     ds_lstrcpyA                               0x7D0288     ; LPTSTR, LPTSTR
    %define     ds_lstrlenA                               0x7D0274     ; LPCSTR
    %define     ds_lstrcmpiA                              0x7D02C4     ; LPCSTR, LPCSTR
    %define     _strncmp                                  0x7859F0     ; char *, char *, int
    %define     ds_vdf_fexists                            0x7D04D0     ; const char*, long
    %define     zCParser_parser                           0x8DCE08     ; zCParser
    %define     zCParser__CallFunc                        0x6E9670     ; zSTRING const &
    %define     zCParser__Error                           0x6E5040     ; zSTRING &, int
    %define     zCParser__MergeFile                       0x6E82F0     ; zSTRING &
    %define     zCParser__GetIndex                        0x6EA0C0     ; zSTRING const &
    %define     zCParser__GetSymbol_str                   0x6EA520     ; zSTRING const &
    %define     zCParser__GetSymbolInfo                   0x6EA440     ; int, int &, int &
    %define     zCParser__GetInstance                     0x6EA380     ; int, int
    %define     zCParser__CreateInstance                  0x6E9BE0     ; int, void *
    %define     zCParser__cur_parser                      0x8DDFD4     ; zCParser *
    %define     zCParser__enableParsing                   0x8DDFCC     ; int
    %define     zCPar_SymbolTable__Insert                 0x6FA430     ; zCPar_Symbol *
    %define     zCPar_SymbolTable__GetIndex               0x6F9FA0     ; zCPar_Symbol *
    %define     zCPar_SymbolTable__GetIndex_str           0x6FA090     ; zSTRING const &
    %define     zCPar_SymbolTable__GetSymbol_int          0x6FA410     ; int
    %define     zCPar_SymbolTable__GetSymbol_str          0x6FA370     ; zSTRING const &
    %define     zCPar_SymbolTable__cur_table              0x8DE174     ; zCPar_SymbolTable *
    %define     zCPar_Symbol__zCPar_Symbol                0x6F7D20     ; void
    %define     zCPar_Symbol__SetFlag                     0x6F8450     ; int
    %define     zCPar_Symbol__GetValue                    0x6F86E0     ; int &, int
    %define     zCPar_Symbol__SetValue                    0x6F8530     ; int, int
    %define     zCPar_Symbol__SetStackPos                 0x6F8520     ; int, int
    %define     zCMusicSys_DirectMusic__musicParser       0x86D6A8     ; zCParser *
    %define     zCSndSys_MSS__sfxParser                   0x86DCFC     ; zCParser *
    %define     zCParticleFX__s_pfxParser                 0x874380     ; zCParser *
    %define     oCVisualFX__fxParser                      0x869E6C     ; zCParser *
    %define     zCMenu__menuParser                        0x86D3D8     ; zCParser *
    %define     zCAICamera__cameraParser                  0x86A1E0     ; zCParser *
    %define     zCSoundSystem_zsound                      0x8CEE4C     ; zCSoundSystem *
    %define     oCGame_ogame                              0x8DA6BC     ; oCGame *
    %define     oCGame__GetInfoManager                    0x638AE0     ; void
    %define     oCMissionManager_misMan                   0x8DAB2C     ; oCMissionManager*
    %define     oCNpc__classDef                           0x8DB408     ; zCClassDef
    %define     oCNpc__vftable                            0x7DDF34     ; const
    %define     oCItem__vftable                           0x7DD0CC     ; const
    %define     zCObject__CheckInheritance                0x470130     ; zCClassDef const *, zCClassDef const *
    %define     oCWorld__RemoveFromLists                  0x6D7750     ; zCVob *
    %define     zCConsole_zcon                            0x8DC5A0     ; zCConsole *
    %define     zCConsole__AddEvalFunc                    0x6DBCA0     ; int (*)(zSTRING const &, zSTRING &)
    %define     zCConsole__Register                       0x6D9940     ; zSTRING const &, zSTRING const &
    %define     zERROR_zerr                               0x8699D8     ; zERROR *
    %define     zERROR__SearchForSpy                      0x449EB0     ; void
    %define     zERROR__Report                            0x448250     ; zERROR_TYPE, int, zSTRING const &, signed char, uint, int, char *, char *
    %define     zERROR__Message                           0x4492F0     ; zSTRING const &
    %define     zERROR__Fatal                             0x449360     ; zSTRING const &
    %define     zCOption_zoptions                         0x869694     ; zCOption *
    %define     zCOption_zgameoptions                     0x869698     ; zCOption *
    %define     zCOption__ReadString                      0x45D080     ; zSTRING const &, char const *, char const *
    %define     zCOption__GetDirString                    0x45FC00     ; zTOptionPaths
    %define     zCObjectFactory_zfactory                  0x873F88     ; zCObjectFactory *
    %define     zCModelPrototype__ReadModel               0x57E410     ; void
    %define     zCModelPrototype__SearchAniIndex          0x56F850     ; zSTRING const &
    %define     zCModelAni__deleting_destructor           0x56AA20     ; uint
    %define     zCArchiverFactory__CreateArchiverRead     0x50A240     ; zFILE *, int
    %define     zCArchiverFactory_zarcFactory             0x86F9AC     ; zCArchiverFactory
    %define     zCCSManager__LibValidateOU                0x41BE50     ; zString *
    %define     zCCSManager__LibAddOU                     0x41BA60     ; zCCSBlock *
    %define     zCCSLib___CreateNewInstance               0x418530     ; void
    %define     zCCSLib__deleting_destructor              0x418EB0     ; uint
    %define     zCCSBlock__deleting_destructor            0x40CF10     ; uint
    %define     zCListSort__GetNumInList                  0x670C60     ; void
    %define     zCListSort__InsertSort                    0x6D8260     ; void *
    %define     oCInfo__oCInfo                            0x6654C0     ; void
    %define     oCInfo__SetInstance                       0x665650     ; int
    %define     oCInfo__DoCheck                           0x665800     ; void
    %define     oCNpc_RTTI_Type_Descriptor                0x82D0B4     ; TypeDescriptor

    %define     SystemPack_version_info                   0x7CF576     ; char
    %define     NINJA_PATCH_ARRAY                         0x830391     ; zCArray

    %define     char_NUL                                  0x85E104     ; 0
    %define     char_space                                0x831600     ; ' ', 0
    %define     char_cnpc                                 0x849088     ; 'C_NPC', 0
    %define     char_model                                0x840908     ; 'MODEL', 0
    %define     char_mds                                  0x833534     ; '.MDS', 0
    %define     char_src                                  0x8373EC     ; '.SRC', 0
    %define     char_dot                                  0x82AFB4     ; '.', 0
    %define     char_commaSpace                           0x832494     ; ', ', 0
    %define     char_BSlash                               0x82DDA4     ; '\', 0
    %define     char_doubleFSlash                         0x82EDAC     ; '//', 0
    %define     char_lf                                   0x82D200     ; 0xA, 0
    %define     char_line                                 0x8520AC     ; ' ( line ', 0
    %define     char_spaceClosingParanthesis              0x8520A8     ; ' )', 0
    %define     char_zStartupWindowed                     0x846978     ; 'zStartupWindowed', 0
    %define     char_settings                             0x82BD98     ; 'SETTINGS', 0
    %define     char_meatbug_mds                          0x84E358     ; 'Meatbug.mds', 0
    %define     char_redefinedIdentifier                  0x8525C8     ; 'Redefined identifier : ', 0
    %define     zSTRING_mdlBuffer                         0x873C60     ; zSTRING *
    %define     zSTRING_infoClass                         0x8DA88C     ; zSTRING
    %define     zSTRING_empty                             0x869978     ; zSTRING const

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
    %define     zCParser_in_func_offset                   0x10D4       ; zCPar_Symbol *
    %define     zCParser_in_class_offset                  0x10D8       ; zCPar_Symbol *
    %define     zCParser_datsave_offset                   0x1090
    %define     zCParser_mergemode_offset                 0x109C

    %define     zCPar_Symbol_content_offset               0x18
    %define     zCPar_Symbol_bitfield_offset              0x20
    %define     zCPar_Symbol_parent_offset                0x38

    %define     zPAR_TOK_RET                              0x3C
    %define     zPAR_TOK_JUMP                             0x4B

    %define     zPAR_TYPE_INT                             2<<12
    %define     zPAR_TYPE_PROTOTYPE                       6<<12

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
