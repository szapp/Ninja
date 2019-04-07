; zCPar_Symbol *__stdcall ninja_createSymbol(const char *, int)
; Create symbol with specified name and add it to current symbol table (fatal error on fail)
global ninja_createSymbol
ninja_createSymbol:
        resetStackoffset
        %assign arg_1         +0x4                                         ; const char *
        %assign arg_2         +0x8                                         ; int
        %assign arg_total      0x8

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
        mov     eax, DWORD [esp+stackoffset+arg_2]                         ; Type, flags, number of elements, ...
        mov     DWORD [ecx+zCPar_Symbol_bitfield_offset], eax

        push    ecx
        mov     ecx, DWORD [zCPar_SymbolTable__cur_table]
        call    zCPar_SymbolTable__Insert
    addStack 4
        test    eax, eax
        jnz     .funcEnd

.failedRelease:
        push    esi
        call    operator_delete
        add     esp, 0x4

.failed:
        sub     esp, 0x14
        mov     ecx, esp
        push    DWORD [esp+stackoffset+arg_1]
        call    zSTRING__zSTRING
    addStack 4
        push    ecx
        mov     ecx, DWORD [zCPar_SymbolTable__cur_table]
        call    zCPar_SymbolTable__GetSymbol_str
    addStack 4
        mov     esi, eax
        test    esi, esi
        jnz     .failedCleanup

        mov     ecx, esp
        call    zSTRING___zSTRING
        mov     ecx, esp
        push    NINJA_SYMBOL_FAILED
        call    zSTRING__zSTRING
    addStack 4
        push    DWORD [esp+stackoffset+arg_1]
        call    zSTRING__operator_plusEq
    addStack 4
        push    ecx
        call    zERROR__Fatal
    addStack 4
        xor     esi, esi

.failedCleanup:
        mov     ecx, esp
        call    zSTRING___zSTRING
        add     esp, 0x14

.funcEnd:
        mov     eax, esi
        pop     esi
        pop     ecx
        ret     arg_total
    verifyStackoffset
