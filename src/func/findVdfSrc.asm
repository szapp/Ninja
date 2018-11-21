; void __stdcall ninja_findVdfSrc(char *,void (__stdcall *)(char *))
; Find and Iterate over all Ninja VDF
global ninja_findVdfSrc
ninja_findVdfSrc:
        resetStackoffset
        %assign var_total      0x348
        %assign var_timestamp -0x348                                       ; int
        %assign var_filehndl  -0x344                                       ; FILE *
        %assign var_filevdf   -0x340                                       ; char[MAX_PATH]      0x104
        %assign var_fullname  -0x23C                                       ; char[MAX_PATH+28]   0x120
        %assign var_filedata  -0x11C                                       ; finddata_t          0x118
        %assign var_findhndl  -0x4                                         ; HANDLE
        %assign arg_1         +0x4                                         ; char *
        %assign arg_2         +0x8                                         ; void (__stdcall *)(char *)
        %assign arg_total      0x8

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

        lea     ecx, [NINJA_PATCH_ARRAY-1]
        mov     [ecx], BYTE 0                                              ; Null terminated char string
        mov     ecx, NINJA_PATCH_ARRAY
        call    zCArray_int___zCArray_int_

.fileLoopStart:
        push    DWORD [esp+stackoffset+arg_1]
        lea     esi, [esp+stackoffset+var_fullname]
        push    esi
        call    DWORD [ds_lstrcpyA]
    addStack 8
        lea     esi, [esp+stackoffset+var_filedata+finddata_t.name]
        push    esi
        push    eax
        call    DWORD [ds_lstrcatA]
    addStack 8
        mov     esi, eax
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

        call    zFILE_VDFS__LockCriticalSection
        push    VDF_VIRTUAL | VDF_PHYSICAL | VDF_PHYSICALFIRST
        push    esi                                                        ; arg_1 + filedata_t.name + ext
        call    DWORD [ds_vdf_fexists]
        add     esp, 0x8
        push    eax
        call    zFILE_VDFS__UnlockCriticalSection
        pop     eax
        test    eax, eax
        jz      .nextfile

        push    NINJA_PATH_DATA
        lea     esi, [esp+stackoffset+var_filevdf]
        push    esi
        call    DWORD [ds_lstrcpyA]
    addStack 8
        lea     esi, [esp+stackoffset+var_filedata+finddata_t.name]
        push    esi
        push    eax
        call    DWORD [ds_lstrcatA]
    addStack 8
        mov     esi, eax

        push    CHAR_RB
        push    esi
        call    _fopen
        add     esp, 0x8
        test    eax, eax
        jz      .nextfile

        mov     [esp+stackoffset+var_filehndl], eax

        push    SEEK_SET
        push    VDFheader.timestamp
        push    DWORD [esp+stackoffset+var_filehndl]
        call    _fseek
        add     esp, 0xC

        push    DWORD [esp+stackoffset+var_filehndl]
        push    0x1
        push    0x4                                                        ; sizeof(VDFheader.timestamp)
        lea     eax, [esp+stackoffset+var_timestamp]
        push    eax
        call    _fread
        add     esp, 0x10

        push    DWORD [esp+stackoffset+var_filehndl]
        call    _fclose
        add     esp, 0x4

        push    0x4+0x120                                                  ; sizeof(var_timestamp)+sizeof(var_fullname)
        call    operator_new
        add     esp, 0x4
        mov     edi, eax

        mov     eax, [esp+stackoffset+var_timestamp]
        mov     [edi], eax

        lea     eax, [esp+stackoffset+var_fullname]
        push    eax
        lea     eax, [edi+0x4]
        push    eax
        call    DWORD [ds_lstrcpyA]
    addStack 8

        sub     esp, 0x4
        mov     [esp], edi
        push    esp
        mov     ecx, NINJA_PATCH_ARRAY
        call    zCArray_int___InsertEnd
        add     esp, 0x4
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

        mov     eax, [NINJA_PATCH_ARRAY+zCArray.numInArray]
        test    eax, eax
        jz      .arrayLoopEnd

        push    zCModel__AniAttachmentCompare                              ; Abuse convenient comparator
        push    0x4
        push    DWORD [NINJA_PATCH_ARRAY+zCArray.numInArray]
        push    DWORD [NINJA_PATCH_ARRAY+zCArray.array]
        call    _qsort
        add     esp, 0x10

        xor     edi, edi

.arrayLoop:
        mov     eax, [NINJA_PATCH_ARRAY+zCArray.array]
        mov     esi, [eax+edi*0x4]

        lea     eax, [esi+0x4]
        push    eax
        call    [esp+stackoffset+arg_2]
    addStack 4

        push    esi
        call    operator_delete
        add     esp, 0x4

        inc     edi
        mov     eax, [NINJA_PATCH_ARRAY+zCArray.numInArray]
        cmp     edi, eax
        jl     .arrayLoop

.arrayLoopEnd:
        mov     ecx, NINJA_PATCH_ARRAY
        call    zCArray_int____zCArray_int_

.funcEnd:
        pop     edi
        pop     esi
        pop     ecx
        pop     eax
        add     esp, var_total
        ret     arg_total
    verifyStackoffset
