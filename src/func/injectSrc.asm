; void __stdcall ninja_injectSrc(char *, char *)
; Merge Ninja scripts
global ninja_injectSrc
ninja_injectSrc:
        resetStackoffset
        %assign var_total   0x148
        %assign var_symbol -0x148                                          ; char[0x120]
        %assign var_msg    -0x28                                           ; zString
        %assign var_string -0x14                                           ; zString
        %assign arg_1      +0x4                                            ; char *
        %assign arg_2      +0x8                                            ; char *
        %assign arg_total   0x8

        sub     esp, var_total
        pusha

        push    DWORD [esp+stackoffset+arg_1]
        lea     ecx, [esp+stackoffset+var_string]
        call    zSTRING__zSTRING
    addStack 4

        lea     ecx, [esp+stackoffset+var_msg]                             ; Create log message
        push    NINJA_INJECT
        call    zSTRING__zSTRING
    addStack 4
        mov     eax, [esp+stackoffset+var_string+0x8]
        add     eax, 0x7                                                   ; Cut off '\NINJA\'
        push    eax
        call    zSTRING__operator_plusEq
    addStack 4
        push    ecx
        call    zERROR__Message
    addStack 4

        push    char_ndivider_symb                                         ; Create divider symbol name
        lea     eax, [esp+stackoffset+var_symbol]
        push    eax
        call    DWORD [ds_lstrcpyA]
    addStack 2*4
        mov     WORD [eax+19], '_'                                         ; '_', 0
        push    DWORD [esp+stackoffset+arg_2]
        push    eax
        call    DWORD [ds_lstrcatA]
    addStack 2*4

        push    zPAR_TYPE_INSTANCE                                         ; Create start divider symbol symbol
        push    eax
        call    ninja_createSymbol
    addStack 2*4

        lea     ecx, [esp+stackoffset+var_string]
        push    ecx
        mov     ecx, DWORD [zCParser__cur_parser]
        call    zCParser__MergeFile
    addStack 4

        lea     eax, [esp+stackoffset+var_symbol]                          ; Change symbol string
        mov     DWORD [eax+14], 'END_'
        mov     BYTE [eax+18], 0x0
        push    DWORD [esp+stackoffset+arg_2]
        push    eax
        call    DWORD [ds_lstrcatA]
    addStack 2*4

        push    zPAR_TYPE_INSTANCE                                         ; Create end divider symbol symbol
        push    eax
        call    ninja_createSymbol
    addStack 2*4

        lea     ecx, [esp+stackoffset+var_msg]
        call    zSTRING___zSTRING
        lea     ecx, [esp+stackoffset+var_string]
        call    zSTRING___zSTRING

        popa
        add     esp, var_total
        ret     arg_total
    verifyStackoffset
