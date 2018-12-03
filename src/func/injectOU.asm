; void __stdcall ninja_injectOU(char *)
; Load the output units
global ninja_injectOU
ninja_injectOU:
        resetStackoffset
        %assign var_total     0x14
        %assign var_string   -0x14                                         ; zString
        %assign arg_1        +0x4                                          ; char *
        %assign arg_total     0x4

        sub     esp, var_total
        push    eax
        push    ecx
        push    esi
        push    edi

        push    DWORD [esp+stackoffset+arg_1]
        call    DWORD [ds_lstrlenA]
    addStack 4
        mov     ecx, [esp+stackoffset+arg_1]
        sub     eax, 0x4                                                   ; Replace '.SRC' with '.csl'
        mov     BYTE [ecx+eax], 0
        push    char_csl
        push    ecx
        call    DWORD [ds_lstrcatA]
    addStack 2*4
        push    DWORD [esp+stackoffset+arg_1]
        lea     ecx, [esp+stackoffset+var_string]
        call    zSTRING__zSTRING
    addStack 4

        xor     edi, edi

.fileExists:
        push    ecx
        mov     ecx, DWORD [zCObjectFactory_zfactory]
        mov     ecx, [ecx]
        call    DWORD [ecx+zCObjectFactory__CreateZFile_offset]
    addStack 4
        mov     esi, eax
        mov     eax, [esi]
        mov     ecx, esi
        call    DWORD [eax+zFILE_VDFS__Exists_offset]
        test    al, al
        jnz     .loadCSLib

        test    edi, edi
        jnz     .funcEnd
        inc     edi

        mov     eax, [esi]
        push    0x1
        mov     ecx, esi
        call    DWORD [eax+zFILE_VDFS__deleting_destructor_offset]
    addStack 4
        sub     esp, 0x14
        mov     ecx, esp
        push    char_g1g2
        call    zSTRING__zSTRING
    addStack 4
        push    0x0                                                        ; enum zTSTR_KIND
        push    ecx
        lea     ecx, [esp+stackoffset+var_string]
        call    zSTRING__Delete_str
    addStack 2*4
        mov     ecx, esp
        call    zSTRING___zSTRING
        add     esp, 0x14
        lea     ecx, [esp+stackoffset+var_string]
        jmp     .fileExists

.loadCSLib:
        sub     esp, 0x14
        mov     ecx, esp
        push    NINJA_INJECT_SRC
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

        ; Create new zCCSLib ...

        push    0
        mov     eax, [esi]
        mov     ecx, esi
        call    DWORD [eax+zFILE_VDFS__Open_offset]
    addStack 4

        ; Load zCCSLib ...

        mov     eax, [esi]
        mov     ecx, esi
        call    DWORD [eax+zFILE_VDFS__Close_offset]

.funcEnd:
        mov     eax, [esi]
        push    0x1
        mov     ecx, esi
        call    DWORD [eax+zFILE_VDFS__deleting_destructor_offset]
    addStack 4

        lea     ecx, [esp+stackoffset+var_string]
        call    zSTRING___zSTRING

        pop     edi
        pop     esi
        pop     ecx
        pop     eax
        add     esp, var_total
        ret     arg_total
    verifyStackoffset
