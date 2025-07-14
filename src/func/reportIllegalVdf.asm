; void __stdcall ninja_reportIllegalVdf(char *)
; Report an illegal VDF archive and terminate (does not return)
global ninja_reportIllegalVdf
ninja_reportIllegalVdf:
        resetStackoffset
        %assign arg_1      +0x4                                            ; char *
        %assign arg_total   0x4

        ; pusha                                                            ; Function never returns: Safe some space

        sub     esp, 0x4
        push    0x200
        call    operator_new
        add     esp, 0x4
        push    0x1FF
        push    0x20
        push    eax
        call    _memset
        add     esp, 0xC
        mov     BYTE [eax+0x1FF], 0x0                                      ; Null-terminated
        sub     esp, 0x14
        mov     ecx, esp
        push    eax
        call    zSTRING__zSTRING
    addStack 4
        push    DWORD [esp+stackoffset+arg_1]
        push    NINJA_INVALID_PATCH
        push    ecx
        call    zSTRING__Sprintf
        add     esp, 0xC
        push    esp
        call    zERROR__Fatal
    addStack 4
        ; mov     ecx, esp                                                 ; Never reached: Safe some space
        ; call    zSTRING___zSTRING
        add     esp, 0x14
        ; push    esp                                                      ; Never reached: Safe some space
        ; call    operator_delete
        ; add     esp, 0x4
        add     esp, 0x4

        ; popa                                                             ; Function never returns: Safe some space
        ; ret     arg_total
    verifyStackoffset
