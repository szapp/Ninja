; int __stdcall ninja_parseVersionString(char *)
; Return numerical representation of formated version description
global ninja_parseVersionString
ninja_parseVersionString:
        resetStackoffset
        %assign var_total     0x10C
        %assign var_minor    -0x10C                                        ; int
        %assign var_major    -0x108                                        ; int
        %assign var_base     -0x104                                        ; int
        %assign var_copied   -0x100                                        ; char[0x100]
        %assign arg_1        +0x4                                          ; char *
        %assign arg_total     0x4

        sub     esp, var_total
        push    ecx
        push    esi
        push    edi
        push    edx

        push    DWORD [esp+stackoffset+arg_1]
        lea     esi, [esp+stackoffset+var_copied]
        push    esi
        call    DWORD [ds_lstrcpyA]
    addStack 8
        xor     edi, edi

.findOnset:
        mov     ecx, [esi+edi]
        cmp     cl, 0
    verifyStackoffset 0x10+var_total
        jz      .failed1

        inc     edi
        cmp     cl, ' '
        jnz     .findOnset
        cmp     BYTE [esi+edi], '0'
        jl      .findOnset
        cmp     BYTE [esi+edi], '9'
        jg      .findOnset

        mov     edx, var_base
        mov     eax, edi

.collectNum:
        cmp     BYTE [esi+edi], 0
        jz      .done

        cmp     BYTE [esi+edi], '0'
        jl      .foundOffset
        cmp     BYTE [esi+edi], '9'
        jg      .foundOffset

        inc     edi
        jmp     .collectNum

.foundOffset:
        mov     BYTE [esi+edi], 0
        add     eax, esi
        push    eax
        call    _atol
        add     esp, 0x4
        mov     [esp+stackoffset+edx], eax
        cmp     DWORD edx, var_minor
        jle     .final

        inc     edi
        sub     edx, 0x4
        mov     eax, edi
        jmp     .collectNum

.done:
        cmp     edx, var_minor
    verifyStackoffset 0x10+var_total
        jg      .failed2
        jz      .foundOffset

.final:
        mov     eax, 1000000
        mul     DWORD [esp+stackoffset+var_base]
        mov     esi, eax
        mov     eax, 1000
        mul     DWORD [esp+stackoffset+var_major]
        add     eax, esi
        add     eax, [esp+stackoffset+var_minor]
    verifyStackoffset 0x10+var_total
        jmp     .funcEnd

.failed1:
        mov     eax, NINJA_LEGO_END
        jmp     .reportError

.failed2:
        mov     eax, NINJA_LEGO_BMM

.reportError:
        sub     esp, 0x14
        mov     ecx, esp
        push    eax
        call    zSTRING__zSTRING
    addStack 4
        push    eax
        call    zERROR__Fatal
    addStack 4
        mov     esp, ecx
        call    zSTRING___zSTRING
        add     esp, 0x14
        xor     eax, eax
        dec     eax                                                        ; Return -1

.funcEnd:
        pop     edx
        pop     edi
        pop     esi
        pop     ecx
        add     esp, var_total
        ret     arg_total
    verifyStackoffset
