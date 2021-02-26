; Miscellaneous executive code

global setVobToTransient
setVobToTransient:
        resetStackoffset                                                   ; 0x14
        %assign var_total   0x4
        %assign var_object -0x4                                            ; zString *

        sub     esp, var_total
        pusha

        mov     ecx, [ebp]
        cmp     ecx, oCNpc__vftable
        jnz     .back

        mov     [esp+stackoffset+var_object], eax
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
        call    zCParser__GetIndex
    addStack 4
        test    eax, eax
        jl      .cleanup

        cmp     esi, eax
        jl      .cleanup

        mov     ecx, esp                                                   ; Same for ending divider
        push    char_ndivider2_symb
        call    zSTRING__zSTRING
    addStack 4
        push    ecx
        mov     ecx, zCParser_parser
        call    zCParser__GetIndex
    addStack 4
        test    eax, eax
        jl      .cleanup

        cmp     esi, eax
        jg      .cleanup

    %if GOTHIC_BASE_VERSION == 1
        test    BYTE [ebp+0xF5], 0x1                                       ; zCVob.dontwritetoarchive
    %elif GOTHIC_BASE_VERSION == 2
        test    BYTE [ebp+0x114], 0x10                                     ; zCVob.dontwritetoarchive
    %endif
        jnz     .cleanup

        mov     ecx, esp
        push    NINJA_IGNORING
        call    zSTRING__operator_eq
    addStack 4
        mov     eax, [esp+stackoffset+var_object]                          ; zCObject->objectname, originally at eax
        push    DWORD [eax+0x8]                                            ; str->ptr
        call    zSTRING__operator_plusEq
    addStack 4
        push    ecx
        call    zERROR__Message
    addStack 4

    %if GOTHIC_BASE_VERSION == 1
        or      BYTE [ebp+0xF5], 0x1                                       ; zCVob.dontwritetoarchive = True
    %elif GOTHIC_BASE_VERSION == 2
        or      BYTE [ebp+0x114], 0x10                                     ; zCVob.dontwritetoarchive = True
    %endif

.cleanup:
        mov     ecx, esp
        call    zSTRING___zSTRING
        add     esp, 0x14

.back:
        popa
        add     esp, var_total
    verifyStackoffset                                                      ; 0x14

        ; Jump back
        mov     esi, [eax+0xC]
        mov     ecx, ebp
        jmp     g1g2(0x5F638D,0x62485D)


global checkNpcTransient1
checkNpcTransient1:
    resetStackoffset g1g2(0x5C,0x94)
        call    DWORD [edx+0x104]                                          ; oCNpc.IsSelfPlayer(void)
        test    eax, eax
        jnz     .back

    %if GOTHIC_BASE_VERSION == 1
        test    BYTE [ecx+0xF5], 0x1                                       ; zCVob.dontwritetoarchive
    %elif GOTHIC_BASE_VERSION == 2
        test    BYTE [ecx+0x114], 0x10                                     ; zCVob.dontwritetoarchive
    %endif
        jz      .back
        mov     eax, 0x1
    verifyStackoffset g1g2(0x5C,0x94)

.back:
        jmp     g1g2(0x6D652A,0x77F66A)+6


global checkNpcTransient2
checkNpcTransient2:
    resetStackoffset g1g2(0x5C,0x94)
        call    DWORD [eax+0x104]                                          ; oCNpc.IsSelfPlayer(void)
        test    eax, eax
        jnz     .back

    %if GOTHIC_BASE_VERSION == 1
        test    BYTE [ecx+0xF5], 0x1                                       ; zCVob.dontwritetoarchive
    %elif GOTHIC_BASE_VERSION == 2
        test    BYTE [ecx+0x114], 0x10                                     ; zCVob.dontwritetoarchive
    %endif
        jz      .back
        mov     eax, 0x1
    verifyStackoffset g1g2(0x5C,0x94)

.back:
        jmp     g1g2(0x6D65A3,0x77F6E1)+6


global removeInvalidNpcs
removeInvalidNpcs:
    resetStackoffset g1g2(0x58,0x8C)
        push    ebx
        push    edx

        test    esi, esi
        jz      .back

        push    ecx
        mov     eax, [esi]
        mov     ecx, esi
        call    DWORD [eax]
        push    eax
        push    oCNpc__classDef
        call    zCObject__CheckInheritance
        add     esp, 0x8
        test    eax, eax
        pop     ecx
        jz      .back

        mov     eax, [esi+g1g2(0x7B0,0x770)]                               ; oCNpc.instance
        test    eax, eax
        jge     .back

        reportToSpy NINJA_REMOVE_NPC
        push    char_meatbug_mds
        lea     ecx, [esi+g1g2(0x07B4,0x774)]                              ; oCNpc.mds_name
        call    zSTRING__zSTRING
    addStack 4
        mov     ecx, [esp+stackoffset+g1g2(-0x48,-0x7C)]
        mov     edx, esi
        call    oCWorld__RemoveFromLists

        mov     eax, [esi+4]                                               ; Decrease ref counter and possibly destruct
        dec     eax
        test    eax, eax
        mov     [esi+4], eax
        jg      .refGTzero
        mov     eax, [esi]
        push    0x1
        mov     ecx, esi
        call    DWORD [eax+0xC]
    addStack 4

.refGTzero:
        mov     ecx, 0x1
        xor     esi, esi

.back:
        pop     edx
        pop     ebx
    verifyStackoffset g1g2(0x58,0x8C)

        ; Jump back
%if GOTHIC_BASE_VERSION == 1
        test    ebx, ebx
        jnz     0x5F81A2
        test    ecx, ecx
        jmp     0x5F814F
%elif GOTHIC_BASE_VERSION == 2
        mov     eax, [esp+stackoffset-0x78]
        test    eax, eax
        jmp     0x626790
%endif


global removeInvalidNpcs2
removeInvalidNpcs2:
    resetStackoffset g1g2(0x5C,0x98)
        test    esi, esi
        jz      .back

        mov     eax, [esi+g1g2(0x7B0,0x770)]                               ; oCNpc.instance
        test    eax, eax
        jl      .remove
        call    oCWorld__InsertInLists
        jmp     .back

.remove:
        reportToSpy NINJA_REMOVE_NPC
        push    char_meatbug_mds
        lea     ecx, [esi+g1g2(0x07B4,0x774)]                              ; oCNpc.mds_name
        call    zSTRING__zSTRING
    addStack 4

.back:
    verifyStackoffset g1g2(0x5C,0x98)
        jmp     g1g2(0x6D6828,0x77F9C0)


global ninja_injectInfo
ninja_injectInfo:
        resetStackoffset                                                   ; 0xBC
        %assign var_total      0x2C
        %assign var_buffer    -0x2C                                        ; char[0x8]
        %assign var_before    -0x24                                        ; DWORD
        %assign var_info      -0x20                                        ; oCInfo *
        %assign var_infoList  -0x1C                                        ; zCListSort *
        %assign var_string    -0x18                                        ; zString
        %assign var_classID   -0x04                                        ; DWORD

        reportToSpy NINJA_INFO_INJECT

        sub     esp, var_total
        push    esi
        push    edi

        push    char_ndivider_symb
        lea     ecx, [esp+stackoffset+var_string]
        call    zSTRING__zSTRING
    addStack 4
        push    ecx
        mov     ecx, zCParser_parser
        call    zCParser__GetIndex
    addStack 4
        test    eax, eax
    verifyStackoffset var_total + 2*4
        jl      .back
        mov     esi, eax

        push    char_ndivider2_symb                                        ; Same for ending divider
        lea     ecx, [esp+stackoffset+var_string]
        call    zSTRING__operator_eq
    addStack 4
        push    ecx
        mov     ecx, zCParser_parser
        call    zCParser__GetIndex
    addStack 4
        test    eax, eax
    verifyStackoffset var_total + 2*4
        jl      .back
        mov     edi, eax

        push    zSTRING_infoClass
        mov     ecx, zCParser_parser
        call    zCParser__GetIndex
    addStack 4
        mov     [esp+stackoffset+var_classID], eax
        mov     ecx, DWORD [oCGame_ogame]
        call    oCGame__GetInfoManager
        add     eax, 0x4
        mov     [esp+stackoffset+var_infoList], eax
        mov     ecx, eax
        call    zCListSort__GetNumInList
        mov     [esp+stackoffset+var_before], eax

.next:
        inc     esi
        push    esi
        push    DWORD [esp+stackoffset+var_classID]
        mov     ecx, zCParser_parser
        call    zCParser__GetInstance
    addStack 2*4
        test    eax, eax
    verifyStackoffset var_total + 2*4
        jl      .report
        mov     esi, eax

        cmp     esi, edi                                                   ; Do not go beyond ending divider
        jg      .report

        lea     ecx, [esp+stackoffset+var_string]
        call    zSTRING___zSTRING
        sub     esp, 0x8
        push    esp
        lea     ecx, [esp+0x4]
        push    ecx
        push    esi
        lea     ecx, [esp+stackoffset+var_string]
        push    ecx
        mov     ecx, zCParser_parser
        call    zCParser__GetSymbolInfo
    addStack 4*4
        add     esp, 0x8
        mov     eax, [esp+stackoffset+var_infoList]

.inlist:
        test    eax, eax
        jz      .insert
        mov     ecx, [eax+0x4]                                             ; zCListSort->data
        mov     eax, [eax+0x8]                                             ; zCListSort->next
        test    ecx, ecx
        jz      .inlist
        push    eax
        add     ecx, 0x8                                                   ; oCInfo->name
        mov     ecx, [ecx+0x8]
        push    ecx
        push    DWORD [esp+stackoffset+var_string+0x8]
        call    DWORD [ds_lstrcmpiA]
    addStack 2*4
        test    eax, eax
        pop     eax
        jz      .next
        jmp     .inlist

.insert:
        sub     esp, 0x14
        mov     ecx, esp
        push    NIJNA_INFO_ADD
        call    zSTRING__zSTRING
    addStack 4
        push    DWORD [esp+stackoffset+var_string+0x8]
        call    zSTRING__operator_plusEq
    addStack 4
        push    ecx
        call    ninja_debugMessage
    addStack 4
        mov     ecx, esp
        call    zSTRING___zSTRING
        add     esp, 0x14

        push    0x5C                                                       ; sizeof(oCInfo)
        call    operator_new
        add     esp, 0x4
        mov     [esp+stackoffset+var_info], eax
        mov     ecx, eax
        call    oCInfo__oCInfo
        mov     eax, [esp+stackoffset+var_info]
        add     eax, 0x1C                                                  ; oCInfo->script
        push    eax
        push    esi
        mov     ecx, zCParser_parser
        call    zCParser__CreateInstance
    addStack 2*4
        push    esi
        mov     ecx, [esp+stackoffset+var_info]
        call    oCInfo__SetInstance
    addStack 4
        mov     ecx, [esp+stackoffset+var_info]
        call    oCInfo__DoCheck
        push    DWORD [esp+stackoffset+var_info]
        mov     ecx, [esp+stackoffset+var_infoList]
        call    zCListSort__InsertSort
    addStack 4
        jmp     .next

.report:
        lea     ecx, [esp+stackoffset+var_string]
        push    NINJA_INFO_BEFORE
        call    zSTRING__operator_eq
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
        push    NINJA_INFO_AFTER
        call    zSTRING__operator_eq
    addStack 4
        push    0xA
        lea     ecx, [esp+stackoffset+var_buffer]
        push    ecx
        mov     ecx, [esp+stackoffset+var_infoList]
        call    zCListSort__GetNumInList
        push    eax
        call    _itoa
        add     esp, 0xC
        push    eax
        lea     ecx, [esp+stackoffset+var_string]
        call    zSTRING__operator_plusEq
    addStack 4
        push    ecx
        call    zERROR__Message
    addStack 4

.back:
        lea     ecx, [esp+stackoffset+var_string]
        call    zSTRING___zSTRING
        pop     edi
        pop     esi
        add     esp, var_total
    verifyStackoffset                                                      ; 0xBC

        ; Jump back
        push    esi
        mov     ecx, oCMissionManager_misMan
        jmp     g1g2(0x63C7F4,0x6C6D24)


global createGlobalVarIfNotExist
createGlobalVarIfNotExist:
%if GOTHIC_BASE_VERSION == 1                                               ; zCParser::LoadGlobalVars differs for g1/g2
    resetStackoffset 0xC4
        jz      .createSymb
        mov     eax, [esi+0x20]                                            ; Rewritten what has been overwritten
        jmp     0x6EDADA

.createSymb:
        push    zPAR_TYPE_INT | 0x1
        lea     ecx, [esp+stackoffset-0x8C]
        push    DWORD [ecx+0x4]
        call    ninja_createSymbol
    addStack 2*4
        mov     esi, eax
    verifyStackoffset 0xC4

        ; Jump back
        jmp    0x6EDAF7

%elif GOTHIC_BASE_VERSION == 2
    resetStackoffset 0x1F0
        jle     0x797608
        mov     ecx, [esp+stackoffset-0x1B0]                               ; zCPar_Symbol *
        test    ecx, ecx
        jnz     0x7973E7

        or      eax, zPAR_TYPE_INT
        push    eax
        lea     ecx, [esp+stackoffset-0x170]
        push    DWORD [ecx+0x8]
        call    ninja_createSymbol
    addStack 2*4
        mov     [esp+stackoffset-0x1B0], eax
    verifyStackoffset 0x1F0

        ; Jump back
        jmp    0x7973E7
%endif


global fix_Hlp_GetNpc
fix_Hlp_GetNpc:
    resetStackoffset 0x10
        mov     eax, [esi+zCPar_Symbol_offset_offset]
        test    eax, eax
        jz      g1g2(0x65880E,0x6EEE6E)
        mov     eax, [eax]
        cmp     eax, oCNpc__vftable
        jnz     g1g2(0x65880E,0x6EEE6E)

        ; Jump back
        push    edi
        push    oCNpc_RTTI_Type_Descriptor
        jmp     g1g2(0x6587F2,0x6EEE52)


global fix_Hlp_IsValidNpc
fix_Hlp_IsValidNpc:
    resetStackoffset 0x18
        test    eax, eax
        jz      .back
        mov     eax, [eax]
        cmp     eax, oCNpc__vftable
        jz      .back
        xor     eax, eax
        jmp     .backClean
    verifyStackoffset 0x18

.back:
        ; Jump back
        call    dynamic_cast
.backClean:
        jmp     g1g2(0x658883,0x6EEEE3)


global fix_Hlp_IsValidItem
fix_Hlp_IsValidItem:
    resetStackoffset 0x18
        test    eax, eax
        jz      .back
        mov     eax, [eax]
        cmp     eax, oCItem__vftable
        jz      .back
        xor     eax, eax
        jmp     .backClean
    verifyStackoffset 0x18

.back:
        ; Jump back
        call    dynamic_cast
.backClean:
        jmp     g1g2(0x658B43,0x6EF1D3)


; Deinitialize VDFS on fast exit to ensure release of data file
global fastexit_deinit_vdfs
fastexit_deinit_vdfs:
        call    zFILE_VDFS__DeinitFileSystem
        call    _exit                                                      ; Never returns


; Deinitialize VDFS on improper CGameManager destruction (access violation)
global CGameMananager_destruction_deinit_vdfs
CGameMananager_destruction_deinit_vdfs:
    resetStackoffset 0x3C
        pusha
        call    zFILE_VDFS__DeinitFileSystem
        popa
    verifyStackoffset 0x3C

        ; Jump back
        mov     BYTE [esp+stackoffset-0x4], 0x4
        jmp     g1g2(0x423BE1,0x4247D1)


; Deinitialize VDFS on libExit (fatal error)
global libExit_deinit_vdfs
libExit_deinit_vdfs:
    resetStackoffset
        pusha
        call    zFILE_VDFS__DeinitFileSystem
        popa
    verifyStackoffset

        ; Jump back
        mov     eax, g1g2(0x86F51C,0x8D4294)
        jmp     g1g2(0x4F3C35,0x502AB5)
