; void __stdcall ninja_debugMessage(zString *)
; Log additional information (requires zSpy level >= 6)
global ninja_debugMessage
ninja_debugMessage:
        resetStackoffset
        %assign arg_1      +0x4                                            ; zString *
        %assign arg_total   0x4

        xor     ecx, ecx
        push    ecx
        push    ecx
        push    ecx
        push    ecx
        push    0x6
        push    DWORD [esp+stackoffset+arg_1]
        push    ecx
        inc     ecx
        push    ecx
        mov     ecx, zERROR_zerr
        call    zERROR__Report
    addStack 8*4
        ret     arg_total
    verifyStackoffset
