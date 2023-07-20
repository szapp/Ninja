; void __stdcall ninja_initMenu(char *)
; Initialize the menu ninja
global ninja_initMenu
ninja_initMenu:
        resetStackoffset
        %assign var_total   0x14
        %assign var_string -0x14                                           ; zString
        %assign arg_1      +0x4                                            ; char *
        %assign arg_total   0x4

        sub     esp, var_total
        pusha

        push    DWORD [esp+stackoffset+arg_1]
        call    DWORD [ds_lstrlenA]
    addStack 4

        add     eax, [esp+stackoffset+arg_1]
        sub     eax, g1g2(0xA,0xC,0xA)                                     ; Cut off/overwrite '\CONTENT_G*.SRC'
        mov     BYTE [eax], 0x0
        sub     eax, 0x4
        mov     DWORD [eax], 'MENU'
        mov     BYTE [eax-0x1], '_'
        mov     ecx, [esp+stackoffset+arg_1]
        mov     BYTE [ecx+0x6], '_'                                        ; Overwrite second '\'
        inc     ecx                                                        ; Cut off first '\'
        push    ecx
        lea     ecx, [esp+stackoffset+var_string]
        call    zSTRING__zSTRING
    addStack 4
        mov     esi, ecx

        push    ecx
        lea     ecx, [zCParser_parser+zCParser_table_offset]
        call    zCPar_SymbolTable__GetIndex
    addStack 4
        test    eax, eax
        jl      .funcEnd

        sub     esp, 0x14
        mov     ecx, esp
        push    NINJA_CALL_FUNC
        call    zSTRING__zSTRING
    addStack 4
        mov     eax, [esp+stackoffset+var_string+0x8]
        push    eax
        call    zSTRING__operator_plusEq
    addStack 4
        push    ecx
        call    zERROR__Message
    addStack 4
        mov     ecx, esp
        call    zSTRING___zSTRING
        add     esp, 0x14

        mov     ecx, esi
        mov     esi, ebp                                                   ; zCMenu *
        push    ecx
        mov     ecx, zCParser_parser
        call    zCParser__CallFunc
    addStack 4

.funcEnd:
        lea     ecx, [esp+stackoffset+var_string]
        call    zSTRING___zSTRING

        popa
        add     esp, var_total
        ret     arg_total
    verifyStackoffset
