; void __stdcall ninja_injectSrc(char *)
; Merge Ninja scripts
global ninja_injectSrc
ninja_injectSrc:
        resetStackoffset
        %assign var_total   0x14
        %assign var_string -0x14                                           ; zString
        %assign arg_1      +0x4                                            ; char *
        %assign arg_total   0x4

        sub     esp, var_total
        pusha

        push    DWORD [esp+stackoffset+arg_1]
        lea     ecx, [esp+stackoffset+var_string]
        call    zSTRING__zSTRING
    addStack 4

        sub     esp, 0x14
        mov     ecx, esp
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
        mov     ecx, esp
        call    zSTRING___zSTRING
        add     esp, 0x14

        lea     ecx, [esp+stackoffset+var_string]
        push    ecx
        mov     eax, DWORD [zCParser__cur_parser]
        mov     ecx, eax
        call    zCParser__MergeFile
    addStack 4

        lea     ecx, [esp+stackoffset+var_string]
        call    zSTRING___zSTRING

        popa
        add     esp, var_total
        ret     arg_total
    verifyStackoffset
