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

        mov     ecx, DWORD [zCPar_SymbolTable__cur_table]
        mov     eax, [ecx+0x10]
        mov     DWORD [ecx+0x1C], eax                                      ; Fix zCParser->tablesort->numInArray

        reportToSpy "NINJA: Adding divider symbol to symbol table"
        push    char_ndivider_symb
        call    ninja_createSymbol
    addStack 4
        mov     ecx, DWORD [zCPar_SymbolTable__cur_table]
        mov     ecx, [ecx+0x10]                                            ; zCPar_SymbolTable->table->numInArray
        dec     ecx
        mov     DWORD [eax+zCPar_Symbol_content_offset], ecx

        cmp     DWORD [esp+stackoffset+arg_2], NINJA_PATH_CONTENT
        jnz     .dispatch

        reportToSpy "NINJA: Adding helper symbols to symbol table"
        push    char_nversion_symb
        call    ninja_createSymbol
    addStack 4
        %substr .nversion1 NINJA_VERSION 2,1                               ; Convert version string into integer
        %substr .nversion2 NINJA_VERSION 4,1
        %assign .nversion (.nversion1-48)*10 + (.nversion2-48)
        mov     DWORD [eax+zCPar_Symbol_content_offset], .nversion

        push    char_narray_symb
        call    ninja_createSymbol
    addStack 4
        mov     DWORD [eax+zCPar_Symbol_content_offset], NINJA_PATCH_ARRAY

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
