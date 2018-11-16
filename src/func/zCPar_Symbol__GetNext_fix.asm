; zCPar_Symbol * __thiscall zCPar_Symbol::GetNext(void)
; Re-implement the faulty zCPar_Symbol::GetNext
global zCPar_Symbol__GetNext_fix
zCPar_Symbol__GetNext_fix:
        resetStackoffset

        pusha
        push    ecx
        mov     esi, DWORD [zCPar_SymbolTable__cur_table]

        times 3 nop

        mov     ecx, esi
        call    zCPar_SymbolTable__GetIndex
    addStack 4
        inc     eax
        test    eax, eax
        jz      .symbInv
        mov     ecx, esi
        push    eax
        call    zCPar_SymbolTable__GetSymbol_int
    addStack 4

.symbInv:
        mov     [esp+0x1C], eax
        popa
        ret
    verifyStackoffset
