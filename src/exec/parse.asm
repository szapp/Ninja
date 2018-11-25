; Executive code for modified parsing

global parser_check_func
parser_check_func:
    resetStackoffset 0xA4
        lea     ecx, [esp+stackoffset-0x7C]
        push    ecx
        lea     ecx, [esi+0x10]
        call    zCPar_SymbolTable__GetSymbol_str
    addStack 4
    verifyStackoffset 0xA4

        ; Jump back
        test    eax, eax
        mov     ebp, eax
        jnz     g1g2(0x6F4980,0x79E1D1)

%if GOTHIC_BASE_VERSION == 1
        push    0x5AE
        jmp     0x6F4953
%elif GOTHIC_BASE_VERSION == 2
        push    0x3C
        call    operator_new
        jmp     0x79E1B5
%endif


global linker_replace_func
linker_replace_func:
    resetStackoffset g1g2(0xA8,0xE4)
        push    ecx                                                        ; symbol
        push    eax                                                        ; Calculated stack position
        mov     eax, [ecx+zCPar_Symbol_content_offset]
        test    eax, eax
    verifyStackoffset g1g2(0xA8,0xE4) + 2*4
        jz      .rf_back

        push    eax                                                        ; symbol->content
        push    ebp                                                        ; parser
        mov     ebp, [ecx+8]                                               ; symbol->name->ptr

        push    char_repeat
        push    ebp
        call    DWORD [ds_lstrcmpiA]
    addStack 2*4
        test    eax, eax
    verifyStackoffset g1g2(0xA8,0xE4) + 0x10
        jz      .no_rf_back
        push    char_while
        push    ebp
        call    DWORD [ds_lstrcmpiA]
    addStack 2*4
        test    eax, eax
    verifyStackoffset g1g2(0xA8,0xE4) + 0x10
        jz      .no_rf_back
        push    char_mem_label
        push    ebp
        call    DWORD [ds_lstrcmpiA]
    addStack 2*4
        test    eax, eax
    verifyStackoffset g1g2(0xA8,0xE4) + 0x10
        jz      .no_rf_back
        push    char_mem_goto
        push    ebp
        call    DWORD [ds_lstrcmpiA]
    addStack 2*4
        test    eax, eax
    verifyStackoffset g1g2(0xA8,0xE4) + 0x10
        jz      .no_rf_back

        mov     ebp, [esp+stackoffset+g1g2(-0xB8,-0xF4)]                   ; parser
        mov     ecx, [ebp+zCParser_stackpos_offset]
        mov     eax, [esp+stackoffset+g1g2(-0xB4,-0xF0)]                   ; symbol->content
        cmp     BYTE [eax+ecx*1], zPAR_TOK_RET
    verifyStackoffset g1g2(0xA8,0xE4) + 0x10
        jz      .no_rf_back

        pop     ebp                                                        ; parser
        mov     ecx, [ebp+zCParser_stackpos_offset]
        pop     eax                                                        ; symbol->content
        add     eax, ecx
        pop     ecx                                                        ; Calculated stack position
        mov     BYTE [eax], zPAR_TOK_JUMP
        mov     [eax+1], ecx
        sub     esp, 0x4
    verifyStackoffset g1g2(0xA8,0xE4) + 2*4

.rf_back:
        add     esp, 0x4
        pop     ecx
        call    zCPar_Symbol__SetStackPos
        jmp     g1g2(0x6E8269,0x7915CC)

.no_rf_back:
        add     esp, 0x18
        jmp     g1g2(0x6E8269,0x7915CC)


global parser_check_var
parser_check_var:
    resetStackoffset g1g2(0x394,0x3EC)
        mov     eax, DWORD [esi+zCParser_in_func_offset]                   ; parser->in_func->name
        test    eax, eax
        jnz     .sub_var
        mov     eax, DWORD [esi+zCParser_in_class_offset]                  ; parser->in_class->name
        test    eax, eax
        jnz     .sub_var
        lea     ecx, [esp+stackoffset+g1g2(-0x354,-0x3BC)]                 ; Variable name
        push    ecx
        mov     ecx, esi
        call    zCParser__GetSymbol_str
    addStack 4
        mov     g1g2(edi,ebp), eax
    verifyStackoffset g1g2(0x394,0x3EC)
        jmp     .check_sym

.sub_var:
        sub     esp, 0x14
        push    char_dot
        push    eax                                                        ; Prefix (function or class name)
        lea     eax, [esp+stackoffset+g1g2(-0x3A8,-0x400)]                 ; New string
        push    eax
        call    operator_StrPlusChar                                       ; __cdecl
        add     esp, 0xC
        mov     ecx, DWORD [esp+stackoffset+g1g2(-0x34C,-0x3B4)]           ; Variable name
        push    ecx
        mov     ecx, eax
        call    zSTRING__operator_plusEq
    addStack 4
        push    ecx                                                        ; Prefix.variableName
        mov     ecx, esi
        call    zCParser__GetSymbol_str
    addStack 4
        mov     g1g2(edi,ebp), eax
        lea     ecx, [esp+stackoffset+g1g2(-0x3A8,-0x400)]                 ; New string
        call    zSTRING___zSTRING
        add     esp, 0x14

.check_sym:
    verifyStackoffset g1g2(0x394,0x3EC)

%if GOTHIC_BASE_VERSION == 1
        test    edi, edi
        jnz     0x6F1903
        push    0x3BA
        jmp     0x6F18D2
%elif GOTHIC_BASE_VERSION == 2
        test    ebp, ebp
        jnz     0x79B3DC
        push    0x3C
        call    operator_new
        jmp     0x79B3BC
%endif


global parser_check_class
parser_check_class:
    resetStackoffset g1g2(0x5C,0x50)
%if GOTHIC_BASE_VERSION == 2
        pop     ecx
%endif
        lea     ecx, [esp+stackoffset-0x34]
        push    ecx
        lea     ecx, [esi+0x10]
        call    zCPar_SymbolTable__GetSymbol_str
    addStack 4
        test    eax, eax
    verifyStackoffset g1g2(0x5C,(0x50-0x4))

        ; Jump back
%if GOTHIC_BASE_VERSION == 1
        jz      .pcc_new
        add     esp, 0x10
        jnz     0x6F2B41

    .pcc_new:
        call    operator_new_len
        jmp     0x6F2B26
%elif GOTHIC_BASE_VERSION == 2
        jnz     0x79C452
        push    0x3C
        call    operator_new
        jmp     0x79C437
%endif


global parser_check_prototype
parser_check_prototype:
    resetStackoffset 0xB8
        lea     ecx, [esp+stackoffset-0x90]
        push    ecx
        lea     ecx, [esi+0x10]
        call    zCPar_SymbolTable__GetSymbol_str
    addStack 4
        test    eax, eax
    verifyStackoffset 0xB8

        ; Jump back
%if GOTHIC_BASE_VERSION == 1
        jnz     0x6F36E6
        push    0x4DF
        jmp     0x6F36B7
%elif GOTHIC_BASE_VERSION == 2
        jnz     0x79CF97
        push    0x3C
        call    operator_new
        jmp     0x79CF79
%endif


global parser_verify_version
parser_verify_version:
    resetStackoffset g1g2(0x394,0x3EC)
        push    ecx
        push    eax

        mov     ecx, [esi+zCParser_mergemode_offset]
        test    ecx, ecx
        jz      .back

        push    char_lego_symb
        mov     ecx, [ebp+0x8]                                             ; symbol->name->ptr
        push    ecx
        call    DWORD [ds_lstrcmpiA]
    addStack 2*4
        test    eax, eax
    verifyStackoffset g1g2(0x394,0x3EC) + 0x8
        jnz     .back

        push    char_lego_version
        mov     ecx, [esp+stackoffset+g1g2(-0x340,-0x394)+0x8]             ; str->ptr
        push    ecx
        call    DWORD [ds_lstrcmpiA]
    addStack 2*4
        test    eax, eax
    verifyStackoffset g1g2(0x394,0x3EC) + 0x8
        jz      .back

        sub     esp, 0x14
        mov     ecx, esp
        push    NINJA_PARSER_FAILED
        call    zSTRING__zSTRING
    addStack 4
        push    esp
        call    zERROR__Message
    addStack 4
        mov     ecx, esp
        push    0x7
        push    0x0
        call    zSTRING__Delete                                            ; Cut off author prefix
    addStack 2*4
        mov     ecx, esp
        push    0xFFFFFFFF                                                 ; -1
        push    ecx
        mov     ecx, esi
        call    zCParser__Error
    addStack 2*4
        mov     ecx, esp
        call    zSTRING___zSTRING
        add     esp, 0x14

.back:
        pop     eax
        pop     ecx
    verifyStackoffset g1g2(0x394,0x3EC)

        ; Jump back
        push    edi
        lea     ecx, [esp+stackoffset+g1g2(-0x340,-0x394)]
        jmp     g1g2(0x6F24B1,0x79BE30)


global parser_resolve_path_src
parser_resolve_path_src:
    resetStackoffset 0x250
        push    ebp
        call    ninja_resolvePath
    addStack 4
    verifyStackoffset 0x250

        ; Jump back
        sub     esp, 0x14
        test    ebp, ebp
        jmp     g1g2(0x6E5C5C,0x78EED8)


global parser_resolve_path_d
parser_resolve_path_d:
    resetStackoffset 0xC0
        push    g1g2(ebx,ebp)
        call    ninja_resolvePath
    addStack 4
    verifyStackoffset 0xC0

        ; Jump back
        push    g1g2(ebx,ebp)
        mov     [esp+stackoffset+g1g2(-0xA0,-0x74)], g1g2(ebp,ebx)
        jmp     g1g2(0x6E6659,0x78F87D)
