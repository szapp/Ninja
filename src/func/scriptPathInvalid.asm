; void __stdcall ninja_scriptPathInvalid(zCParser *, char *)
; Verify correct script file path
global ninja_scriptPathInvalid
ninja_scriptPathInvalid:
        resetStackoffset
        %assign arg_1      +0x4                                            ; zCParser *
        %assign arg_2      +0x8                                            ; char *
        %assign arg_total   0x8

        push    esi
        push    ecx

        reportToSpy NINJA_VERIFY_PATH
        mov     esi, [esp+stackoffset+arg_1]

        mov     eax, [esi+zCParser_file_offset+zCArray.numInArray]
        dec     eax
        mov     ecx, [esi+zCParser_file_offset+zCArray.array]
        mov     ecx, [ecx+eax*0x4]                                         ; zCPar_File
        mov     eax, [ecx+0xC]
        test    eax, eax
        jz      .funcEnd

        push    DWORD [esp+stackoffset+arg_2]
        push    eax
        call    DWORD [ds_lstrcmpiA]
    addStack 2*4
        test    eax, eax
        jz      .funcEnd

        sub     esp, 0x14
        mov     ecx, esp
        push    NINJA_LOADING_PREFIX
        call    zSTRING__zSTRING
    addStack 4
        push    NINJA_PATH_INVALID
        call    zSTRING__operator_plusEq
    addStack 4
        push    eax
        call    zERROR__Fatal
    addStack 4
        mov     ecx, esp
        call    zSTRING___zSTRING
        add     esp, 0x14
        mov     eax, 0x1

.funcEnd:
        pop     ecx
        pop     esi
        verifyStackoffset
        ret     arg_total
