; int __cdecl ninja_conEvalFunc(zString const &, zString &)
; Console command displaying the Ninja version and all active patches in order
global ninja_conEvalFunc
ninja_conEvalFunc:
        resetStackoffset
        %assign arg_1         +0x4                                         ; zString const &
        %assign arg_2         +0x8                                         ; zString &

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

        push    NINJA_VERSION_CHAR_len
        push    NINJA_VERSION_CHAR
        mov     ecx, [esp+stackoffset+arg_2]
        lea     ecx, [ecx+0x4]
        call    std__basic_string__assign
    addStack 2*4

        mov     eax, [NINJA_PATCH_ARRAY+zCArray.array]
        test    eax, eax
        jnz      .listPatches

        push    NINJA_CON_NOTFOUND
        mov     ecx, [esp+stackoffset+arg_2]
        call    zSTRING__operator_plusEq
    addStack 4
        jmp     .funcEnd

.listPatches:
        mov     ecx, char_lf
        xor     edi, edi

.arrayLoop:
        mov     esi, [NINJA_PATCH_ARRAY+zCArray.numInArray]
        mov     eax, 1
        cmp     edi, esi
        jge     .funcEnd

        push    ecx
        mov     ecx, [esp+stackoffset+arg_2]
        call    zSTRING__operator_plusEq
    addStack 4
        mov     esi, [NINJA_PATCH_ARRAY+zCArray.array]
        mov     esi, [esi+edi*0x4]
        lea     esi, [esi+0x4]
        add     esi, 0x6                                                   ; Cut off 'NINJA_'
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
        ret
    verifyStackoffset
