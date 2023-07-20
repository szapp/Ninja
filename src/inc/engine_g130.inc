%ifndef ENGINE_G130_INC
    %define ENGINE_G130_INC

    %define     _atexit                                   0x7C3B05     ; void (__cdecl *)()
    %define     _exit                                     0x7C4DFA     ; void
    %define     operator_new                              0x560D30     ; uint

    %define     operator_delete                           0x560D40     ; void *
    %define     _memset                                   0x7D05D0     ; void *, int, size_t
    %define     dynamic_cast                              0x7C457A     ; void **, int, TypeDescriptor *, TypeDescriptor *, int
    %define     operator_StrPlusChar                      0x404880     ; zSTRING const &, char const *
    %define     zCArray_int___zCArray_int_                0x55B470     ; void
    %define     zCArray_int___InsertEnd                   0x4D3470     ; int const &
    %define     zCArray_int____zCArray_int_               0x53EBB0     ; void
    %define     zCArraySort_zCMenu___InsertSort           0x4DB750     ; zCMenu *
    %define     zCArraySort_int___QuickSort               0x6384B0     ; void
    %define     _qsort                                    0x7C4AAF     ; void *, size_t, size_t, int (__cdecl *)(const void *, const void *)
    %define     _fopen                                    0x7C5B50     ; const char *, const char *
    %define     _fseek                                    0x7C5A66     ; FILE *, __int32, int
    %define     _fread                                    0x7C5F2F     ; void *, size_t, size_t, FILE *
    %define     _fclose                                   0x7C5C9C     ; FILE *
    %define     _findfirst                                0x7C6046     ; const char *, finddata_t *
    %define     _findnext                                 0x7C6113     ; int, _finddata_t *
    %define     _findclose                                0x7C61DB     ; int
    %define     zFILE_VDFS__LockCriticalSection           0x44B090     ; void
    %define     zFILE_VDFS__UnlockCriticalSection         0x44B0B0     ; void
    %define     zFILE_cur_mds_file                        0x8CA4FC     ; zFILE *
    %define     zFILE_VDFS__DeinitFileSystem              0x44ACF0     ; void
    %define     std__basic_string__assign                 0x402FC0     ; char const *, uint
    %define     _atol                                     0x7C4C7D     ; const char *
    %define     _itoa                                     0x7D6997     ; int, char *, int
    %define     zSTRING__zSTRING                          0x4010C0     ; char const *
    %define     zSTRING__zSTRING_void                     0x402AF0     ; void
    %define     zSTRING___zSTRING                         0x401160     ; void
    %define     zSTRING__Sprintf                          0x46C030     ; char const *, ...
    %define     zSTRING__Upper                            0x469ED0     ; void
    %define     zSTRING__Search                           0x46BCF0     ; int, char const *, uint
    %define     zSTRING__TrimRight                        0x46BB40     ; char
    %define     zSTRING__Delete                           0x46AE70     ; uint, ulong
    %define     zSTRING__DeleteRight                      0x46AD60     ; uint
    %define     zSTRING__operator_eq                      0x4CD590     ; char const *
    %define     zSTRING__operator_plusEq                  0x673100     ; char const *
    %define     ds_lstrcatA                               0x82021C     ; LPTSTR, LPTSTR
    %define     ds_lstrcpyA                               0x820220     ; LPTSTR, LPTSTR
    %define     ds_lstrlenA                               0x820224     ; LPCSTR
    %define     ds_lstrcmpiA                              0x820174     ; LPCSTR, LPCSTR
    %define     _strncmp                                  0x7D2E00     ; char *, char *, int
    %define     ds_vdf_fexists                            0x8204A0     ; const char*, long
    %define     sysEvent                                  0x5026F0     ; void
    %define     zCParser_parser                           0x984C08     ; zCParser
    %define     zCParser__CallFunc                        0x732F90     ; zSTRING const &
    %define     zCParser__ParseBlock                      0x7303F0     ; void
    %define     zCParser__Error                           0x72E830     ; zSTRING &, int
    %define     zCParser__MergeFile                       0x731C10     ; zSTRING &
    %define     zCParser__GetIndex                        0x733A30     ; zSTRING const &
    %define     zCParser__GetSymbol_str                   0x733E90     ; zSTRING const &
    %define     zCParser__GetSymbolInfo                   0x733DB0     ; int, int &, int &
    %define     zCParser__GetInstance                     0x733CF0     ; int, int
    %define     zCParser__CreateInstance                  0x733560     ; int, void *
    %define     zCParser__cur_parser                      0x985DD4     ; zCParser *
    %define     zCParser__enableParsing                   0x985DCC     ; int
    %define     zCParser__ClearInstanceRefs               0x736F00     ; void *
    %define     zCPar_SymbolTable__Insert                 0x7444C0     ; zCPar_Symbol *
    %define     zCPar_SymbolTable__GetIndex               0x744030     ; zCPar_Symbol *
    %define     zCPar_SymbolTable__GetIndex_str           0x744120     ; zSTRING const &
    %define     zCPar_SymbolTable__GetSymbol_int          0x7444A0     ; int
    %define     zCPar_SymbolTable__GetSymbol_str          0x744400     ; zSTRING const &
    %define     zCPar_SymbolTable__cur_table              0x985F70     ; zCPar_SymbolTable *
    %define     zCPar_Symbol__zCPar_Symbol                0x741C50     ; void
    %define     zCPar_Symbol__SetFlag                     0x742310     ; int
    %define     zCPar_Symbol__GetValue                    0x7425A0     ; int &, int
    %define     zCPar_Symbol__SetValue_int                0x7423F0     ; int, int
    %define     zCPar_Symbol__SetValue_str                0x742450     ; zSTRING &, int
    %define     zCPar_Symbol__SetStackPos                 0x7423E0     ; int, int
    %define     zCMusicSys_DirectMusic__musicParser       0x8C3AF4     ; zCParser *
    %define     zCSndSys_MSS__sfxParser                   0x8C442C     ; zCParser *
    %define     zCParticleFX__s_pfxParser                 0x8CAB60     ; zCParser *
    %define     oCVisualFX__fxParser                      0x8C008C     ; zCParser *
    %define     zCMenu__menuParser                        0x8C3808     ; zCParser *
    %define     zCAICamera__cameraParser                  0x8C0468     ; zCParser *
    %define     zCSoundSystem_zsound                      0x9748E4     ; zCSoundSystem *
    %define     oCGame_ogame                              0x9813DC     ; oCGame *
    %define     oCGame__GetInfoManager                    0x666190     ; void
    %define     oCMissionManager_misMan                   0x981ED8     ; oCMissionManager*
    %define     oCNpc__classDef                           0x982978     ; zCClassDef
    %define     oCItem__classDef                          0x981CC0     ; zCClassDef
    %define     zCObject__CheckInheritance                0x475A90     ; zCClassDef const *, zCClassDef const *
    %define     oCWorld__InsertInLists                    0x720E70     ; zCVob *
    %define     oCWorld__RemoveFromLists                  0x720F50     ; zCVob *
    %define     zCConsole_zcon                            0x9843A8     ; zCConsole *
    %define     zCConsole__AddEvalFunc                    0x725540     ; int (*)(zSTRING const &, zSTRING &)
    %define     zCConsole__Register                       0x7230A0     ; zSTRING const &, zSTRING const &
    %define     zERROR_zerr                               0x8BF6B8     ; zERROR *
    %define     zERROR__SearchForSpy                      0x44DEF0     ; void
    %define     zERROR__Report                            0x44C180     ; zERROR_TYPE, int, zSTRING const &, signed char, uint, int, char *, char *
    %define     zERROR__Message                           0x44D2C0     ; zSTRING const &
    %define     zERROR__Fatal                             0x44D330     ; zSTRING const &
    %define     zCOption_zoptions                         0x8BF378     ; zCOption *

    %define     zCOption__ReadString                      0x461FD0     ; zSTRING const &, char const *, char const *
    %define     zCOption__GetDirString                    0x464630     ; zTOptionPaths
    %define     zCOption__ParmValue                       0x464750     ; zSTRING const &
    %define     zCObjectFactory_zfactory                  0x8CA720     ; zCObjectFactory *
    %define     zCModelPrototype__ReadModel               0x597F60     ; zCFileBIN &
    %define     zCModelPrototype__SearchAniIndex          0x584A60     ; zSTRING const &
    %define     zCModelAni__deleting_destructor           0x57FD70     ; uint
    %define     zCArchiverFactory__CreateArchiverRead     0x5172E0     ; zFILE *, int
    %define     zCArchiverFactory_zarcFactory             0x8C60F4     ; zCArchiverFactory
    %define     zCCSManager__LibValidateOU                0x41C0B0     ; zString *
    %define     zCCSManager__LibAddOU                     0x41BD60     ; zCCSBlock *
    %define     zCCSLib___CreateNewInstance               0x418A00     ; void
    %define     zCCSLib__deleting_destructor              0x419400     ; uint
    %define     zCCSBlock__deleting_destructor            0x40D300     ; uint
    %define     zCListSort__GetNumInList                  0x6B3480     ; void
    %define     zCListSort__InsertSort                    0x721A40     ; void *
    %define     oCInfo__oCInfo                            0x6A5920     ; void
    %define     oCInfo__SetInstance                       0x6A5AB0     ; int
    %define     oCInfo__DoCheck                           0x6A5C60     ; void
    %define     oCNpc_RTTI_Type_Descriptor                0x88335C     ; TypeDescriptor


    %define     NINJA_PATCH_ARRAY                         0x88610D     ; zCArray

    %define     char_NUL                                  0x8B3914     ; 0
    %define     char_space                                0x88715C     ; ' ', 0
    %define     char_cnpc                                 0x89E958     ; 'C_NPC', 0
    %define     char_model                                0x8962E4     ; 'MODEL', 0
    %define     char_mds                                  0x888FA8     ; '.MDS', 0
    %define     char_src                                  0x8A7FA0     ; '.SRC', 0
    %define     char_dot                                  0x8811D8     ; '.', 0
    %define     char_commaSpace                           0x888008     ; ', ', 0
    %define     char_BSlash                               0x883CF8     ; '\', 0
    %define     char_doubleFSlash                         0x884C2C     ; '//', 0
    %define     char_lf                                   0x8834C0     ; 0xA, 0
    %define     char_line                                 0x8A7F24     ; ' line ( ', 0
    %define     char_spaceClosingParanthesis              0x8A7F20     ; ' )', 0
    %define     char_npc                                  0x8A7004     ; 'npc', 0
    %define     char_spawnPos                             0x8A6FF8     ; 'spawnPos', 0
    %define     char_timer                                0x8A6FF0     ; 'timer', 0
    %define     char_noOfEntries                          0x8A7008     ; 'NoOfEntries', 0
    %define     char_spawningEnabled                      0x8A6FE0     ; 'spawningEnabled', 0
    %define     char_spawnFlags                           0x8A6FD4     ; 'spawnFlags', 0
    %define     char_zStartupWindowed                     0x89C760     ; 'zStartupWindowed', 0

    %define     char_meatbug_mds                          0x8A47D0     ; 'Meatbug.mds', 0
    %define     char_redefinedIdentifier                  0x8A8410     ; 'Redefined identifier : ', 0
    %define     zSTRING_mdlBuffer                         0x8CA3F0     ; zSTRING *
    %define     zSTRING_infoClass                         0x981924     ; zSTRING
    %define     zSTRING_empty                             0x8BF658     ; zSTRING const
    %define     zOPT_SEC_GAME                             0x8BF008     ; zSTRING const

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
