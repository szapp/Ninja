; Find all Ninja VDF and create an array of them

global createVdfArray
createVdfArray:
        resetStackoffset
        %assign var_total      0x348
        %assign var_timestamp -0x348                                       ; int
        %assign var_filehndl  -0x344                                       ; FILE *
        %assign var_filevdf   -0x340                                       ; char[MAX_PATH]      0x104
        %assign var_patchname -0x23C                                       ; char[MAX_PATH+28]   0x120
        %assign var_filedata  -0x11C                                       ; finddata_t          0x118
        %assign var_findhndl  -0x4                                         ; HANDLE

        sub     esp, var_total
        push    eax
        push    ecx
        push    esi
        push    edi

        reportToSpy " NINJA: Registering console command"

        sub     esp, 0x14
        mov     ecx, esp
        push    NINJA_CON_DESCR
        call    zSTRING__zSTRING
    addStack 4
        mov     esi, eax
        sub     esp, 0x14
        mov     ecx, esp
        push    NINJA_CON_COMMAND
        call    zSTRING__zSTRING
    addStack 4
        push    esi
        push    eax
        mov     ecx, zCConsole_zcon
        call    zCConsole__Register
    addStack 2*4
        mov     ecx, esp
        call    zSTRING___zSTRING
        add     esp, 0x14
        mov     ecx, esp
        call    zSTRING___zSTRING
        add     esp, 0x14

        push    ninja_conEvalFunc
        mov     ecx, zCConsole_zcon
        call    zCConsole__AddEvalFunc
    addStack 4

        reportToSpy " NINJA: Detecting and sorting all Ninja patches (VDF)"

        lea     ecx, [NINJA_PATCH_ARRAY-1]
        mov     [ecx], BYTE 0                                              ; Null terminated char string
        mov     ecx, NINJA_PATCH_ARRAY
        call    zCArray_int___zCArray_int_

        lea     esi, [esp+stackoffset+var_filedata]

        push    esi
        push    NINJA_PATH_VDF
        call    _findfirst
        add     esp, 0x8

        cmp     eax, INVALID_HANDLE_VALUE
        jz      .back

        mov     [esp+stackoffset+var_findhndl], eax

.fileLoopStart:
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

        push    char_rb
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

        lea     esi, [esp+stackoffset+var_filedata+finddata_t.name]
        push    esi
        lea     esi, [esp+stackoffset+var_patchname]
        push    esi
        call    DWORD [ds_lstrcpyA]
    addStack 8
        mov     esi, eax
        xor     edi, edi

.toUpper:
        mov     al, BYTE [esi+edi*1]
        test    al, al
        jz      .removeExtension

        inc     edi

        cmp     al, 'a'
        jl      .toUpper
        cmp     al, 'z'
        jg      .toUpper
        sub     al, 0x20
        mov     [esi+edi-1], al
        jmp     .toUpper

.removeExtension:
        sub     edi, 4
        mov     BYTE [esi+edi], 0

        push    0x4+0x120                                                  ; sizeof(var_timestamp)+sizeof(var_patchname)
        call    operator_new
        add     esp, 0x4
        mov     edi, eax

        mov     eax, [esp+stackoffset+var_timestamp]
        mov     [edi], eax

        lea     eax, [esp+stackoffset+var_patchname]
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
        jz      .back

        push    zCModel__AniAttachmentCompare                              ; Abuse convenient comparator
        push    0x4
        push    DWORD [NINJA_PATCH_ARRAY+zCArray.numInArray]
        push    DWORD [NINJA_PATCH_ARRAY+zCArray.array]
        call    _qsort
        add     esp, 0x10

        push    ninja_freeVdfArray
        call    _atexit
        add     esp, 0x4

        reportToSpy " NINJA: Patches found in sorted order:"

        xor     edi, edi

.arrayLoop:
        mov     eax, [NINJA_PATCH_ARRAY+zCArray.numInArray]
        cmp     edi, eax
        jge     .back

        sub     esp, 0x14
        mov     ecx, esp
        push    NINJA_AUTHOR_PREFIX
        call    zSTRING__zSTRING
    addStack 4
        push    char_indent
        call    zSTRING__operator_plusEq
    addStack 4
        mov     esi, [NINJA_PATCH_ARRAY+zCArray.array]
        mov     esi, [esi+edi*0x4]
        lea     esi, [esi+0x4]
        add     esi, 0x6                                                   ; Cut off 'NINJA_'
        push    esi
        call    zSTRING__operator_plusEq
    addStack 4
        push    ecx
        call    zERROR__Message
    addStack 4
        mov     ecx, esp
        call    zSTRING___zSTRING
        add     esp, 0x14

        inc     edi
        jmp     .arrayLoop

.back:
        pop     edi
        pop     esi
        pop     ecx
        pop     eax
        add     esp, var_total
    verifyStackoffset

        mov     ecx, zCRenderManager_zrenderMan
        jmp     g1g2(0x6036E7,0x632A0B)
