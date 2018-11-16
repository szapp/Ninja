; void __stdcall ninja_findVdfSrc(char *,void (__stdcall *)(char *))
; Find and Iterate over all Ninja VDF
global ninja_findVdfSrc
ninja_findVdfSrc:
        resetStackoffset
        %assign var_total     0x23C
        %assign var_fullname -0x23C                                        ; char[MAX_PATH+28]   0x120
        %assign var_filedata -0x11C                                        ; finddata_t          0x118
        %assign var_findhndl -0x4                                          ; HANDLE
        %assign arg_1        +0x4                                          ; char *
        %assign arg_2        +0x8                                          ; void (__stdcall *)(char *)
        %assign arg_total     0x8

        sub     esp, var_total
        push    eax
        push    ecx
        push    esi
        push    edi

        lea     esi, [esp+stackoffset+var_filedata]

        push    esi
        push    NINJA_PATH_VDF
        call    _findfirst

        add     esp, 0x8
        cmp     eax, INVALID_HANDLE_VALUE

        jz      .funcEnd

        mov     [esp+stackoffset+var_findhndl], eax

.fileLoopStart:
        lea     esi, [esp+stackoffset+var_filedata+0x14]                   ; finddata_t->name
        xor     edi, edi

.toUpper:
        mov     al, BYTE [esi+edi*1]
        test    al, al
        jz      .setExt

        inc     edi

        cmp     al, 'a'
        jl      .toUpper
        cmp     al, 'z'
        jg      .toUpper
        sub     al, 0x20
        mov     [esi+edi-1], al
        jmp     .toUpper

.setExt:
        dec     edi
        mov     BYTE [esi+edi*1], 'C'
        dec     edi
        mov     BYTE [esi+edi*1], 'R'
        dec     edi
        mov     BYTE [esi+edi*1], 'S'

        push    DWORD [esp+stackoffset+arg_1]
        lea     esi, [esp+stackoffset+var_fullname]
        push    esi
        call    DWORD [ds_lstrcpyA]
    addStack 8
        lea     esi, [esp+stackoffset+var_filedata+0x14]
        push    esi
        push    eax
        call    DWORD [ds_lstrcatA]
    addStack 8
        mov     esi, eax

        call    zFILE_VDFS__LockCriticalSection
        push    VDF_VIRTUAL | VDF_PHYSICAL | VDF_PHYSICALFIRST
        push    esi                                                        ; arg_1 + filedata->name + ext
        call    DWORD [ds_vdf_fexists]
        add     esp, 0x8
        push    eax
        call    zFILE_VDFS__UnlockCriticalSection
        pop     eax
        test    eax, eax
        jz      .nextfile

        lea     esi, [esp+stackoffset+var_fullname]
        push    esi
        call    [esp+stackoffset+arg_2]
    addStack 4

.nextfile:
        lea     esi, [esp+stackoffset+var_filedata]
        push    esi
        push    DWORD [esp+stackoffset+var_findhndl]
        call    _findnext
        add     esp, 0x8
        test    eax, eax
        jz      .fileLoopStart

        push    DWORD [esp+stackoffset+var_findhndl]
        call    _findclose
        add     esp, 0x4

.funcEnd:

        pop     edi
        pop     esi
        pop     ecx
        pop     eax
        add     esp, var_total
        ret     arg_total
    verifyStackoffset
