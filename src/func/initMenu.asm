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
        push    eax
        push    ecx
        push    esi

        push    DWORD [esp+stackoffset+arg_1]
        call    DWORD [ds_lstrlenA]
    addStack 4

        mov     ecx, [esp+stackoffset+arg_1]
        inc     eax                                                        ; This works, because buffer is big enough
        mov     BYTE [eax+ecx*1], 0
        dec     eax
        mov     BYTE [eax+ecx*1], 'U'
        dec     eax
        mov     BYTE [eax+ecx*1], 'N'
        dec     eax
        mov     BYTE [eax+ecx*1], 'E'
        dec     eax
        mov     BYTE [eax+ecx*1], 'M'
        dec     eax
        mov     BYTE [eax+ecx*1], '_'
        add     ecx, 0xF                                                   ; Cut off "\NINJA\CONTENT_"
        push    ecx
        lea     ecx, [esp+stackoffset+var_string]
        call    zSTRING__zSTRING
    addStack 4

        mov     esi, ebp                                                   ; zCMenu *
        push    ecx
        mov     ecx, zCParser_parser
        call    zCParser__CallFunc
    addStack 4

        lea     ecx, [esp+stackoffset+var_string]
        call    zSTRING___zSTRING

        pop     esi
        pop     ecx
        pop     eax
        add     esp, var_total
        ret     arg_total
    verifyStackoffset
