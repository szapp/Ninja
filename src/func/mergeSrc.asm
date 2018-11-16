; void __stdcall ninja_mergeSrc(char *)
; Merge Ninja scripts
global ninja_mergeSrc
ninja_mergeSrc:
        resetStackoffset
        %assign var_total   0x14
        %assign var_string -0x14                                           ; zString
        %assign arg_1      +0x4                                            ; char *
        %assign arg_total   0x4

        sub     esp, var_total
        push    eax
        push    ecx

        push    DWORD [esp+stackoffset+arg_1]

        times 1 nop

        lea     ecx, [esp+stackoffset+var_string]
        call    zSTRING__zSTRING
    addStack 4

        times 9 nop

        push    ecx
        mov     eax, DWORD [zCParser__cur_parser]

        mov     ecx, eax
        call    zCParser__MergeFile
    addStack 4

        lea     ecx, [esp+stackoffset+var_string]
        call    zSTRING___zSTRING

        pop     ecx
        pop     eax
        add     esp, var_total
        ret     arg_total
    verifyStackoffset
