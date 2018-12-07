%ifndef ENGINE_INC
    %define ENGINE_INC

    ; Version dependent macros (i.e. addresses, offsets and constants)
    %if GOTHIC_BASE_VERSION == 1

        %define     _atexit                                   0x77661B     ; void (__cdecl *)()
        %define     operator_new                              0x54EBA0     ; uint
        %define     operator_new_len                          0x54EBE0     ; uint, char const *, char const *, int
        %define     operator_delete                           0x54EBB0     ; void *
        %define     _memset                                   0x7831B0     ; void *, int, size_t
        %define     operator_StrPlusChar                      0x404740     ; zSTRING const &, char const *
        %define     zCArray_int___zCArray_int_                0x5499D0     ; void
        %define     zCArray_int___InsertEnd                   0x530010     ; int const &
        %define     zCArray_int____zCArray_int_               0x52FF50     ; void
        %define     _qsort                                    0x77757F     ; void *, size_t, size_t, int (__cdecl *)(const void *, const void *)
        %define     zCModel__AniAttachmentCompare             0x568AC0     ; void const *,void const *
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
        %define     ds_vdf_fexists                            0x7D04D0     ; const char*, long
        %define     zCParser_parser                           0x8DCE08     ; zCParser
        %define     zCParser__CallFunc                        0x6E9670     ; zSTRING const &
        %define     zCParser__MergeFile                       0x6E82F0     ; zSTRING &
        %define     zCParser__GetSymbol_str                   0x6EA520     ; zSTRING const &
        %define     zCParser__cur_parser                      0x8DDFD4     ; zCParser *
        %define     zCParser__enableParsing                   0x8DDFCC     ; int
        %define     zCPar_SymbolTable__GetIndex               0x6F9FA0     ; zCPar_Symbol *
        %define     zCPar_SymbolTable__GetIndex_str           0x6FA090     ; zSTRING const &
        %define     zCPar_SymbolTable__GetSymbol_int          0x6FA410     ; int
        %define     zCPar_SymbolTable__GetSymbol_str          0x6FA370     ; zSTRING const &
        %define     zCPar_SymbolTable__cur_table              0x8DE174     ; zCPar_SymbolTable *
        %define     zCPar_Symbol__SetStackPos                 0x6F8520     ; int, int
        %define     zCMusicSys_DirectMusic__musicParser       0x86D6A8     ; zCParser *
        %define     zCSndSys_MSS__sfxParser                   0x86DCFC     ; zCParser *
        %define     zCParticleFX__s_pfxParser                 0x874380     ; zCParser *
        %define     oCVisualFX__fxParser                      0x869E6C     ; zCParser *
        %define     zCMenu__menuParser                        0x86D3D8     ; zCParser *
        %define     zCAICamera__cameraParser                  0x86A1E0     ; zCParser *
        %define     zCSoundSystem_zsound                      0x8CEE4C     ; zCSoundSystem *
        %assign     oCGame_ogame                              0x8DA6BC     ; oCGame *
        %define     zCConsole_zcon                            0x8DC5A0     ; zCConsole *
        %define     zCConsole__AddEvalFunc                    0x6DBCA0     ; int (*)(zSTRING const &, zSTRING &)
        %define     zCConsole__Register                       0x6D9940     ; zSTRING const &, zSTRING const &
        %define     zERROR_zerr                               0x8699D8     ; zERROR *
        %define     zERROR__Report                            0x448250     ; zERROR_TYPE, int, zSTRING const &, signed char, uint, int, char *, char *
        %define     zERROR__Message                           0x4492F0     ; zSTRING const &
        %define     zERROR__Fatal                             0x449360     ; zSTRING const &
        %define     zCOption_zoptions                         0x869694     ; zCOption *
        %define     zCOption__GetDirString                    0x45FC00     ; zTOptionPaths
        %define     zCObjectFactory_zfactory                  0x873F88     ; zCObjectFactory *
        %define     zCModelPrototype__ReadModel               0x57E410     ; void
        %define     zCModelPrototype__SearchAniIndex          0x56F850     ; zSTRING const &
        %define     zCModelAni__deleting_destructor           0x56AA20     ; uint
        %define     zCArchiverFactory__CreateArchiverRead     0x50A240     ; zFILE *, int
        %define     zCArchiverFactory_zarcFactory             0x86F9AC     ; zCArchiverFactory
        %assign     zCCSManager__LibValidateOU                0x41BE50     ; zString *
        %assign     zCCSManager__LibAddOU                     0x41BA60     ; zCCSBlock *
        %define     zCCSLib___CreateNewInstance               0x418530     ; void
        %assign     zCCSLib__deleting_destructor              0x418EB0     ; uint
        %define     zCCSBlock__deleting_destructor            0x40CF10     ; uint

        %define     NINJA_PATCH_ARRAY                         0x830391     ; zCArray

        %define     char_space                                0x831600     ; ' ', 0
        %define     char_indent                               0x852E48     ; '    ', 0
        %define     char_model                                0x840908     ; 'MODEL', 0
        %define     char_mds                                  0x833534     ; '.MDS', 0
        %define     char_csl                                  0x82B078     ; '.csl', 0
        %define     char_src                                  0x8373EC     ; '.SRC', 0
        %define     char_dot                                  0x82AFB4     ; '.', 0
        %define     char_commaSpace                           0x832494     ; ', ', 0
        %define     char_underscore                           0x82AF18     ; '_', 0
        %define     char_BSlash                                    ; '\', 0
        %define     char_doubleFSlash                         0x82EDAC     ; '//', 0
        %define     char_lf                                   0x82D200     ; 0xA, 0
        %define     char_zStartupWindowed                     0x846978     ; 'zStartupWindowed', 0
        %define     str_mdlBuffer                             0x873C60     ; zSTRING *
        %define     zSTR_EMPTY                                0x869978     ; zSTRING const

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

        %define     zPAR_TOK_RET                              0x3C
        %define     zPAR_TOK_JUMP                             0x4B

        %define     char_sep                                  0x1A
        %define     INVALID_HANDLE_VALUE                      0xFFFFFFFF
        %define     VDF_VIRTUAL                               1
        %define     VDF_PHYSICAL                              2
        %define     VDF_PHYSICALFIRST                         4

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

    %elif GOTHIC_BASE_VERSION == 2

        %define     _atexit                                   0x7CFFC5     ; void (__cdecl *)()
        %define     operator_new                              0x565F50     ; uint
        %define     operator_delete                           0x565F60     ; void *
        %define     _memset                                   0x7DCA90     ; void *, int, size_t
        %define     operator_StrPlusChar                      0x404880     ; zSTRING const &, char const *
        %define     zCArray_int___zCArray_int_                0x560690     ; void
        %define     zCArray_int___InsertEnd                   0x4D5A30     ; int const &
        %define     zCArray_int____zCArray_int_               0x543CC0     ; void
        %define     _qsort                                    0x7D0F6F     ; void *, size_t, size_t, int (__cdecl *)(const void *, const void *)
        %define     zCModel__AniAttachmentCompare             0x583370     ; void const *,void const *
        %define     _fopen                                    0x7D2010     ; const char *, const char *
        %define     _fseek                                    0x7D1F26     ; FILE *, __int32, int
        %define     _fread                                    0x7D23EF     ; void *, size_t, size_t, FILE *
        %define     _fclose                                   0x7D215C     ; FILE *
        %define     _findfirst                                0x7D2506     ; const char *, finddata_t *
        %define     _findnext                                 0x7D25D3     ; int, _finddata_t *
        %define     _findclose                                0x7D269B     ; int
        %define     zFILE_VDFS__LockCriticalSection           0x44B7E0     ; void
        %define     zFILE_VDFS__UnlockCriticalSection         0x44B800     ; void
        %define     zFILE_cur_mds_file                        0x8D8BCC     ; zFILE *
        %define     std__basic_string__assign                 0x402FC0     ; char const *, uint
        %define     _atol                                     0x7D113D     ; const char *
        %define     _itoa                                     0x7E2E57     ; int, char *, int
        %define     zSTRING__zSTRING                          0x4010C0     ; char const *
        %define     zSTRING___zSTRING                         0x401160     ; void
        %define     zSTRING__Sprintf                          0x46CC60     ; char const *, ...
        %define     zSTRING__Upper                            0x46AB00     ; void
        %define     zSTRING__Search                           0x46C920     ; int, char const *, uint
        %define     zSTRING__TrimRight                        0x46C770     ; char
        %define     zSTRING__Delete                           0x46BAA0     ; uint, ulong
        %define     zSTRING__operator_plusEq                  0x67A7B0     ; char const *
        %define     ds_lstrcatA                               0x82E1E0     ; LPTSTR, LPTSTR
        %define     ds_lstrcpyA                               0x82E1E4     ; LPTSTR, LPTSTR
        %define     ds_lstrlenA                               0x82E1E8     ; LPCSTR
        %define     ds_lstrcmpiA                              0x82E174     ; LPCSTR, LPCSTR
        %define     ds_vdf_fexists                            0x82E66C     ; const char*, long
        %define     zCParser_parser                           0xAB40C0     ; zCParser
        %define     zCParser__CallFunc                        0x7929D0     ; zSTRING const &
        %define     zCParser__MergeFile                       0x791650     ; zSTRING &
        %define     zCParser__GetSymbol_str                   0x7938D0     ; zSTRING const &
        %define     zCParser__cur_parser                      0xAB628C     ; zCParser *
        %define     zCParser__enableParsing                   0xAB6284     ; int
        %define     zCPar_SymbolTable__GetIndex               0x7A3A70     ; zCPar_Symbol *
        %define     zCPar_SymbolTable__GetIndex_str           0x7A3B60     ; zSTRING const &
        %define     zCPar_SymbolTable__GetSymbol_int          0x7A3EE0     ; int
        %define     zCPar_SymbolTable__GetSymbol_str          0x7A3E40     ; zSTRING const &
        %define     zCPar_SymbolTable__cur_table              0xAB6428     ; zCPar_SymbolTable *
        %define     zCPar_Symbol__SetStackPos                 0x7A1E20     ; int, int
        %define     zCMusicSys_DirectMusic__musicParser       0x8D2140     ; zCParser *
        %define     zCSndSys_MSS__sfxParser                   0x8D2A64     ; zCParser *
        %define     zCParticleFX__s_pfxParser                 0x8D9234     ; zCParser *
        %define     oCVisualFX__fxParser                      0x8CE6EC     ; zCParser *
        %define     zCMenu__menuParser                        0x8D1E68     ; zCParser *
        %define     zCAICamera__cameraParser                  0x8CEAC8     ; zCParser *
        %define     zCSoundSystem_zsound                      0x99B03C     ; zCSoundSystem *
        %assign     oCGame_ogame                              0xAB0884     ; oCGame *
        %define     zCConsole_zcon                            0xAB3860     ; zCConsole *
        %define     zCConsole__AddEvalFunc                    0x784F80     ; int (*)(zSTRING const &, zSTRING &)
        %define     zCConsole__Register                       0x782AE0     ; zSTRING const &, zSTRING const &
        %define     zERROR_zerr                               0x8CDCD0     ; zERROR *
        %define     zERROR__Report                            0x44C8D0     ; zERROR_TYPE, int, zSTRING const &, signed char, uint, int, char *, char *
        %define     zERROR__Message                           0x44DA10     ; zSTRING const &
        %define     zERROR__Fatal                             0x44DA80     ; zSTRING const &
        %define     zCOption_zoptions                         0x8CD988     ; zCOption *
        %define     zCOption__GetDirString                    0x465260     ; zTOptionPaths
        %define     zCObjectFactory_zfactory                  0x8D8DF0     ; zCObjectFactory *
        %define     zCModelPrototype__ReadModel               0x59D4C0     ; zCFileBIN &
        %define     zCModelPrototype__SearchAniIndex          0x589FC0     ; zSTRING const &
        %define     zCModelAni__deleting_destructor           0x5852D0     ; uint
        %define     zCArchiverFactory__CreateArchiverRead     0x51A0B0     ; zFILE *, int
        %define     zCArchiverFactory_zarcFactory             0x8D472C     ; zCArchiverFactory
        %assign     zCCSManager__LibValidateOU                0x41C3E0     ; zString *
        %assign     zCCSManager__LibAddOU                     0x41BF50     ; zCCSBlock *
        %define     zCCSLib___CreateNewInstance               0x418A00     ; void
        %assign     zCCSLib__deleting_destructor              0x419400     ; uint
        %define     zCCSBlock__deleting_destructor            0x40D300     ; uint

        %define     NINJA_PATCH_ARRAY                         0x894155     ; zCArray

        %define     char_space                                0x8951AC     ; ' ', 0
        %define     char_indent                               0x8BC904     ; '    ', 0
        %define     char_model                                0x8A44CC     ; 'MODEL', 0
        %define     char_mds                                  0x8970E0     ; '.MDS', 0
        %define     char_csl                                  0x88F2D8     ; '.csl', 0
        %define     char_src                                  0x8BBDB0     ; '.SRC', 0
        %define     char_dot                                  0x88F1E4     ; '.', 0
        %define     char_commaSpace                           0x8960F8     ; ', ', 0
        %define     char_underscore                           0x88F1C8     ; '_', 0
        %define     char_BSlash                               0x891D58     ; '\', 0
        %define     char_doubleFSlash                         0x892C64     ; '//', 0
        %define     char_lf                                   0x89150C     ; 0xA, 0
        %define     char_zStartupWindowed                     0x8AA930     ; 'zStartupWindowed', 0
        %define     str_mdlBuffer                             0x8D8AC0     ; zSTRING *
        %define     zSTR_EMPTY                                0x8CDC70     ; zSTRING const

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
        %define     zCParser_in_func_offset                   0x20D4       ; zCPar_Symbol *
        %define     zCParser_in_class_offset                  0x20D8       ; zCPar_Symbol *
        %define     zCParser_datsave_offset                   0x2090
        %define     zCParser_mergemode_offset                 0x209C

        %define     zCPar_Symbol_content_offset               0x18

        %define     zPAR_TOK_RET                              0x3C
        %define     zPAR_TOK_JUMP                             0x4B

        %define     char_sep                                  0x1A
        %define     INVALID_HANDLE_VALUE                      0xFFFFFFFF
        %define     VDF_VIRTUAL                               1
        %define     VDF_PHYSICAL                              2
        %define     VDF_PHYSICALFIRST                         4

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

    %endif
%endif
