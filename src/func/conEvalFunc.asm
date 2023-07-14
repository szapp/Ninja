; int __cdecl ninja_conEvalFunc(zString const &, zString &)
; Console command displaying the Ninja version and all active patches in order
global ninja_conEvalFunc
ninja_conEvalFunc:
        resetStackoffset
        %assign var_total      0x80
        %assign var_header    -0x80                                        ; char *
        %assign arg_1         +0x4                                         ; zString const &
        %assign arg_2         +0x8                                         ; zString &

        sub     esp, var_total
        push    ecx
        push    esi
        push    edi

        push    0x1
        push    NINJA_CON_COMMAND
        push    0x0
        mov     ecx, [esp+stackoffset+arg_1]
        call    zSTRING__Search
    addStack 3*4
        mov     esi, eax
        xor     eax, eax
        test    esi, esi
        jnz     .funcEnd

        push    BYTE ' '
        mov     ecx, [esp+stackoffset+arg_1]
        call    zSTRING__TrimRight
    addStack 4

        push    NINJA_CON_COMMAND
        mov     ecx, [esp+stackoffset+arg_1]
        push    DWORD [ecx+0x8]
        call    DWORD [ds_lstrcmpiA]
    addStack 2*4
        test    eax, eax
        jz      .ninja

        mov     eax, [NINJA_PATCH_ARRAY+zCArray.array]
        mov     esi, eax
        xor     eax, eax
        test    esi, esi
        jz      .funcEnd

        xor     edi, edi

.patchLoop:
        mov     esi, [NINJA_PATCH_ARRAY+zCArray.numInArray]
        xor     eax, eax
        cmp     edi, esi
        jge     .funcEnd

        mov     esi, [NINJA_PATCH_ARRAY+zCArray.array]
        mov     esi, [esi+edi*0x4]
        add     esi, 0x4
        push    esi
        mov     ecx, [esp+stackoffset+arg_1]
        mov     ecx, [ecx+0x8]
        add     ecx, 0x6
        push    ecx
        call    DWORD [ds_lstrcmpiA]
    addStack 2*4
        inc     edi
        test    eax, eax
        jnz     .patchLoop

        add     esi, 0x120
        push    esi
        call    DWORD [ds_lstrlenA]
    addStack 4
        push    eax
        push    esi
        mov     ecx, [esp+stackoffset+arg_2]
        lea     ecx, [ecx+0x4]
        call    std__basic_string__assign
    addStack 2*4
        mov     eax, 0x1
        jmp     .funcEnd

.ninja:
        push    NINJA_VERSION_CHAR_1
        lea     esi, [esp+stackoffset+var_header]
        push    esi
        call    DWORD [ds_lstrcpyA]
    addStack 2*4
        lea     ecx, [esp+stackoffset+var_header]
        add     ecx, NINJA_VERSION_CHAR_1_len
        dec     ecx
        push    ecx
        call    ninja_Y3JjMzI
    addStack 4
        push    NINJA_VERSION_CHAR_2
        lea     ecx, [esp+stackoffset+var_header]
        push    ecx
        call    DWORD [ds_lstrcatA]
    addStack 2*4
        lea     ecx, [esp+stackoffset+var_header]
        push    ecx
        call    DWORD [ds_lstrlenA]
    addStack 4
        push    eax
        lea     ecx, [esp+stackoffset+var_header]
        push    ecx
        mov     ecx, [esp+stackoffset+arg_2]
        add     ecx, 0x4
        call    std__basic_string__assign
    addStack 2*4

        mov     eax, [NINJA_PATCH_ARRAY+zCArray.array]
        test    eax, eax
        jnz     .listPatches

        push    NINJA_CON_NOTFOUND
        mov     ecx, [esp+stackoffset+arg_2]
        call    zSTRING__operator_plusEq
    addStack 4
        mov     eax, 0x1
        jmp     .funcEnd

.listPatches:
        mov     ecx, char_lf
        xor     edi, edi

.arrayLoop:
        mov     esi, [NINJA_PATCH_ARRAY+zCArray.numInArray]
        mov     eax, 0x1
        cmp     edi, esi
        jge     .funcEnd

        push    ecx
        mov     ecx, [esp+stackoffset+arg_2]
        call    zSTRING__operator_plusEq
    addStack 4
        mov     esi, [NINJA_PATCH_ARRAY+zCArray.array]
        mov     esi, [esi+edi*0x4]
        add     esi, 0x4
        push    esi
        call    zSTRING__operator_plusEq
    addStack 4

        mov     ecx, char_commaSpace
        inc     edi
        jmp     .arrayLoop

.funcEnd:
        pop     edi
        pop     esi
        pop     ecx
        add     esp, var_total
        ret
    verifyStackoffset


; int __stdcall ninja_Y3JjMzI(char *)
; Nothing to see here
global ninja_Y3JjMzI
ninja_Y3JjMzI:
        resetStackoffset
        %assign arg_1         +0x4                                         ; char *
        %assign arg_total      0x4

        push    ecx

        mov     ecx, [esp+stackoffset+arg_1]                               ; There is a purpose for doing it this way!
        mov     DWORD [ecx], 0x2D435243
        mov     DWORD [ecx+0x4], 0x203A3233
        mov     WORD [ecx+0x8], 0x7830

        sub     esp, 0x14
        mov     ecx, esp
        push    NINJA_FILE
        call    zSTRING__zSTRING
    addStack 4

        push    0x10
        mov     ecx, [esp+stackoffset+arg_1]
        add     ecx, 0xA
        push    ecx

        xor     ecx, ecx
        push    ecx
        mov     ecx, esp
        push    eax
        call    g1g2(0x5CE900,0x5ED6A0,0x5F9BF0)
    addStack 4
        call    _itoa
        add     esp, 0xC

        mov     ecx, esp
        call    zSTRING___zSTRING
        add     esp, 0x14

        mov     eax, [esp+stackoffset+arg_1]

.toUpper:
        mov     cl, BYTE [eax]
        test    cl, cl
        jz      .funcEnd
        inc     eax
        cmp     cl, 'a'
        jl      .toUpper
        cmp     cl, 'f'
        jg      .toUpper
        sub     cl, 0x20
        mov     [eax-0x1], cl
        jmp     .toUpper

.funcEnd:
        mov     eax, [esp+stackoffset+arg_1]
        pop     ecx
        ret     arg_total
    verifyStackoffset
