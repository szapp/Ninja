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

        reportToSpy "NINJA: Adding divider symbol to symbol table"
        push    0x3C                                                       ; sizeof(zCPar_Symbol)
        call    operator_new
        add     esp, 0x4
        test    eax, eax
        jz      .dividerFailed
        mov     esi, eax
        mov     ecx, eax
        call    zCPar_Symbol__zCPar_Symbol
        push    char_ndivider_symb
        call    zSTRING__zSTRING
    addStack 4
        push    0x1
        call    zCPar_Symbol__SetFlag
    addStack 4

        push    ecx
        mov     ecx, DWORD [zCPar_SymbolTable__cur_table]
        mov     eax, [ecx+0x10]
        mov     DWORD [ecx+0x1C], eax                                      ; Fix zCParser->tablesort->numInArray
        call    zCPar_SymbolTable__Insert
    addStack 4
        test    eax, eax
        jz      .dividerFailed
        push    esi
        mov     ecx, DWORD [zCPar_SymbolTable__cur_table]
        call    zCPar_SymbolTable__GetIndex
    addStack 4
        mov     DWORD [esi+zCPar_Symbol_content_offset], eax
        jmp     .dispatch

.dividerFailed:
        sub     esp, 0x14
        mov     ecx, esp
        push    NINJA_DIVIDER_FAILED
        call    zSTRING__zSTRING
    addStack 4
        push    ecx
        call    zERROR__Fatal
    addStack 4
        mov     ecx, esp
        call    zSTRING___zSTRING
        add     esp, 0x14

.dispatch:
        push    DWORD [esp+stackoffset+arg_3]
        push    char_src
        push    DWORD [esp+stackoffset+arg_2]
        call    ninja_dispatch
    addStack 3*4

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
