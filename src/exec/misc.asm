; Miscellaneous executive code

global setVobToTransient
setVobToTransient:
    resetStackoffset 0x14
        push    ecx
        push    eax
        push    esi

        push    eax
        mov     ecx, zCParser_parser
        call    zCParser__GetIndex
    addStack 4
        test    eax, eax
        jl      .back
        mov     esi, eax

        sub     esp, 0x14
        mov     ecx, esp
        push    char_ndivider_symb
        call    zSTRING__zSTRING
    addStack 4
        push    ecx
        mov     ecx, zCParser_parser
        call    zCParser__GetSymbol_str
    addStack 4
        test    eax, eax
        jz      .cleanup
        mov     eax, [eax+zCPar_Symbol_content_offset]
        cmp     esi, eax
        jl      .cleanup

    %if GOTHIC_BASE_VERSION == 1
        or      BYTE [ebp+0xF5], 0x1                                       ; zCVob.dontwritetoarchive = True
    %elif GOTHIC_BASE_VERSION == 2
        or      BYTE [ebp+0x114], 0x10                                     ; zCVob.dontwritetoarchive = True
    %endif

        mov     ecx, esp
        call    zSTRING___zSTRING
        mov     ecx, esp
        push    NINJA_IGNORING
        call    zSTRING__zSTRING
    addStack 4
        mov     eax, [esp+0x18]                                            ; zCObject->objectname
        push    DWORD [eax+0x8]                                            ; str->ptr
        call    zSTRING__operator_plusEq
    addStack 4
        push    ecx
        call    zERROR__Message
    addStack 4

.cleanup:
        mov     ecx, esp
        call    zSTRING___zSTRING
        add     esp, 0x14

.back:
        pop     esi
        pop     eax
        pop     ecx
    verifyStackoffset 0x14

        ; Jump back
        mov     esi, [eax+0xC]
        mov     ecx, ebp
        jmp     g1g2(0x5F638D,0x62485D)
