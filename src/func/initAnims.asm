; void __stdcall ninja_initAnims(char *)
; Initialize the animation ninja
global ninja_initAnims
ninja_initAnims:
        resetStackoffset
        %assign var_total     0x14
        %assign var_string   -0x14                                         ; zString
        %assign arg_1        +0x4                                          ; char *
        %assign arg_total     0x4

        sub     esp, var_total
        push    eax
        push    ecx
        push    esi

        push    DIR_ANIMS
        mov     ecx, DWORD [zCOption_zoptions]
        call    zCOption__GetDirString
    addStack 4
        mov     eax, [eax+0x8]
        push    eax
        lea     ecx, [esp+stackoffset+var_string]
        call    zSTRING__zSTRING
    addStack 4

        push    DWORD [esp+stackoffset+arg_1]
        call    [ds_lstrlenA]
    addStack 4

        mov     ecx, [esp+stackoffset+arg_1]
        sub     eax, 3
        mov     BYTE [eax+ecx*1], 0
        dec     eax
        mov     BYTE [eax+ecx*1], '_'
        add     ecx, 0x17                                                  ; Cut off "\NINJA\ANIMATION_NINJA_"
        push    ecx                                                        ; "[NAME]_"
        lea     ecx, [esp+stackoffset+var_string]
        call    zSTRING__operator_plusEq
    addStack 4

        lea     eax, [ebp+0xC]                                             ; modelPtrotype->name
        mov     eax, [eax+0x8]                                             ; name->ptr
        push    eax
        call    zSTRING__operator_plusEq
    addStack 4
        push    str_mds
        call    zSTRING__operator_plusEq
    addStack 4

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
        jz      .funcEnd

        sub     esp, 0x14
        mov     ecx, esp
        push    NINJA_LOAD_ANIM
        call    zSTRING__zSTRING
    addStack 4
        push    DWORD [esp+stackoffset+var_string+0x8]
        call    zSTRING__operator_plusEq
    addStack 4
        push    ecx
        call    zERROR__Message
    addStack 4
        mov     ecx, esp
        call    zSTRING___zSTRING
        add     esp, 0x14

        push    0
        mov     eax, [esi]
        mov     ecx, esi
        call    DWORD [eax+zFILE_VDFS__Open_offset]
    addStack 4

        push    DWORD [zFILE_cur_mds_file]
        mov     DWORD [zFILE_cur_mds_file], esi

        sub     esp, 0xC                                                   ; Create fake zCFileBIN
        mov     DWORD [esp], 0xFFFFFFFF                                    ; -1

.mds_loop_start:

        mov     eax, [esi]
        mov     ecx, esi
        call    DWORD [eax+zFILE_VDFS__Eof_offset]
        test    al, al
        jnz     .eof

        mov     eax, [esi]
        mov     ecx, esi
        push    str_mdlBuffer
        call    DWORD [eax+zFILE_VDFS__Read_offset]
    addStack 4
        mov     ecx, str_mdlBuffer
        call    zSTRING__Upper
        push    0x1
        push    char_doubleFSlash
        push    0
        mov     ecx, str_mdlBuffer
        call    zSTRING__Search
    addStack 3*4
        cmp     eax, 0xFFFFFFFF
        jnz     .mds_loop_start
        push    0x1
        push    strModel
        push    0
        mov     ecx, str_mdlBuffer
        call    zSTRING__Search
    addStack 3*4
        cmp     eax, 0xFFFFFFFF
        jz      .mds_loop_start
        mov     ecx, esp                                                   ; zCFileBIN * (ignored in Gothic 1)
%if GOTHIC_BASE_VERSION == 1
        nop
%elif GOTHIC_BASE_VERSION == 2
        push    ecx
%endif
        mov     ecx, ebp
        call    zCModelPrototype__ReadModel
%if GOTHIC_BASE_VERSION == 2
    addStack 4
%endif
        jnz     .mds_loop_start

.eof:

        add     esp, 0xC

        pop     eax
        mov     DWORD [zFILE_cur_mds_file], eax                            ; Restore

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

        pop     esi
        pop     ecx
        pop     eax
        add     esp, var_total
        ret     arg_total
    verifyStackoffset
