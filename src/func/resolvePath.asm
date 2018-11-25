; int __stdcall ninja_resolvePath(zString &)
; Resolve '\..' in a path
global ninja_resolvePath
ninja_resolvePath:
        resetStackoffset
        %assign arg_1         +0x4                                         ; zString &
        %assign arg_total      0x4

        push    ecx
        push    eax
        push    esi
        push    edi
        push    ebp
        mov     ebp, [esp+stackoffset+arg_1]

        push    0x1
        push    char_prevDir
        push    0x0
        mov     ecx, ebp
        call    zSTRING__Search
    addStack 3*4
        test    eax, eax
        jl      .funcEnd

        xor     edi, edi
        dec     edi
        xor     esi, esi
        dec     esi
        mov     ecx, [ebp+0x8]

.searchBS:
        inc     edi
        cmp     edi, eax
        jge     .searchEnd
        cmp     BYTE [ecx+edi], '\'
        jnz     .searchBS
        mov     esi, edi
        jmp     .searchBS

.searchEnd:
        test    esi, esi
        jl      .funcEnd

        add     eax, 0x3
        sub     eax, esi
        push    eax
        push    esi
        mov     ecx, ebp
        call    zSTRING__Delete                                            ; Remove '\XXXX\..'
    addStack 2*4

.funcEnd:
        pop     ebp
        pop     edi
        pop     esi
        pop     eax
        pop     ecx
        ret     arg_total
    verifyStackoffset
