; void __stdcall ninja_debugMessage(zString *)
; Log additional information (requires zSpy level >= 6)
global ninja_debugMessage
ninja_debugMessage:
        resetStackoffset
        %assign arg_1      +0x4                                            ; zString *
        %assign arg_total   0x4

        mov     eax, DWORD [esp+stackoffset+arg_1]
        xor     ecx, ecx
        push    ecx
        push    ecx
        push    ecx
        push    ecx
        push    0x6
        push    eax
        push    ecx
        push    0x1
        mov     ecx, zERROR_zerr
        call    zERROR__Report
    addStack 8*4
        ret     arg_total
    verifyStackoffset
