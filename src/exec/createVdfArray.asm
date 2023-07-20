; Find all Ninja VDF and create an array of them

global createVdfArray
createVdfArray:
        resetStackoffset
        %assign var_total       0x284
        %assign var_retstr     -0x284                                      ; zString             0x014
        %assign var_ignoreList -0x270                                      ; zString             0x014
        %assign var_nameSpaced -0x25C                                      ; char *
        %assign var_inNinjaDir -0x258                                      ; bool
        %assign var_root       -0x254                                      ; char *
        %assign var_header     -0x250                                      ; VDFheader           0x128
        %assign var_filehndl   -0x128                                      ; FILE *
        %assign var_filevdf    -0x124                                      ; char *
        %assign var_patchname  -0x120                                      ; char *
        %assign var_filedata   -0x11C                                      ; finddata_t          0x118
        %assign var_findhndl   -0x4                                        ; HANDLE

        sub     esp, var_total
        pusha

        mov     ecx, zERROR_zerr                                           ; Turn on logging if zSpy is running
        call    zERROR__SearchForSpy
        test    eax, eax
        jz      .start
        mov     al,0x5
        cmp     BYTE [zERROR_zerr+0x20], al                                ; zerr.filter_level
        jge     .start
        mov     BYTE [zERROR_zerr+0x20], al

.start:
        sub     esp, 0x14                                                  ; Send information to zSpy
        mov     ecx, esp
        push    NINJA_LOADING_MSG
        call    zSTRING__zSTRING
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

%if GOTHIC_BASE_VERSION == 1 || GOTHIC_BASE_VERSION == 2
        mov     al, [SystemPack_version_info+g1g2(0xD,0x0,0x0,0xB)]          ; Check for old Ninja system
        cmp     al, 'N'
        jnz     .checkScripts

        sub     esp, 0x14
        mov     ecx, esp
        push    NINJA_OUTDATED_PATCH
        call    zSTRING__zSTRING
    addStack 4
        push    ecx
        call    zERROR__Fatal
    addStack 4
        ; mov     ecx, esp                                                 ; Never reached: Safe some space
        ; call    zSTRING___zSTRING
        add     esp, 0x14
%endif

.checkScripts:
        call    zFILE_VDFS__LockCriticalSection
        push    VDF_VIRTUAL | VDF_PHYSICAL | VDF_PHYSICALFIRST
        push    NINJA_PATH_IKARUS
        call    DWORD [ds_vdf_fexists]
        add     esp, 0x8
        push    eax
        call    zFILE_VDFS__UnlockCriticalSection
        pop     eax
        test    eax, eax
        jg      .registerConsole

        sub     esp, 0x14
        mov     ecx, esp
        push    NINJA_MOUNTFAIL
        call    zSTRING__zSTRING
    addStack 4
        push    ecx
        call    zERROR__Fatal
    addStack 4
        ; mov     ecx, esp                                                 ; Never reached: Safe some space
        ; call    zSTRING___zSTRING
        add     esp, 0x14

.registerConsole:
        reportToSpy NINJA_REGISTER_CONSOLE

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

%if GOTHIC_BASE_VERSION == 1 || GOTHIC_BASE_VERSION == 2
        reportToSpy NINJA_READING_INI
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

        push    char_space                                                 ; Pad with spaces
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
%endif

.ignoreListEmpty:
        push    char_NUL
        lea     ecx, [esp+stackoffset+var_ignoreList]
        call    zSTRING__zSTRING
    addStack 4

.detect:
        reportToSpy NINJA_DETECTING_SORTING
        lea     ecx, [NINJA_PATCH_ARRAY-0x1]
        mov     [ecx], BYTE 0x0                                            ; Null terminated char string
        mov     ecx, NINJA_PATCH_ARRAY
        call    zCArray_int___zCArray_int_

        push    0x120                                                      ; Allocate data
        call    operator_new
        add     esp, 0x4
        mov     [esp+stackoffset+var_patchname], eax
        push    0x104
        call    operator_new
        add     esp, 0x4
        mov     [esp+stackoffset+var_filevdf], eax
        push    0x41
        call    operator_new
        add     esp, 0x4
        mov     [esp+stackoffset+var_nameSpaced], eax

        lea     esi, [esp+stackoffset+var_filedata]                        ; Open the actual VDF
        push    esi
        push    NINJA_PATH_VDF
        call    _findfirst
        add     esp, 0x8

        cmp     eax, INVALID_HANDLE_VALUE
        jz      .back

        mov     [esp+stackoffset+var_findhndl], eax

.fileLoopStart:
        lea     esi, [esp+stackoffset+var_filedata+finddata_t.name]        ; Construct patch name from VDF file name
        push    esi
        push    DWORD [esp+stackoffset+var_patchname]
        call    DWORD [ds_lstrcpyA]
    addStack 2*4
        mov     esi, eax
        xor     edi, edi

.toUpper:
        mov     al, BYTE [esi+edi]
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
        sub     edi, 0x4
        mov     BYTE [esi+edi], 0x0

        push    NINJA_PATH_DATA                                            ; Read the actual VDF
        push    DWORD [esp+stackoffset+var_filevdf]
        call    DWORD [ds_lstrcpyA]
    addStack 2*4
        lea     esi, [esp+stackoffset+var_filedata+finddata_t.name]
        push    esi
        push    eax
        call    DWORD [ds_lstrcatA]
    addStack 2*4
        push    char_rb
        push    eax
        call    _fopen
        add     esp, 0x8
        test    eax, eax
        jz      .nextFile

        mov     [esp+stackoffset+var_filehndl], eax

        push    DWORD [esp+stackoffset+var_filehndl]
        push    0x1
        push    0x128                                                      ; sizeof(VDFheader)
        lea     eax, [esp+stackoffset+var_header]
        push    eax
        call    _fread
        add     esp, 0x10

        xor     esi, esi
        push    0x10                                                       ; Verify VDF signature (G1)
        lea     eax, [esp+stackoffset+var_header+VDFheader.signature]
        push    eax
        push    NINJA_VDF_VERSION1
        call    _strncmp
        add     esp, 0xC
        test    eax, eax
        jz      .verifyEntrySize

        push    0x10                                                       ; Verify VDF signature (G2)
        lea     eax, [esp+stackoffset+var_header+VDFheader.signature]
        push    eax
        push    NINJA_VDF_VERSION2
        call    _strncmp
        add     esp, 0xC
        test    eax, eax
        jnz     .findClose

.verifyEntrySize:
        mov     eax, [esp+stackoffset+var_header+VDFheader.entrySize]      ; Verify the VDF header entry size
        cmp     eax, 0x50
        jnz     .findClose

        push    SEEK_SET                                                   ; Start of in root directory of VDF map
        push    DWORD [esp+stackoffset+var_header+VDFheader.rootOffset]
        push    DWORD [esp+stackoffset+var_filehndl]
        call    _fseek
        add     esp, 0xC

        mov     eax, [esp+stackoffset+var_header+VDFheader.numEntries]     ; Read VDF map
        mul     DWORD [esp+stackoffset+var_header+VDFheader.entrySize]
        push    eax
        push    eax
        call    operator_new
        add     esp, 0x4
        mov     DWORD [esp+stackoffset+var_root], eax
        pop     eax
        push    DWORD [esp+stackoffset+var_filehndl]
        push    0x1
        push    eax
        push    DWORD [esp+stackoffset+var_root]
        call    _fread
        add     esp, 0x10

        push    0x40                                                       ; Create patch name padded with spaces to 64
        push    ' '
        push    DWORD [esp+stackoffset+var_nameSpaced]
        call    _memset
        add     esp, 0xC
        mov     eax, [esp+stackoffset+var_nameSpaced]
        mov     BYTE [eax+0x40], 0x0                                       ; Null-terminated
        push    DWORD [esp+stackoffset+var_patchname]
        push    DWORD [esp+stackoffset+var_nameSpaced]
        call    DWORD [ds_lstrcpyA]
    addStack 2*4
        push    DWORD [esp+stackoffset+var_nameSpaced]
        call    DWORD [ds_lstrlenA]
    addStack 4
        mov     ecx, [esp+stackoffset+var_nameSpaced]
        mov     BYTE [ecx+eax], ' '                                        ; Overwrite null

        mov     edi, [esp+stackoffset+var_root]
        mov     BYTE [esp+stackoffset+var_inNinjaDir], 0x0
        xor     esi, esi

.findDirLoop:
        mov     eax, [edi+VDFentry.type]                                   ; Loop over VDF map to find the Ninja dir
        and     eax, VDF_TYPE_DIR
        test    eax, eax
        jz      .dirLoopNext

        mov     al, [esp+stackoffset+var_inNinjaDir]
        test    al, al
        jnz     .inNinjaDir

        push    0x9                                                        ; In root "directory" of the VDF
        lea     eax, [edi+VDFentry.name]
        push    eax
        push    NINJA_VDF_DIR_NAME
        call    _strncmp
        add     esp, 0xC
        test    eax, eax
        jnz     .dirLoopNext
        mov     BYTE [esp+stackoffset+var_inNinjaDir], 0x1
        mov     eax, [edi+VDFentry.offset]
        mul     DWORD [esp+stackoffset+var_header+VDFheader.entrySize]
        add     eax, [esp+stackoffset+var_root]
        mov     edi, eax
        jmp     .findDirLoop

.inNinjaDir:
        push    0x40                                                       ; In the Ninja "directory" of the VDF
        lea     eax, [edi+VDFentry.name]
        push    eax
        push    DWORD [esp+stackoffset+var_nameSpaced]
        call    _strncmp
        add     esp, 0xC
        test    eax, eax
        jnz     .dirLoopNext
        mov     esi, 0x1
        jmp     .findDirEnd                                                ; This patch is based on Ninja: confirmed

.dirLoopNext:
        mov     ecx, [edi+VDFentry.type]                                   ; Advance to next entry if not last one
        and     ecx, VDF_TYPE_LAST
        add     edi, DWORD [esp+stackoffset+var_header+VDFheader.entrySize]
        test    ecx, ecx
        jz      .findDirLoop

.findDirEnd:
        push    DWORD [esp+stackoffset+var_root]
        call    operator_delete
        add     esp, 0x4

.findClose:
        push    DWORD [esp+stackoffset+var_filehndl]
        call    _fclose
        add     esp, 0x4

        test    esi, esi
        jz      .nextFile

        lea     eax, [esp+stackoffset+var_header+VDFheader.comment]        ; Replace SEP padding with null character
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

        sub     esp, 0x14                                                  ; Find match in ignore list
        mov     ecx, esp
        push    char_space
        call    zSTRING__zSTRING
    addStack 4
        push    DWORD [esp+stackoffset+var_patchname]
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
        jl      .validateTimestamp

        sub     esp, 0x14
        mov     ecx, esp
        push    NINJA_IGNORING
        call    zSTRING__zSTRING
    addStack 4
        push    DWORD [esp+stackoffset+var_patchname]
        call    zSTRING__operator_plusEq
    addStack 4
        push    ecx
        call    zERROR__Message
    addStack 4
        mov     ecx, esp
        call    zSTRING___zSTRING
        add     esp, 0x14
        jmp     .nextFile

.validateTimestamp:
        mov     eax, [esp+stackoffset+var_header+VDFheader.timestamp]      ; Do not allow certain timestamps
        mov     ecx, MAX_VDF_TIME
        cmp     eax, ecx
        jae     .nextFile

.addToConsole:                                                             ; Add auto-completion for console
        sub     esp, 0x14
        mov     ecx, esp
        push    NINJA_CON_COMMAND
        call    zSTRING__zSTRING
    addStack 4
        push    char_space
        call    zSTRING__operator_plusEq
    addStack 4
        push    DWORD [esp+stackoffset+var_patchname]
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

        mov     eax, [esp+stackoffset+var_header+VDFheader.timestamp]
        mov     [edi], eax

        push    DWORD [esp+stackoffset+var_patchname]
        lea     eax, [edi+0x4]
        push    eax
        call    DWORD [ds_lstrcpyA]
    addStack 8

        lea     eax, [esp+stackoffset+var_header+VDFheader.comment]
        push    eax
        lea     eax, [edi+0x4+0x120]
        push    eax
        call    DWORD [ds_lstrcpyA]
    addStack 8

        sub     esp, 0x4
        mov     [esp], edi
        push    esp
        mov     ecx, NINJA_PATCH_ARRAY
        call    zCArray_int___InsertEnd                                    ; Finally add to the approved-patches array
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

        push    ninja_compareTimestampsUnsigned                            ; Unsigned timestamp comparator to sort array
        push    0x4
        push    DWORD [NINJA_PATCH_ARRAY+zCArray.numInArray]
        push    DWORD [NINJA_PATCH_ARRAY+zCArray.array]
        call    _qsort
        add     esp, 0x10

        push    ninja_freeVdfArray
        call    _atexit
        add     esp, 0x4

        reportToSpy NINJA_PATCHES_FOUND

        xor     edi, edi

.arrayLoop:
        mov     eax, [NINJA_PATCH_ARRAY+zCArray.numInArray]                ; Finally list all patches in zSpy
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
        push    DWORD [esp+stackoffset+var_patchname]                      ; Free the data
        call    operator_delete
        add     esp, 0x4
        push    DWORD [esp+stackoffset+var_filevdf]
        call    operator_delete
        add     esp, 0x4
        push    DWORD [esp+stackoffset+var_nameSpaced]
        call    operator_delete
        add     esp, 0x4
        lea     ecx, [esp+stackoffset+var_ignoreList]
        call    zSTRING___zSTRING

        popa
        add     esp, var_total
    verifyStackoffset

        push    char_zStartupWindowed
        jmp     g1g2(0x6019C1,0x62377E,0x6293DC,0x630B5C)+5


; int __cdecl ninja_compareTimestampsUnsigned(void const *, void const *)
; Inspired by zCModel::AniAttachmentCompare but with unsigned compare (jae instead of jge)
ninja_compareTimestampsUnsigned:
        resetStackoffset
        %assign arg_1      +0x4                                            ; void const *
        %assign arg_2      +0x8                                            ; void const *
        %assign arg_total   0x8                                            ; Unused: is __cdecl

        mov     eax, [esp+stackoffset+arg_1]
        mov     ecx, [eax]
        mov     eax, [ecx]
        mov     edx, [esp+stackoffset+arg_2]
        mov     ecx, [edx]
        mov     ecx, [ecx]
        cmp     eax, ecx
        ; jge     .arg1GEQ                                                 ; signed
        jae     .arg1GEQ                                                   ; unsigned
        or      eax, 0xFFFFFFFF
        ret
    verifyStackoffset

.arg1GEQ:
        xor     edx, edx
        ; cmp     eax, ecx                                                 ; signed
        ; setg    dl
        cmp     ecx, eax                                                   ; unsigned
        setbe   dl
        mov     eax, edx
        ret
    verifyStackoffset
