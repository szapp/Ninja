; Executive code for modified parsing

global parser_check_func
parser_check_func:
    resetStackoffset 0xA4
        xor     eax, eax
        mov     ecx, DWORD [zCParser__enableParsing]                       ; Check if wrapped by Ninja
        cmp     ecx, 0x2A
        jnz     .back

        lea     ecx, [esp+stackoffset-0x7C]
        push    ecx
        lea     ecx, [esi+0x10]
        call    zCPar_SymbolTable__GetSymbol_str
    addStack 4
    verifyStackoffset 0xA4

.back:
        test    eax, eax
        mov     ebp, eax
        jnz     g1g2(0x6F4980,0x72E610,0x73E791,0x79E1D1)

        push    g1g2(0x5AE, 0x5AE, 0x3C, 0x3C)
%if GOTHIC_BASE_VERSION == 130 || GOTHIC_BASE_VERSION == 2
        call    operator_new
%endif
        jmp     g1g2(0x6F494E,0x72E5DE,0x73E76E,0x79E1AE) + 5


global linker_replace_func
linker_replace_func:
    resetStackoffset g1g2(0xA8,0xA8,0xE4,0xE4)
        %assign var_symb_content  0x4
        %assign var_parser        0x0
        push    edi
        push    ecx                                                        ; symbol
        push    eax                                                        ; Calculated stack position

        mov     eax, DWORD [zCParser__enableParsing]                       ; Check if wrapped by Ninja
        cmp     eax, 0x2A
        jnz     .rf_back

        mov     eax, [ecx+zCPar_Symbol_content_offset]
        test    eax, eax
    verifyStackoffset g1g2(0xA8,0xA8,0xE4,0xE4) + 0xC
        jz      .rf_back

        push    eax                                                        ; symbol->content
        push    ebp                                                        ; parser
        mov     ebp, [ecx+8]                                               ; symbol->name->ptr

        mov     edi, keep_func_symbol_start

.preserveSymbols:
        cmp     edi, keep_func_symbol_end
        jg      .checkEmpty
        push    edi
        push    ebp
        call    DWORD [ds_lstrcmpiA]
    addStack 2*4
        test    eax, eax
    verifyStackoffset g1g2(0xA8,0xA8,0xE4,0xE4) + 0x14
        jz      .no_rf_back
        push    edi
        call    DWORD [ds_lstrlenA]
    addStack 4
        add     edi, eax
        inc     edi
        jmp     .preserveSymbols

.checkEmpty:
        mov     ecx, [esp+var_parser]                                      ; parser
        mov     ecx, [ecx+zCParser_stackpos_offset]
        mov     eax, [esp+var_symb_content]                                ; symbol->content
        cmp     BYTE [eax+ecx], zPAR_TOK_RET
    verifyStackoffset g1g2(0xA8,0xA8,0xE4,0xE4) + 0x14
        jz      .no_rf_back

        pop     ebp                                                        ; parser
        mov     ecx, [ebp+zCParser_stackpos_offset]
        pop     eax                                                        ; symbol->content
        add     eax, ecx
        pop     ecx                                                        ; Calculated stack position
        mov     BYTE [eax], zPAR_TOK_JUMP
        mov     [eax+1], ecx
        sub     esp, 0x4
    verifyStackoffset g1g2(0xA8,0xA8,0xE4,0xE4) + 0xC

.rf_back:
        add     esp, 0x4
        pop     ecx
        pop     edi
        call    zCPar_Symbol__SetStackPos
        jmp     g1g2(0x6E8269,0x7211EB,0x73126D,0x7915CC)

.no_rf_back:
        sub     esp, 0x14
        mov     ecx, esp
        push    NINJA_SKIPPING
        call    zSTRING__zSTRING
    addStack 4
        push    ebp
        call    zSTRING__operator_plusEq
    addStack 4
        push    ecx
        call    zERROR__Message
    addStack 4
        mov     ecx, esp
        call    zSTRING___zSTRING
        add     esp, 0x14
        pop     ebp
        add     esp, 0x14
        pop     edi
        jmp     g1g2(0x6E8269,0x7211EB,0x73126D,0x7915CC)


global parser_check_var
parser_check_var:
    resetStackoffset g1g2(0x394,0x388,0x3EC,0x3EC)
        xor     g1g2(edi,ebx,ebp,ebp), g1g2(edi,ebx,ebp,ebp)
        mov     eax, DWORD [zCParser__enableParsing]                       ; Check if wrapped by Ninja
        cmp     eax, 0x2A
        jnz     .check_sym

        mov     eax, DWORD [esi+zCParser_in_func_offset]                   ; parser->in_func->name
        test    eax, eax
        jnz     .sub_var
        mov     eax, DWORD [esi+zCParser_in_class_offset]                  ; parser->in_class->name
        test    eax, eax
        jnz     .sub_var
        lea     ecx, [esp+stackoffset+g1g2(-0x354,-0x40-0x4,-0x3BC,-0x3BC)] ; Variable name
        push    ecx
        mov     ecx, esi
        call    zCParser__GetSymbol_str
    addStack 4
        mov     g1g2(edi,ebx,ebp,ebp), eax
    verifyStackoffset g1g2(0x394,0x388,0x3EC,0x3EC)
        jmp     .check_sym

.sub_var:
        sub     esp, 0x14
        push    char_dot
        push    eax                                                        ; Prefix (function or class name)
        lea     eax, [esp+stackoffset+g1g2(-0x3A8,-0x39C,-0x400,-0x400)]   ; New string
        push    eax
        call    operator_StrPlusChar                                       ; __cdecl
        add     esp, 0xC
        mov     ecx, DWORD [esp+stackoffset+g1g2(-0x34C,-0x38-0x4,-0x3B4,-0x3B4)] ; Variable name
        push    ecx
        mov     ecx, eax
        call    zSTRING__operator_plusEq
    addStack 4
        push    ecx                                                        ; Prefix.variableName
        mov     ecx, esi
        call    zCParser__GetSymbol_str
    addStack 4
        mov     g1g2(edi,ebx,ebp,ebp), eax
        lea     ecx, [esp+stackoffset+g1g2(-0x3A8,-0x39C,-0x400,-0x400)]   ; New string
        call    zSTRING___zSTRING
        add     esp, 0x14

.check_sym:
    verifyStackoffset g1g2(0x394,0x388,0x3EC,0x3EC)

        test    g1g2(edi,ebx,ebp,ebp), g1g2(edi,ebx,ebp,ebp)
        jnz     g1g2(0x6F1903, 0x72B33B, 0x73B99C, 0x79B3DC)
        push    g1g2(0x3BA, 0x3BA, 0x3C, 0x3C)
%if GOTHIC_BASE_VERSION == 130 || GOTHIC_BASE_VERSION == 2
        call    operator_new
%endif
        jmp     g1g2(0x6F18CD,0x72B30A,0x73B975,0x79B3B5) + 5


global parser_check_class
parser_check_class:
    resetStackoffset g1g2(0x5C,0x60,0x50,0x50)
%if GOTHIC_BASE_VERSION == 130 || GOTHIC_BASE_VERSION == 2
        pop     ecx
%endif
        mov     ecx, DWORD [zCParser__enableParsing]                       ; Check if wrapped by Ninja
        cmp     ecx, 0x2A
        jnz     .pcc_new

        lea     ecx, [esp+stackoffset-0x34]
        push    ecx
        lea     ecx, [esi+0x10]
        call    zCPar_SymbolTable__GetSymbol_str
    addStack 4
        test    eax, eax
    verifyStackoffset g1g2(0x5C,0x60,(0x50-0x4),(0x50-0x4))

        ; Jump back
%if GOTHIC_BASE_VERSION == 1 || GOTHIC_BASE_VERSION == 112
        jz      .pcc_new
        add     esp, 0x10
%endif
        jnz     g1g2(0x6F2B41,0x72C565,0x73CA12,0x79C452)

    .pcc_new:
%if GOTHIC_BASE_VERSION == 1 || GOTHIC_BASE_VERSION == 112
        call    operator_new_len
%elif GOTHIC_BASE_VERSION == 130 || GOTHIC_BASE_VERSION == 2
        push    0x3C
        call    operator_new
%endif
        jmp     g1g2(0x6F2B21,0x72C545,0x73C9F2,0x79C432) + 5


global parser_check_prototype
parser_check_prototype:
    resetStackoffset 0xB8
        xor     eax, eax
        mov     ecx, DWORD [zCParser__enableParsing]                       ; Check if wrapped by Ninja
        cmp     ecx, 0x2A
        jnz     .back

        lea     ecx, [esp+stackoffset-0x90]
        push    ecx
        lea     ecx, [esi+0x10]
        call    zCPar_SymbolTable__GetSymbol_str
    addStack 4

.back:
        test    eax, eax
    verifyStackoffset 0xB8

        jnz     g1g2(0x6F36E6,0x72D21E,0x73D557,0x79CF97)
%if GOTHIC_BASE_VERSION == 1 || GOTHIC_BASE_VERSION == 112
        push    0x4DF
%elif GOTHIC_BASE_VERSION == 130 || GOTHIC_BASE_VERSION == 2
        push    0x3C
        call    operator_new
%endif
        jmp     g1g2(0x6F36B2,0x72D1EA,0x73D532,0x79CF72) + 5


global parser_verify_ikarus_version
parser_verify_ikarus_version:
    resetStackoffset g1g2(0x398,0x38C,0x3F0,0x3F0)
        %assign var_newvalue  0x08
        push    eax
        push    ebx
        push    ebp
%if GOTHIC_BASE_VERSION == 112
        mov     ebp, ebx
%endif

        mov     ecx, DWORD [zCParser__enableParsing]                       ; Check if wrapped by Ninja
        cmp     ecx, 0x2A
        jnz     .backClean

        mov     ecx, [esi+zCParser_mergemode_offset]
        test    ecx, ecx
    verifyStackoffset g1g2(0x398,0x38C,0x3F0,0x3F0) + 0xC
        jz      .backClean

        mov     ebx, keep_int_symbol_start

.preserveSymbols:
        cmp     ebx, char_modname_symb
        jg      .verifyIkarusVersion
        push    DWORD [ebp+0x8]                                            ; symbol->name->ptr
        push    ebx
        call    DWORD [ds_lstrcmpiA]
    addStack 2*4
        test    eax, eax
    verifyStackoffset g1g2(0x398,0x38C,0x3F0,0x3F0) + 0xC
        jz      .skip
        push    ebx
        call    DWORD [ds_lstrlenA]
    addStack 4
        add     ebx, eax
        inc     ebx
        jmp     .preserveSymbols

.verifyIkarusVersion:
        mov     ebx, DWORD [esp+var_newvalue]                              ; New value of symbol (content)
        push    char_ikarus_symb
        push    DWORD [ebp+0x8]                                            ; symbol->name->ptr
        call    DWORD [ds_lstrcmpiA]
    addStack 2*4
        test    eax, eax
    verifyStackoffset g1g2(0x398,0x38C,0x3F0,0x3F0) + 0xC
        jnz     .back

        reportToSpy NINJA_VERIFY_VERSION
        cmp     ebx, IKARUS_VERSION
        jge     .verifyFilePath

        sub     esp, 0x14
        mov     ecx, esp
        push    NINJA_PARSER_FAILED
        call    zSTRING__zSTRING
    addStack 4
        push    char_ikarus
        call    zSTRING__operator_plusEq
    addStack 4
        push    NINJA_PARSER_FAILED_2
        call    zSTRING__operator_plusEq
    addStack 4
        push    eax
        call    zERROR__Fatal
    addStack 4
        ; mov     ecx, esp                                                 ; Never reached: Safe some space
        ; call    zSTRING___zSTRING
        add     esp, 0x14
    verifyStackoffset g1g2(0x398,0x38C,0x3F0,0x3F0) + 0xC
        jmp     .back

.verifyFilePath:
        push    NINJA_PATH_IKARUS
        push    esi
        call    ninja_scriptPathInvalid
    addStack 2*4
        test    eax, eax
        jnz     .back

.compareVersions:
        sub     esp, 0x4
        mov     eax, esp
        push    edi
        push    eax
        mov     ecx, ebp
        call    zCPar_Symbol__GetValue
    addStack 2*4
        pop     eax
        test    eax, eax
    verifyStackoffset g1g2(0x398,0x38C,0x3F0,0x3F0) + 0xC
        jz      .back

        reportToSpy NINJA_COMPARE_VERSIONS
        cmp     ebx, eax
    verifyStackoffset g1g2(0x398,0x38C,0x3F0,0x3F0) + 0xC
        jge     .back

        push    edi
        mov     edi, eax
        sub     esp, 0x4
        push    0x200
        call    operator_new
        add     esp, 0x4
        push    0x1FF
        push    0x20
        push    eax
        call    _memset
        add     esp, 0xC
        mov     BYTE [eax+0x1FF], 0x0                                      ; Null-terminated
        sub     esp, 0x14
        mov     ecx, esp
        push    eax
        call    zSTRING__zSTRING
    addStack 4
        push    ebx
        push    edi
        push    char_ikarus
        push    NINJA_VERSION_INVALID
        push    ecx
        call    zSTRING__Sprintf
        add     esp, 0x14
        push    esp
        call    zERROR__Fatal
    addStack 4
        ; mov     ecx, esp                                                 ; Never reached: Safe some space
        ; call    zSTRING___zSTRING
        add     esp, 0x14
        push    esp
        call    operator_delete
        add     esp, 0x8
        pop     edi

.skip:
        mov     ebx, DWORD [esp+var_newvalue]                              ; New value of symbol (content)
        push    ebp
        mov     ecx, esi
        call    zCParser__GetIndex                                         ; Check if new symbol or overwriting
    addStack 4
        mov     ecx, [esi+0x20]                                            ; zCParser->table->numInArray
        dec     ecx
        cmp     ecx, eax
        jz      .back
        sub     esp, 0x14
        mov     ecx, esp
        push    NINJA_SKIPPING
        call    zSTRING__zSTRING
    addStack 4
        push    DWORD [ebp+0x8]
        call    zSTRING__operator_plusEq
    addStack 4
        push    ecx
        call    zERROR__Message
    addStack 4
        mov     ecx, esp
        call    zSTRING___zSTRING
        add     esp, 0x10                                                  ; Leave 0x4 on esp
        mov     eax, esp                                                   ; Overwrite new value with old value
        push    edi
        push    eax
        mov     ecx, ebp
        call    zCPar_Symbol__GetValue
    addStack 2*4
        pop     eax
    verifyStackoffset g1g2(0x398,0x38C,0x3F0,0x3F0) + 0xC
        jmp     .backClean

.back:
        mov     eax, ebx

.backClean:
        mov     ecx, ebp
        pop     ebp
        pop     ebx
        add     esp, 0x4
    verifyStackoffset g1g2(0x398,0x38C,0x3F0,0x3F0)

        ; Jump back
        push    eax
        call    zCPar_Symbol__SetValue_int
        jmp     g1g2(0x6F2451,0x72BEA6,0x73C390,0x79BDD0) + 8


global parser_verify_lego_version
parser_verify_lego_version:
    resetStackoffset g1g2(0x394,0x388,0x3EC,0x3EC)
        push    eax
        push    edx
        push    ebx
        push    ebp
%if GOTHIC_BASE_VERSION == 112
        mov     ebp, ebx
%endif

        mov     ecx, DWORD [zCParser__enableParsing]                       ; Check if wrapped by Ninja
        cmp     ecx, 0x2A
        jnz     .back

        mov     ecx, [esi+zCParser_mergemode_offset]
        test    ecx, ecx
    verifyStackoffset g1g2(0x394,0x388,0x3EC,0x3EC) + 0x10
        jz      .back

        mov     ebx, keep_string_symbol_start

.preserveSymbols:
        cmp     ebx, keep_string_symbol_end
        jg      .verifyLeGoVersion
        push    DWORD [ebp+0x8]                                            ; symbol->name->ptr
        push    ebx
        call    DWORD [ds_lstrcmpiA]
    addStack 2*4
        test    eax, eax
    verifyStackoffset g1g2(0x394,0x388,0x3EC,0x3EC) + 0x10
        jz      .skip
        push    ebx
        call    DWORD [ds_lstrlenA]
    addStack 4
        add     ebx, eax
        inc     ebx
        jmp     .preserveSymbols

.verifyLeGoVersion:
        push    char_lego_symb
        push    DWORD [ebp+0x8]                                            ; symbol->name->ptr
        call    DWORD [ds_lstrcmpiA]
    addStack 2*4
        test    eax, eax
    verifyStackoffset g1g2(0x394,0x388,0x3EC,0x3EC) + 0x10
        jnz     .back

        reportToSpy NINJA_VERIFY_VERSION
        mov     ecx, [esp+stackoffset+g1g2(-0x340,-0x58-0x4,-0x394,-0x394)+0x8] ; str->ptr
        push    ecx
        call    DWORD [ds_lstrlenA]
    addStack 4
        mov     ecx, [esp+stackoffset+g1g2(-0x340,-0x58-0x4,-0x394,-0x394)+0x8] ; str->ptr
        sub     eax, 0x5                                                   ; Expects "...-Nxxx"
        add     ecx, eax
        cmp     BYTE [ecx], '-'
        jnz     .invalidVersion
        inc     ecx
        cmp     BYTE [ecx], 'N'
        jnz     .invalidVersion
        inc     ecx
        push    ecx
        call    _atol
        add     esp, 0x4
        cmp     eax, LEGO_N_VERSION
        jge     .verifyFilePath

.invalidVersion:
        sub     esp, 0x14
        mov     ecx, esp
        push    NINJA_PARSER_FAILED
        call    zSTRING__zSTRING
    addStack 4
        push    char_lego
        call    zSTRING__operator_plusEq
    addStack 4
        push    NINJA_PARSER_FAILED_2
        call    zSTRING__operator_plusEq
    addStack 4
        push    eax
        call    zERROR__Fatal
    addStack 4
        ; mov     ecx, esp                                                 ; Never reached: Safe some space
        ; call    zSTRING___zSTRING
        add     esp, 0x14
    verifyStackoffset g1g2(0x394,0x388,0x3EC,0x3EC) + 0x10
        jmp     .back

.verifyFilePath:
        push    NINJA_PATH_LEGO
        push    esi
        call    ninja_scriptPathInvalid
    addStack 2*4
        test    eax, eax
    verifyStackoffset g1g2(0x394,0x388,0x3EC,0x3EC) + 0x10
        jnz     .back

.compareVersions:
        mov     eax, [ebp+zCPar_Symbol_content_offset]
        lea     edx, [eax+edi*0x4]
        mov     eax, [edx+0x8]
        test    eax, eax
    verifyStackoffset g1g2(0x394,0x388,0x3EC,0x3EC) + 0x10
        jz      .back

        reportToSpy NINJA_COMPARE_VERSIONS
        push    DWORD [edx+0x8]
        call    ninja_parseVersionString
    addStack 4
        test    eax, eax
    verifyStackoffset g1g2(0x394,0x388,0x3EC,0x3EC) + 0x10
        jl      .back
        mov     ebx, eax
        mov     eax, [esp+stackoffset+g1g2(-0x340,-0x58-0x4,-0x394,-0x394)+0x8] ; str->ptr
        push    eax
        call    ninja_parseVersionString
    addStack 4
        cmp     eax, ebx
    verifyStackoffset g1g2(0x394,0x388,0x3EC,0x3EC) + 0x10
        jge     .back

        push    edi
        mov     edi, eax
        sub     esp, 0x4
        push    0x200
        call    operator_new
        add     esp, 0x4
        push    0x1FF
        push    0x20
        push    eax
        call    _memset
        add     esp, 0xC
        mov     BYTE [eax+0x1FF], 0x0                                      ; Null-terminated
        sub     esp, 0x14
        mov     ecx, esp
        push    eax
        call    zSTRING__zSTRING
    addStack 4
        push    edi
        push    ebx
        push    char_lego
        push    NINJA_VERSION_INVALID
        push    ecx
        call    zSTRING__Sprintf
        add     esp, 0x14
        push    esp
        call    zERROR__Fatal
    addStack 4
        ; mov     ecx, esp                                                 ; Never reached: Safe some space
        ; call    zSTRING___zSTRING
        add     esp, 0x14
        ; push    esp                                                      ; Never reached: Safe some space
        ; call    operator_delete
        ; add     esp, 0x4
        add     esp, 0x4
        pop     edi

.skip:
        mov     ecx, [ebp+zCPar_Symbol_content_offset]
        lea     ecx, [ecx+edi*0x4]
        mov     eax, [ecx+0x8]
        test    eax, eax
        jz      .back
        sub     esp, 0x14
        mov     ecx, esp
        push    NINJA_SKIPPING
        call    zSTRING__zSTRING
    addStack 4
        push    DWORD [ebp+0x8]                                            ; symbol->name->ptr
        call    zSTRING__operator_plusEq
    addStack 4
        push    ecx
        call    zERROR__Message
    addStack 4
        mov     ecx, esp
        call    zSTRING___zSTRING
        add     esp, 0x14
        mov     ecx, [ebp+zCPar_Symbol_content_offset]
        lea     ecx, [ecx+edi*0x4]
        jmp     .backClean

.back:
        lea     ecx, [esp+stackoffset+g1g2(-0x340,-0x58-0x4,-0x394,-0x394)]

.backClean:
        pop     ebp
        pop     ebx
        pop     edx
        pop     eax
    verifyStackoffset g1g2(0x394,0x388,0x3EC,0x3EC)

        ; Jump back
        push    edi
%if GOTHIC_BASE_VERSION == 112
        push    ecx
%endif
        jmp     g1g2(0x6F24AC,0x72BF00,0x73C3EB,0x79BE2B) + 5


global parser_resolve_path_src
parser_resolve_path_src:
    resetStackoffset 0x250
        push    DWORD [ecx+0x8]
        push    char_ikarus
        call    DWORD [ds_lstrcmpiA]
    addStack 2*4
        test    eax, eax
        jnz     .checkLeGo
        lea     ecx, [esp+stackoffset-0x138]                               ; Stack variable later expecting a zString
        push    NINJA_PATH_IKARUSSRC
        call    zSTRING__zSTRING
    addStack 4
        jmp     .checkScripts
    verifyStackoffset 0x250

.checkLeGo:
        push    DWORD [esp+stackoffset-0x240+0x8]                          ; str.ptr
        push    char_lego
        call    DWORD [ds_lstrcmpiA]
    addStack 2*4
        test    eax, eax
        jnz     .back
        lea     ecx, [esp+stackoffset-0x138]                               ; Stack variable later expecting a zString
        push    NINJA_PATH_LEGOSRC
        call    zSTRING__zSTRING
    addStack 4
    verifyStackoffset 0x250

.checkScripts:
        push    eax
        call    zFILE_VDFS__LockCriticalSection
        push    VDF_VIRTUAL | VDF_PHYSICAL | VDF_PHYSICALFIRST
        push    NINJA_PATH_IKARUS
        call    DWORD [ds_vdf_fexists]
        add     esp, 0x8
        push    eax
        call    zFILE_VDFS__UnlockCriticalSection
        pop     eax
        test    eax, eax
        pop     eax
        jg      g1g2(0x6E6100,0x71ECCD,0x72F940,0x78F380)                  ; Successfully return

        sub     esp, 0x14
        mov     ecx, esp
        push    NINJA_MISSING_TOOLKIT
        call    zSTRING__zSTRING
    addStack 4
        push    ecx
        call    zERROR__Fatal
    addStack 4
        ; mov     ecx, esp                                                 ; Never reached: Safe some space
        ; call    zSTRING___zSTRING
        add     esp, 0x14

.back:
        ; Jump back
        lea     ecx, [esp+stackoffset-0x240]
        call    zSTRING__Upper
        jmp     g1g2(0x6E5F19,0x71EAB5,0x72F759,0x78F199) + 5
