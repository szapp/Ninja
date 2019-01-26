; Find all Ninja VDF and create an array of them

global createVdfArray
createVdfArray:
        resetStackoffset
        %assign var_total       0x470
        %assign var_retstr     -0x470                                      ; zString
        %assign var_ignoreList -0x45C                                      ; zString
        %assign var_comment    -0x448                                      ; char[0x100]         0x100
        %assign var_timestamp  -0x348                                      ; int
        %assign var_filehndl   -0x344                                      ; FILE *
        %assign var_filevdf    -0x340                                      ; char[MAX_PATH]      0x104
        %assign var_patchname  -0x23C                                      ; char[MAX_PATH+28]   0x120
        %assign var_filedata   -0x11C                                      ; finddata_t          0x118
        %assign var_findhndl   -0x4                                        ; HANDLE

        sub     esp, var_total
        push    eax
        push    ecx
        push    esi
        push    edi

        mov     ecx, zERROR_zerr
        call    zERROR__SearchForSpy
        test    eax, eax
        jz      .start
        cmp     BYTE [zERROR_zerr+0x20], 0x5                               ; zerr.filter_level
        jge     .start
        mov     BYTE [zERROR_zerr+0x20], 0x5

.start:
        sub     esp, 0x14
        mov     ecx, esp
        push    NINJA_LOADING_MSG
        call    zSTRING__zSTRING
    addStack 4
        push    NINJA_VERSION_CHAR_built
        call    zSTRING__operator_plusEq
    addStack 4
        sub     esp, 0x80
        push    esp
        call    ninja_Y3JjMzI
    addStack 4
        push    eax
        call    zSTRING__operator_plusEq
    addStack 4
        push    ecx
        call    zERROR__Message
    addStack 4
        add     esp, 0x80
        mov     ecx, esp
        call    zSTRING___zSTRING
        add     esp, 0x14

        ; Partial version string for main menu in case of SystemPack
        %substr .nversion1 NINJA_VERSION 2,1
        %substr .nversion2 NINJA_VERSION 4,1
        %strcat .nversion .nversion1 '.' .nversion2 ' '

        mov     al, [SystemPack_version_info+0xB]
        cmp     al, 'N'
        jnz     .setVersionInfo

        sub     esp, 0x14
        mov     ecx, esp
        push    NINJA_OUTDATED_PATCH
        call    zSTRING__zSTRING
    addStack 4
        push    ecx
        call    zERROR__Fatal
    addStack 4
        mov     ecx, esp
        call    zSTRING___zSTRING
        add     esp, 0x14

.setVersionInfo:
        mov     eax, SystemPack_version_info
        mov     ecx, [eax+g1g2(0xD,0xB)]
        mov     DWORD [eax], g1g2('1.08','2.6f')
        mov     DWORD [eax+0x4], g1g2('k-S ','x-S ')
        mov     DWORD [eax+0x7], ecx
        mov     WORD [eax+0xA], '-N'
        mov     DWORD [eax+0xC], .nversion
        mov     BYTE [eax+0xF], 0

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

        reportToSpy " NINJA: Reading ignore list from ini"
        mov     esi, DWORD [zCOption_zgameoptions]
        test    esi, esi
        jz      .ignoreListEmpty
        sub     esp, 0x14
        mov     ecx, esp
        push    char_settings
        call    zSTRING__zSTRING
    addStack 4
        push    0x0
        push    char_zOPT_ignorePatches
        push    ecx
        lea     ecx, [esp+stackoffset+var_retstr]
        push    ecx                                                        ; retstr *
        mov     ecx, esi
        call    zCOption__ReadString
    addStack 4*4
        mov     ecx, esp
        call    zSTRING___zSTRING
        add     esp, 0x14
        mov     eax, [esp+stackoffset+var_retstr+0x8]
        test    eax, eax
        jz      .ignoreListEmpty

        push    char_space
        lea     ecx, [esp+stackoffset+var_ignoreList]
        call    zSTRING__zSTRING
    addStack 4
        push    DWORD [esp+stackoffset+var_retstr+0x8]
        call    zSTRING__operator_plusEq
    addStack 4
        push    char_space
        call    zSTRING__operator_plusEq
    addStack 4
        call    zSTRING__Upper
        lea     ecx, [esp+stackoffset+var_retstr]
        call    zSTRING___zSTRING
        jmp     .detect

.ignoreListEmpty:
        push    char_NUL
        lea     ecx, [esp+stackoffset+var_ignoreList]
        call    zSTRING__zSTRING
    addStack 4

.detect:
        reportToSpy " NINJA: Detecting and sorting Ninja patches (VDF)"
        lea     ecx, [NINJA_PATCH_ARRAY-0x1]
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
        jz      .nextFile

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

        push    SEEK_SET
        push    VDFheader.comment
        push    DWORD [esp+stackoffset+var_filehndl]
        call    _fseek
        add     esp, 0xC

        push    DWORD [esp+stackoffset+var_filehndl]
        push    0x1
        push    0x100                                                      ; sizeof(VDFheader.comment)
        lea     eax, [esp+stackoffset+var_comment]
        push    eax
        call    _fread
        add     esp, 0x10

        push    DWORD [esp+stackoffset+var_filehndl]
        call    _fclose
        add     esp, 0x4

        lea     eax, [esp+stackoffset+var_comment]
        xor     edi, edi

.replaceSEP:
        cmp     edi, 0xFF
        jge     .setNullByte
        cmp     [eax], BYTE char_sep
        jz      .setNullByte

        inc     edi
        inc     eax
        jmp     .replaceSEP

.setNullByte:
        mov     [eax], BYTE 0                                              ; Terminate char properly

        lea     esi, [esp+stackoffset+var_filedata+finddata_t.name+0x6]    ; Cut off 'NINJA_'
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
        mov     [esi+edi-0x1], al
        jmp     .toUpper

.removeExtension:
        sub     edi, 4
        mov     BYTE [esi+edi], 0

        sub     esp, 0x14
        mov     ecx, esp
        push    char_space
        call    zSTRING__zSTRING
    addStack 4
        lea     eax, [esp+stackoffset+var_patchname]
        push    eax
        call    zSTRING__operator_plusEq
    addStack 4
        push    char_space
        call    zSTRING__operator_plusEq
    addStack 4
        push    0x1
        push    DWORD [ecx+0x8]
        push    0x0
        lea     ecx, [esp+stackoffset+var_ignoreList]
        call    zSTRING__Search
    addStack 3*4
        mov     esi, eax
        mov     ecx, esp
        call    zSTRING___zSTRING
        add     esp, 0x14
        test    esi, esi
        jl      .addToConsole

        sub     esp, 0x14
        mov     ecx, esp
        push    NINJA_IGNORING
        call    zSTRING__zSTRING
    addStack 4
        lea     eax, [esp+stackoffset+var_patchname]
        push    eax
        call    zSTRING__operator_plusEq
    addStack 4
        push    ecx
        call    zERROR__Message
    addStack 4
        mov     ecx, esp
        call    zSTRING___zSTRING
        add     esp, 0x14
        jmp     .nextFile

.addToConsole:
        sub     esp, 0x14
        mov     ecx, esp
        push    NINJA_CON_COMMAND
        call    zSTRING__zSTRING
    addStack 4
        push    char_space
        call    zSTRING__operator_plusEq
    addStack 4
        lea     eax, [esp+stackoffset+var_patchname]
        push    eax
        call    zSTRING__operator_plusEq
    addStack 4
        push    zSTRING_empty
        push    eax
        mov     ecx, zCConsole_zcon
        call    zCConsole__Register
    addStack 2*4
        mov     ecx, esp
        call    zSTRING___zSTRING
        add     esp, 0x14

        push    0x4+0x120+0x100                                            ; var_timestamp + var_patchname + var_comment
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

        lea     eax, [esp+stackoffset+var_comment]
        push    eax
        lea     eax, [edi+0x4+0x120]
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

.nextFile:
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

        reportToSpy " NINJA: Patches found (sorted):"

        xor     edi, edi

.arrayLoop:
        mov     eax, [NINJA_PATCH_ARRAY+zCArray.numInArray]
        cmp     edi, eax
        jge     .back

        sub     esp, 0x14
        mov     ecx, esp
        push    NINJA_LOADING_PREFIX
        call    zSTRING__zSTRING
    addStack 4
        mov     esi, [NINJA_PATCH_ARRAY+zCArray.array]
        mov     esi, [esi+edi*0x4]
        lea     esi, [esi+0x4]
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
        lea     ecx, [esp+stackoffset+var_ignoreList]
        call    zSTRING___zSTRING
        pop     edi
        pop     esi
        pop     ecx
        pop     eax
        add     esp, var_total
    verifyStackoffset

        push    char_zStartupWindowed
        jmp     g1g2(0x6019C6,0x630B61)
