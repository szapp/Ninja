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
    verifyStackoffset 0x14
        jl      .funcEnd

        mov     edi, eax

        push    0x1
        push    NINJA_PATH
        push    0x0
        mov     ecx, ebp
        call    zSTRING__Search
    addStack 3*4
        test    eax, eax
    verifyStackoffset 0x14
        jnz     .funcEnd

        push    0x1
        push    char_ikarus
        push    0x0
        mov     ecx, ebp
        call    zSTRING__Search
    addStack 3*4
        test    eax, eax
        jge     .resolve

        push    0x1
        push    char_lego
        push    0x0
        mov     ecx, ebp
        call    zSTRING__Search
    addStack 3*4
        test    eax, eax
        jl      .invalid

.resolve:
        mov     eax, edi
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
    verifyStackoffset 0x14
        jl      .funcEnd

        add     eax, 0x3
        sub     eax, esi
        push    eax
        push    esi
        mov     ecx, ebp
        call    zSTRING__Delete                                            ; Remove '\XXXX\..'
    addStack 2*4
    verifyStackoffset 0x14
        jmp    .funcEnd

.invalid:
        sub     esp, 0x14
        mov     ecx, esp
        push    NINJA_AUTHOR_PREFIX
        call    zSTRING__zSTRING
    addStack 4
        mov     eax, [ebp+0x8]
        push    eax
        call    zSTRING__operator_plusEq
    addStack 4
        push    eax
        call    zERROR__Message
    addStack 4
        mov     ecx, esp
        call    zSTRING___zSTRING
        mov     esi, esp
        mov     ecx, esp
        push    NINJA_PATH_INVALID
        call    zSTRING__zSTRING
    addStack 4
        push    esi
        call    zERROR__Fatal
    addStack 4
        mov     ecx, esp
        call    zSTRING___zSTRING
        add     esp, 0x14

.funcEnd:
        pop     ebp
        pop     edi
        pop     esi
        pop     eax
        pop     ecx
        ret     arg_total
    verifyStackoffset
