; void __stdcall ninja_dispatch(char *,void (__stdcall *)(char *))
; Iterate over all Ninja VDF
global ninja_dispatch
ninja_dispatch:
        resetStackoffset
        %assign var_total      0x120
        %assign var_fullname  -0x120                                       ; char[MAX_PATH+28]   0x120
        %assign arg_1         +0x4                                         ; char *
        %assign arg_2         +0x8                                         ; void (__stdcall *)(char *)
        %assign arg_total      0x8

        sub     esp, var_total
        push    eax
        push    ecx
        push    esi
        push    edi
        push    ebx

        mov     eax, [NINJA_PATCH_ARRAY+zCArray.array]
        test    eax, eax
        jz      .funcEnd

        xor     edi, edi

.arrayLoop:
        mov     eax, [NINJA_PATCH_ARRAY+zCArray.numInArray]
        cmp     edi, eax
        jge     .funcEnd

        push    NINJA_PATH
        lea     esi, [esp+stackoffset+var_fullname]
        push    esi
        call    DWORD [ds_lstrcpyA]
    addStack 8
        mov     esi, [NINJA_PATCH_ARRAY+zCArray.array]
        mov     esi, [esi+edi*0x4]
        add     esi, 0x4+0x6                                               ; Cut off 'NINJA_'
        push    esi
        push    eax
        call    DWORD [ds_lstrcatA]
    addStack 8
        push    DWORD [esp+stackoffset+arg_1]
        push    eax
        call    DWORD [ds_lstrcatA]
    addStack 8
        push    char_g1g2
        push    eax
        call    DWORD [ds_lstrcatA]
    addStack 8
        push    char_src
        push    eax
        call    DWORD [ds_lstrcatA]
    addStack 8
        mov     esi, eax

        inc     edi

        mov     eax, ninja_injectMds
        cmp     eax, DWORD [esp+stackoffset+arg_2]
        jz      .deploy
        mov     eax, ninja_injectOU
        cmp     eax, DWORD [esp+stackoffset+arg_2]
        jz      .deploy

        xor     ebx, ebx

.fileExist:
        call    zFILE_VDFS__LockCriticalSection
        push    VDF_VIRTUAL | VDF_PHYSICAL | VDF_PHYSICALFIRST
        push    esi
        call    DWORD [ds_vdf_fexists]
        add     esp, 0x8
        push    eax
        call    zFILE_VDFS__UnlockCriticalSection
        pop     eax
        test    eax, eax
        jnz     .deploy

        test    ebx, ebx
        jnz     .arrayLoop
        mov     eax, NINJA_PATH_CONTENT
        cmp     eax, DWORD [esp+stackoffset+arg_1]
        jz      .arrayLoop

        push    esi
        call    DWORD [ds_lstrlenA]
    addStack 4
        sub     eax, 0x7
        mov     BYTE [esi+eax], 0x0
        push    char_src
        push    esi
        call    DWORD [ds_lstrcatA]
    addStack 8
        inc     ebx
        jmp     .fileExist

.deploy:
        push    esi
        call    [esp+stackoffset+arg_2]
    addStack 4
        jmp     .arrayLoop

.funcEnd:
        pop     ebx
        pop     edi
        pop     esi
        pop     ecx
        pop     eax
        add     esp, var_total
        ret     arg_total
    verifyStackoffset
