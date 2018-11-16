; void __stdcall ninja_inject(zCParser *,char *,void (__stdcall *)(char *))
; Inject Daedalus symbols
global ninja_inject
ninja_inject:
        resetStackoffset
        %assign arg_1      +0x4                                            ; zCParser *
        %assign arg_2      +0x8                                            ; char *
        %assign arg_3      +0xC                                            ; void (__stdcall *)(char *)
        %assign arg_total   0xC

        pusha

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

        inc     eax
        mov     DWORD [zCParser__enableParsing], eax

        push    DWORD [esp+stackoffset+arg_3]
        push    DWORD [esp+stackoffset+arg_2]
        call    ninja_findVdfSrc
    addStack 8

        pop     eax
        mov     DWORD [zCParser__enableParsing], eax

        pop     eax
        mov     esi, [esp+stackoffset+arg_1]
        mov     DWORD [esi+zCParser_datsave_offset], eax                   ; Restore parser->datsave

        pop     esi
        mov     DWORD [zCPar_SymbolTable__cur_table], esi
        pop     esi
        mov     DWORD [zCParser__cur_parser], esi

        popa
        ret     arg_total
    verifyStackoffset
