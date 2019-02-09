; void __stdcall ninja_dispatch(char *, char *, void (__stdcall *)(char *))
; Iterate over all Ninja VDF
global ninja_dispatch
ninja_dispatch:
        resetStackoffset
        %assign var_total      0x120
        %assign var_fullname  -0x120                                       ; char[MAX_PATH+28]   0x120
        %assign arg_1         +0x4                                         ; char *
        %assign arg_2         +0x8                                         ; char *
        %assign arg_3         +0xC                                         ; void (__stdcall *)(char *)
        %assign arg_total      0xC

        sub     esp, var_total
        pusha

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
    addStack 2*4
        mov     esi, [NINJA_PATCH_ARRAY+zCArray.array]
        mov     esi, [esi+edi*0x4]
        add     esi, 0x4
        push    esi
        push    eax
        call    DWORD [ds_lstrcatA]
    addStack 2*4
        push    char_BSlash
        push    eax
        call    DWORD [ds_lstrcatA]
    addStack 2*4
        push    DWORD [esp+stackoffset+arg_1]
        push    eax
        call    DWORD [ds_lstrcatA]
    addStack 2*4
        push    char_g1g2
        push    eax
        call    DWORD [ds_lstrcatA]
    addStack 2*4
        push    DWORD [esp+stackoffset+arg_2]
        push    eax
        call    DWORD [ds_lstrcatA]
    addStack 2*4
        mov     esi, eax
        inc     edi

        xor     ebx, ebx

        mov     eax, NINJA_PATH_OU                                         ; Special case: Alternating file extensions
        cmp     eax, DWORD [esp+stackoffset+arg_1]
        jnz     .fileExist
        sub     ebx, 0x2                                                   ; Four filenames to check

.fileExist:
        sub     esp, 0x14
        mov     ecx, esp
        push    NINJA_LOOKING_FOR
        call    zSTRING__zSTRING
    addStack 4
        push    esi
        call    zSTRING__operator_plusEq
    addStack 4
        push    eax
        call    ninja_debugMessage
    addStack 4
        mov     ecx, esp
        call    zSTRING___zSTRING
        add     esp, 0x14

        call    zFILE_VDFS__LockCriticalSection
        push    VDF_VIRTUAL | VDF_PHYSICAL | VDF_PHYSICALFIRST
        push    esi
        call    DWORD [ds_vdf_fexists]
        add     esp, 0x8
        push    eax
        call    zFILE_VDFS__UnlockCriticalSection
        pop     eax
        test    eax, eax
        jg      .deploy

        test    ebx, ebx
        jg      .arrayLoop
        mov     eax, NINJA_PATH_CONTENT                                    ; Disallow fall-back for content ninja
        cmp     eax, DWORD [esp+stackoffset+arg_1]
        jz      .arrayLoop

        mov     eax, NINJA_PATH_OU                                         ; Special case: Check OUs with BIN-extension
        cmp     eax, DWORD [esp+stackoffset+arg_1]
        jnz     .removePostfix

        cmp     ebx, 0xFFFFFFFF                                            ; -1
        jz      .removePostfix

        push    esi
        call    DWORD [ds_lstrlenA]
    addStack 4
        sub     eax, 0x4                                                   ; Cut off '.BIN'
        mov     BYTE [esi+eax], 0x0
        push    char_csl
        push    esi
        call    DWORD [ds_lstrcatA]
    addStack 2*4
        inc     ebx
        jmp     .fileExist

.removePostfix:
        push    esi
        call    DWORD [ds_lstrlenA]
    addStack 4
        sub     eax, 0x7                                                   ; Cut off '_G*.EXT'
        mov     BYTE [esi+eax], 0x0
        push    DWORD [esp+stackoffset+arg_2]
        push    esi
        call    DWORD [ds_lstrcatA]
    addStack 2*4
        inc     ebx
        jmp     .fileExist

.deploy:
        push    esi
        call    [esp+stackoffset+arg_3]
    addStack 4
        jmp     .arrayLoop

.funcEnd:
        popa
        add     esp, var_total
        ret     arg_total
    verifyStackoffset
