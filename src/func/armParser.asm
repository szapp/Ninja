; void __stdcall ninja_armParser(zCParser *, char *, void (__stdcall *)(char *))
; Prepare parser for injection
global ninja_armParser
ninja_armParser:
        resetStackoffset
        %assign arg_1      +0x4                                            ; zCParser *
        %assign arg_2      +0x8                                            ; char *
        %assign arg_3      +0xC                                            ; void (__stdcall *)(char *)
        %assign arg_total   0xC

        pusha

        mov     eax, DWORD [zCParser__ParseBlock]                          ; Workaround for reckless "ParserExtender"
        push    eax
        mov     eax, DWORD [zCParser__ParseBlock+4]
        push    eax
        mov     DWORD [zCParser__ParseBlock], g1g2(0xC868FF6A,0x1868FF6A,0x2868FF6A,0x0868FF6A)
        mov     DWORD [zCParser__ParseBlock+4], g1g2(0x64007C4A,0x6400807C,0x64008159,0x640082A6)

        mov     eax, DWORD [zCParser__cur_parser]
        push    eax
        mov     eax, DWORD [zCPar_SymbolTable__cur_table]
        push    eax

        mov     esi, [esp+stackoffset+arg_1]
        mov     DWORD [zCParser__cur_parser], esi
        add     esi, zCParser_table_offset
        mov     DWORD [zCPar_SymbolTable__cur_table], esi

        add     esi, zCParser_datsave_offset-zCParser_table_offset
        mov     eax, [esi]
        push    eax

        mov     eax, DWORD [zCParser__enableParsing]
        push    eax

        xor     eax, eax
        mov     [esi], eax                                                 ; parser->datsave = 0
        mov     [esi-zCParser_datsave_offset+zCParser_lastsym_offset], eax ; parser->lastsym = 0

        mov     eax, 0x2A
        mov     DWORD [zCParser__enableParsing], eax

        mov     ecx, DWORD [zCPar_SymbolTable__cur_table]
        mov     eax, [ecx+0x10]
        mov     DWORD [ecx+0x1C], eax                                      ; Fix zCParser->tablesort->numInArray

        reportToSpy NINJA_SYMBOL_ADD_DIV
        push    zPAR_TYPE_INSTANCE
        push    char_ndivider_symb
        call    ninja_createSymbol
    addStack 2*4

        cmp     DWORD [esp+stackoffset+arg_2], NINJA_PATH_CONTENT
        jnz     .adjustStringCount

        sub     esp, 0x14                                                  ; Rename _while/_repeat to while/repeat
        mov     ecx, esp
        call    zSTRING__zSTRING_void

        xor     edi, edi
        dec     edi

.checkunderscore:
        inc     edi
        cmp     edi, 0x1
        jg      .sortTable

        mov     ecx, esp
        mov     eax, edi
        imul    eax, char__repeat_len
        add     eax, char__repeat
        push    eax
        call    zSTRING__operator_eq
    addStack 4
        push    ecx
        mov     ecx, [esp+stackoffset+arg_1]
        call    zCParser__GetSymbol_str
    addStack 4
        test    eax, eax
        jz      .checkunderscore
        mov     esi, eax

        mov     ecx, esp                                                   ; Check if while already exists
        mov     edx, edi
        imul    edx, char_repeat_len
        add     edx, char_repeat
        push    edx
        call    zSTRING__operator_eq
    addStack 4
        push    ecx
        mov     ecx, [esp+stackoffset+arg_1]
        call    zCParser__GetSymbol_str
    addStack 4
        test    eax, eax
        jnz     .checkunderscore

        reportToSpy NINJA_RENAME_SYMB
        mov     ecx, esi
        push    edx
        call    zSTRING__operator_eq
    addStack 4
        jmp     .checkunderscore

.sortTable:
        add     esp, 0x14

        mov     ecx, DWORD [zCPar_SymbolTable__cur_table]                  ; Resort zCParser.symtab.tablesort
        add     ecx, 0x14
        call    zCArraySort_int___QuickSort

        reportToSpy NINJA_SYMBOL_ADD_HLP
        push    zPAR_TYPE_INT | zPAR_FLAG_CONST | 0x1
        push    char_nversion_symb
        call    ninja_createSymbol
    addStack 2*4
        %substr .nversion1 NINJA_VERSION 2,1                               ; Convert version string into integer
        %substr .nversion2 NINJA_VERSION 4,1
        %substr .nversion3 NINJA_VERSION 6,1
        %substr .nversion4 NINJA_VERSION 7,1
        %assign .nversion (.nversion1-48)*1000 + (.nversion2-48)*100 + (.nversion3-48)*10 + (.nversion4-48)
        push    0x0
        push    .nversion
        mov     ecx, eax
        call    zCPar_Symbol__SetValue_int
    addStack 2*4

        push    zPAR_TYPE_INT | zPAR_FLAG_CONST | 0x1
        push    char_narray_symb
        call    ninja_createSymbol
    addStack 2*4
        push    0x0
        push    NINJA_PATCH_ARRAY
        mov     ecx, eax
        call    zCPar_Symbol__SetValue_int
    addStack 2*4

        push    zPAR_TYPE_STRING | zPAR_FLAG_CONST | 0x1
        push    char_modname_symb
        call    ninja_createSymbol
    addStack 2*4
        mov     esi, eax
        sub     esp, 0x14
        mov     ecx, esp
        push    zOPT_SEC_GAME
        push    ecx
        mov     ecx, DWORD [zCOption_zoptions]
        call    zCOption__ParmValue
    addStack 2*4
        mov     ecx, [eax+0x8]
        test    ecx, ecx
        jz      .modnameDone
        mov     ecx, esp
        push    0x4
        call    zSTRING__DeleteRight                                       ; Trim trailing '.INI'
    addStack 4

        mov     ecx, esp
        push    0x0
        push    ecx
        mov     ecx, esi
        call    zCPar_Symbol__SetValue_str
    addStack 2*4

.modnameDone:
        mov     ecx, esp
        call    zSTRING___zSTRING
        add     esp, 0x14

.adjustStringCount:
        xor     esi, esi
        mov     ecx, DWORD [zCPar_SymbolTable__cur_table]                  ; Attempt to adjust zCParser.stringcount
        add     ecx, 0x14
        mov     eax, [ecx+zCArraySort.numInArray]
        dec     eax                                                        ; -1 (last element)
        dec     eax                                                        ; -1 (skip instance_help)
        cmp     eax, esi
        jle     .failedStringCount

        mov     ecx, [ecx+zCArraySort.array]                               ; Get symbol index
        mov     ecx, [ecx+0x4*eax]
        cmp     ecx, esi
        jle     .failedStringCount

        push    ecx                                                        ; Get symbol by index
        mov     ecx, DWORD [zCPar_SymbolTable__cur_table]
        call    zCPar_SymbolTable__GetSymbol_int
    addStack 4
        cmp     eax, esi
        jz      .failedStringCount

        mov     ecx, [eax+0x8]                                             ; Compare first character of symbol name
        cmp     ecx, esi
        jz      .failedStringCount
        cmp     BYTE [ecx], 0xFF
        jnz     .failedStringCount
        inc     ecx
        mov     edi, ecx
        push    ecx
        call    _atol                                                      ; Attempt to convert to integer
        add     esp, 0x4
        inc     eax                                                        ; Index of latest string + 1

        mov     esi, DWORD [zCParser__cur_parser]                          ; Compare to zCParser.stringcount
        mov     ecx, [esi+zCParser_stringcount_offset]
        cmp     ecx, eax
        jg      .failedStringCount
        mov     [esi+zCParser_stringcount_offset], eax                     ; Update zCParser.stringcount

        sub     esp, 0x14                                                  ; Send information to zSpy
        mov     ecx, esp
        push    NINJA_STRINGCOUNT_APPLY
        call    zSTRING__zSTRING
    addStack 4
        push    edi
        call    zSTRING__operator_plusEq
    addStack 4
        push    ecx
        call    zERROR__Message
    addStack 4
        mov     ecx, esp
        call    zSTRING___zSTRING
        add     esp, 0x14
        jmp     .dispatch

.failedStringCount:
    reportToSpy NINJA_STRINGCOUNT_FAILED

.dispatch:
        push    DWORD [esp+stackoffset+arg_3]
        push    char_src
        push    DWORD [esp+stackoffset+arg_2]
        call    ninja_dispatch
    addStack 3*4

        reportToSpy NINJA_SYMBOL_ADD_DIV
        push    zPAR_TYPE_INSTANCE
        push    char_ndivider2_symb
        call    ninja_createSymbol
    addStack 2*4

        pop     eax
        mov     DWORD [zCParser__enableParsing], eax

        pop     eax
        mov     esi, [esp+stackoffset+arg_1]
        mov     DWORD [esi+zCParser_datsave_offset], eax                   ; Restore parser->datsave

        pop     esi
        mov     DWORD [zCPar_SymbolTable__cur_table], esi
        pop     esi
        mov     DWORD [zCParser__cur_parser], esi

        pop     esi                                                        ; Workaround for reckless "ParserExtender"
        mov     DWORD [zCParser__ParseBlock+4], esi
        pop     esi
        mov     DWORD [zCParser__ParseBlock], esi

        popa
        ret     arg_total
    verifyStackoffset
