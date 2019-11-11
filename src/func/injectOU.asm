; void __stdcall ninja_injectOU(char *)
; Load output units library
global ninja_injectOU
ninja_injectOU:
        resetStackoffset
        %assign var_total     0x2C
        %assign var_buffer   -0x2C                                         ; char[0x8]
        %assign var_before   -0x24                                         ; int
        %assign var_blocks   -0x20                                         ; zCArraySort *
        %assign var_lib      -0x1C                                         ; zCCSLib *
        %assign var_file     -0x18                                         ; zFILE *
        %assign var_string   -0x14                                         ; zString
        %assign arg_1        +0x4                                          ; char *
        %assign arg_total     0x4

        sub     esp, var_total
        pusha

        push    DWORD [esp+stackoffset+arg_1]
        lea     ecx, [esp+stackoffset+var_string]
        call    zSTRING__zSTRING
    addStack 4

        push    ecx
        mov     ecx, DWORD [zCObjectFactory_zfactory]
        mov     eax, [ecx]
        call    DWORD [eax+zCObjectFactory__CreateZFile_offset]
    addStack 4
        mov     [esp+stackoffset+var_file], eax
        mov     ecx, eax
        mov     eax, [eax]
        call    DWORD [eax+zFILE_VDFS__Exists_offset]
        test    al, al
        jz      .funcEnd

        sub     esp, 0x14
        mov     ecx, esp
        push    NINJA_INJECT
        call    zSTRING__zSTRING
    addStack 4
        mov     eax, DWORD [esp+stackoffset+var_string+0x8]
        add     eax, 0x7                                                   ; Cut off '\NINJA\'
        push    eax
        call    zSTRING__operator_plusEq
    addStack 4
        push    ecx
        call    zERROR__Message
    addStack 4
        mov     ecx, esp
        call    zSTRING___zSTRING
        add     esp, 0x14

        call    zCCSLib___CreateNewInstance
        mov     [esp+stackoffset+var_lib], eax

        push    0
        mov     ecx, [esp+stackoffset+var_file]
        mov     eax, [ecx]
        call    DWORD [eax+zFILE_VDFS__Open_offset]
    addStack 4

        push    0x0
        push    DWORD [esp+stackoffset+var_file]
        mov     ecx, zCArchiverFactory_zarcFactory
        call    zCArchiverFactory__CreateArchiverRead
    addStack 2*4
        test    eax, eax
        jz      .loaded

        mov     esi, eax
        push    edx
        mov     edx, [esp+stackoffset+var_lib]
        mov     ecx, esi
        mov     eax, [ecx]
        call    DWORD [eax+zCArchiver__ReadObject_offset]
        pop     edx
        mov     ecx, esi
        mov     eax, [ecx]
        call    DWORD [eax+zCArchiver__Close_offset]

        mov     eax, [esi+0x4]
        dec     eax
        mov     [esi+0x4], eax
        test    eax, eax
        jg      .loaded
        mov     ecx, esi
        push    0x1
        mov     eax, [ecx]
        call    DWORD [eax+zCArchiver__deleting_destructor_offset]
    addStack 4

.loaded:
        mov     ecx, [esp+stackoffset+var_file]
        mov     eax, [ecx]
        call    DWORD [eax+zFILE_VDFS__Close_offset]

        mov     ecx, DWORD [oCGame_ogame]
        mov     ecx, [ecx+0x4]                                             ; ogame->csman
        mov     ecx, [ecx+0x68]                                            ; csman->cslib
        add     ecx, 0x2C                                                  ; cslib->blocks
        mov     [esp+stackoffset+var_blocks], ecx
        mov     ecx, [ecx+zCArraySort.numInArray]
        mov     [esp+stackoffset+var_before], ecx

        mov     esi, [esp+stackoffset+var_lib]
        add     esi, 0x2C
        xor     edi, edi

.loopBlocks:
        mov     eax, [esi+zCArraySort.numInArray]
        cmp     edi, eax
        jge     .loopBlocksEnd

        mov     eax, [esi+zCArraySort.array]
        mov     edx, [eax+edi*0x4]                                         ; zCCSBlock *
        inc     edi

        push    edx
        lea     eax, [edx+0x30]
        push    eax
        mov     ecx, DWORD [oCGame_ogame]
        mov     ecx, [ecx+0x4]                                             ; ogame->csman
        call    zCCSManager__LibValidateOU
    addStack 4
        pop     edx
        test    eax, eax
        jl      .addBlock

        push    eax
        push    edx
        lea     ecx, [esp+stackoffset+var_string]
        call    zSTRING___zSTRING
        lea     ecx, [esp+stackoffset+var_string]
        push    NINJA_OVERWRITING
        call    zSTRING__zSTRING
    addStack 4
        mov     edx, [esp]
        lea     eax, [edx+0x30]
        mov     eax, [eax+0x8]
        push    eax
        call    zSTRING__operator_plusEq
    addStack 4
        push    ecx
        call    ninja_debugMessage
    addStack 4
        pop     edx
        pop     eax

        mov     ecx, [esp+stackoffset+var_blocks]
        mov     ecx, [ecx+zCArraySort.array]
        push    DWORD [ecx+eax*0x4]
        mov     [ecx+eax*0x4], edx
        mov     eax, [edx+0x4]
        inc     eax
        mov     [edx+0x4], eax
        pop     ecx
        mov     eax, [ecx+0x4]
        dec     eax
        mov     [ecx+0x4], eax
        test    eax, eax
        jg      .loopBlocks
        push    0x1
        call    zCCSBlock__deleting_destructor
    addStack 4
        jmp     .loopBlocks

.addBlock:
        push    edx
        lea     ecx, [esp+stackoffset+var_string]
        call    zSTRING___zSTRING
        lea     ecx, [esp+stackoffset+var_string]
        push    NINJA_OU_ADD
        call    zSTRING__zSTRING
    addStack 4
        mov     edx, [esp]
        lea     eax, [edx+0x30]
        mov     eax, [eax+0x8]
        push    eax
        call    zSTRING__operator_plusEq
    addStack 4
        push    ecx
        call    ninja_debugMessage
    addStack 4
        pop     edx

        push    edx
        mov     ecx, DWORD [oCGame_ogame]
        mov     ecx, [ecx+0x4]                                             ; ogame->csman
        call    zCCSManager__LibAddOU
    addStack 4
        jmp     .loopBlocks

.loopBlocksEnd:
        mov     ecx, [esp+stackoffset+var_blocks]
        call    zCArraySort_int___QuickSort

        mov     ecx, [esp+stackoffset+var_lib]
        mov     eax, [ecx+0x4]
        dec     eax
        mov     [ecx+0x4], eax
        test    eax, eax
        jg      .reportChanges
        push    0x1
        call    zCCSLib__deleting_destructor
    addStack 4

.reportChanges:
        lea     ecx, [esp+stackoffset+var_string]
        call    zSTRING___zSTRING
        lea     ecx, [esp+stackoffset+var_string]
        push    NINJA_OU_BEFORE
        call    zSTRING__zSTRING
    addStack 4

        push    0xA
        lea     ecx, [esp+stackoffset+var_buffer]
        push    ecx
        push    DWORD [esp+stackoffset+var_before]
        call    _itoa
        add     esp, 0xC
        push    eax
        lea     ecx, [esp+stackoffset+var_string]
        call    zSTRING__operator_plusEq
    addStack 4
        push    ecx
        call    zERROR__Message
    addStack 4

        lea     ecx, [esp+stackoffset+var_string]
        call    zSTRING___zSTRING
        lea     ecx, [esp+stackoffset+var_string]
        push    NINJA_OU_AFTER
        call    zSTRING__zSTRING
    addStack 4

        push    0xA
        lea     ecx, [esp+stackoffset+var_buffer]
        push    ecx
        mov     ecx, [esp+stackoffset+var_blocks]
        push    DWORD [ecx+zCArraySort.numInArray]
        call    _itoa
        add     esp, 0xC
        push    eax
        lea     ecx, [esp+stackoffset+var_string]
        call    zSTRING__operator_plusEq
    addStack 4
        push    ecx
        call    zERROR__Message
    addStack 4

.funcEnd:
        mov     ecx, [esp+stackoffset+var_file]
        mov     eax, [ecx]
        push    0x1
        call    DWORD [eax+zFILE_VDFS__deleting_destructor_offset]
    addStack 4

        lea     ecx, [esp+stackoffset+var_string]
        call    zSTRING___zSTRING

        popa
        add     esp, var_total
        ret     arg_total
    verifyStackoffset
