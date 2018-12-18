; zCPar_Symbol *__stdcall ninja_createSymbol(const char *)
; Create symbol (const int) with specified name and add it to current symbol table (fatal error on fail)
global ninja_createSymbol
ninja_createSymbol:
        resetStackoffset
        %assign arg_1         +0x4                                         ; const char *
        %assign arg_total      0x4

        push    ecx
        push    esi

        push    0x3C                                                       ; sizeof(zCPar_Symbol)
        call    operator_new
        add     esp, 0x4
        test    eax, eax
        jz      .failed
        mov     esi, eax
        mov     ecx, eax
        call    zCPar_Symbol__zCPar_Symbol
        push    DWORD [esp+stackoffset+arg_1]
        call    zSTRING__zSTRING
    addStack 4
        push    0x1
        call    zCPar_Symbol__SetFlag
    addStack 4
        mov     eax, [ecx+zCPar_Symbol_bitfield_offset]
        or      eax, zPAR_TYPE_INT
        or      eax, 0x1                                                   ; Number of elements: 1
        mov     DWORD [ecx+zCPar_Symbol_bitfield_offset], eax

        push    ecx
        mov     ecx, DWORD [zCPar_SymbolTable__cur_table]
        call    zCPar_SymbolTable__Insert
    addStack 4
        test    eax, eax
        jz      .failedRelease
        mov     eax, esi
        jmp     .funcEnd

.failedRelease:
        push    esi
        call    operator_delete
        add     esp, 0x4

.failed:
        sub     esp, 0x14
        mov     ecx, esp
        push    NINJA_SYMBOL_FAILED
        call    zSTRING__zSTRING
    addStack 4
        push    ecx
        call    zERROR__Fatal
    addStack 4
        mov     ecx, esp
        call    zSTRING___zSTRING
        add     esp, 0x14

        xor     eax, eax
        dec     eax

.funcEnd:
        pop     esi
        pop     ecx
        ret     arg_total
    verifyStackoffset
