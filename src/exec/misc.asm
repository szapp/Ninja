; Miscellaneous executive code

global setVobToTransient
setVobToTransient:
        resetStackoffset 0x68
        pusha

        mov     eax, [esi]
        mov     ecx, esi
        call    DWORD [eax]
        push    eax
        push    oCNpc__classDef
        call    zCObject__CheckInheritance
        add     esp, 0x8
        test    eax, eax
        jz      .back

        mov     eax, [esi+g1g2(0x7B0,0x7B4,0x6E4,0x770)]                   ; oCNpc.instanz
        test    eax, eax
        jl      .back
        mov     edi, eax

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

        cmp     edi, eax
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

        cmp     edi, eax
        jg      .cleanup

    %if GOTHIC_BASE_VERSION == 1 || GOTHIC_BASE_VERSION == 112
        test    BYTE [esi+0xF5], 0x1                                       ; zCVob.dontwritetoarchive
    %elif GOTHIC_BASE_VERSION == 130 || GOTHIC_BASE_VERSION == 2
        test    BYTE [esi+0x114], 0x10                                     ; zCVob.dontwritetoarchive
    %endif
        jnz     .cleanup

        mov     ecx, esp
        push    NINJA_IGNORING
        call    zSTRING__operator_eq
    addStack 4
        lea     eax, [esp+stackoffset-0x20]                                ; zCObject.objectname
        push    DWORD [eax+0x8]                                            ; str->ptr
        call    zSTRING__operator_plusEq
    addStack 4
        push    ecx
        call    zERROR__Message
    addStack 4

    %if GOTHIC_BASE_VERSION == 1 || GOTHIC_BASE_VERSION == 112
        or      BYTE [esi+0xF5], 0x1                                       ; zCVob.dontwritetoarchive = True
    %elif GOTHIC_BASE_VERSION == 130 || GOTHIC_BASE_VERSION == 2
        or      BYTE [esi+0x114], 0x10                                     ; zCVob.dontwritetoarchive = True
    %endif

.cleanup:
        mov     ecx, esp
        call    zSTRING___zSTRING
        add     esp, 0x14

.back:
        popa
    verifyStackoffset 0x68

        ; Jump back
        mov     eax, [esi+g1g2(0x214,0x214,0x248,0x25C)]
%if GOTHIC_BASE_VERSION == 112
        test    eax, eax
%endif
        jmp     g1g2(0x68CB31,0x6BD2E0,0x6D0F01,0x72F161) + 6


global checkNpcTransient1
checkNpcTransient1:
    resetStackoffset g1g2(0x5C,0x5C,0x94,0x94)
        call    DWORD [edx+0x104]                                          ; oCNpc.IsSelfPlayer(void)
        test    eax, eax
        jnz     .back

    %if GOTHIC_BASE_VERSION == 1 || GOTHIC_BASE_VERSION == 112
        test    BYTE [ecx+0xF5], 0x1                                       ; zCVob.dontwritetoarchive
    %elif GOTHIC_BASE_VERSION == 130 || GOTHIC_BASE_VERSION == 2
        test    BYTE [ecx+0x114], 0x10                                     ; zCVob.dontwritetoarchive
    %endif
        jz      .back
        mov     eax, 0x1
    verifyStackoffset g1g2(0x5C,0x5C,0x94,0x94)

.back:
        jmp     g1g2(0x6D652A,0x70DF35,0x71FC2A,0x77F66A) + 6


global checkNpcTransient2
checkNpcTransient2:
    resetStackoffset g1g2(0x5C,0x5C,0x94,0x94)
        call    DWORD [eax+0x104]                                          ; oCNpc.IsSelfPlayer(void)
        test    eax, eax
        jnz     .back

    %if GOTHIC_BASE_VERSION == 1 || GOTHIC_BASE_VERSION == 112
        test    BYTE [ecx+0xF5], 0x1                                       ; zCVob.dontwritetoarchive
    %elif GOTHIC_BASE_VERSION == 130 || GOTHIC_BASE_VERSION == 2
        test    BYTE [ecx+0x114], 0x10                                     ; zCVob.dontwritetoarchive
    %endif
        jz      .back
        mov     eax, 0x1
    verifyStackoffset g1g2(0x5C,0x5C,0x94,0x94)

.back:
        jmp     g1g2(0x6D65A3,0x70DFA6,0x71FCA1,0x77F6E1)+6


global removeInvalidNpcs
removeInvalidNpcs:
    resetStackoffset g1g2(0x58,0x58,0x8C,0x8C)
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

        mov     eax, [esi+g1g2(0x7B0,0x7B4,0x6E4,0x770)]                   ; oCNpc.instanz
        test    eax, eax
        jge     .back

        reportToSpy NINJA_REMOVE_NPC
        push    char_meatbug_mds
        lea     ecx, [esi+g1g2(0x7B4,0x7C8,0x6E8,0x774)]                   ; oCNpc.mds_name
        call    zSTRING__zSTRING
    addStack 4
        mov     ecx, [esp+stackoffset+g1g2(-0x48,-0x10-0x4,-0x7C,-0x7C)]
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
    verifyStackoffset g1g2(0x58,0x58,0x8C,0x8C)

        ; Jump back
%if GOTHIC_BASE_VERSION == 1
        test    ebx, ebx
        jnz     0x5F81A2
        test    ecx, ecx
        jmp     0x5F8149 + 5
%elif GOTHIC_BASE_VERSION == 112 || GOTHIC_BASE_VERSION == 130 || GOTHIC_BASE_VERSION == 2
        mov     eax, [esp+stackoffset+g1g2(,-0x14-0x4,-0x78,-0x78)]
        test    eax, eax
        jmp     g1g2(,0x61959E,0x61EFFA,0x62678A) + 5
%endif


global removeInvalidNpcs2
removeInvalidNpcs2:
    resetStackoffset g1g2(0x5C,0x5C,0x98,0x98)
        test    esi, esi
        jz      .back

        mov     eax, [esi+g1g2(0x7B0,0x7B4,0x6E4,0x770)]                   ; oCNpc.instanz
        test    eax, eax
        jl      .remove
        call    oCWorld__InsertInLists
        jmp     .back

.remove:
        reportToSpy NINJA_REMOVE_NPC
        push    char_meatbug_mds
        lea     ecx, [esi+g1g2(0x7B4,0x7C8,0x6E8,0x774)]                   ; oCNpc.mds_name
        call    zSTRING__zSTRING
    addStack 4

.back:
    verifyStackoffset g1g2(0x5C,0x5C,0x98,0x98)
        jmp     g1g2(0x6D6823,0x70E25F,0x71FF7B,0x77F9BB) + 5


global removeNpcInstRef
removeNpcInstRef:
    resetStackoffset 0x14
        push    ecx
        push    esi
        mov     ecx, zCParser_parser
        call    zCParser__ClearInstanceRefs
    addStack 4
        pop     ecx
    verifyStackoffset 0x14
%if GOTHIC_BASE_VERSION == 1 || GOTHIC_BASE_VERSION == 112 || GOTHIC_BASE_VERSION == 130
        pop     esi
        pop     ebp
        pop     ebx
        add     esp, 0x8
%elif GOTHIC_BASE_VERSION == 2
        cmp     [esi+0x758], ebp
%endif
        jmp     g1g2(0x68C0F6,0x6BC7DD,0x6D0445,0x72E625) + 5


global recoverInvalidItem
recoverInvalidItem:
    resetStackoffset g1g2(0x94,0x94,0x100,0x100)
        test    esi, esi                                                   ; Check for invalid item in archive
        jnz     .back

        sub     esp, 0x10                                                  ; At this point the error already happened:
        push    char_shortKey                                              ; Attempt to recover by reading shortKey
        lea     eax, [esp+0x4]                                             ; This advances the buffer to try again
        push    eax
        call    DWORD [ds_lstrcpyA]                                        ; Construct 'shortKeyX' on stack
    addStack 2*4
        push    0xA
        lea     eax, [esp+0x4+0x8]                                         ; Stack-offset + len('shortKey')
        push    eax
        mov     ecx, [esp+stackoffset-g1g2(0x80,0x80,0xEC,0xEC)]           ; Index X
        push    ecx
        call    _itoa                                                      ; 'shortKey' + 'X', 0
        add     esp, 0xC

        mov     eax, [g1g2(ebp,ebp,ebx,ebx)]                               ; Attempt to advance buffer
        lea     ecx, [esp+stackoffset-g1g2(0x78,0x78,0xE0,0xE0)]           ; Key-variable used as sink
        push    ecx                                                        ; Arg1 key
        mov     edx, esp                                                   ; Arg0 'shortKeyX'
        mov     ecx, g1g2(ebp,ebp,ebx,ebx)                                 ; This zCArchive*
        call    [eax+0x60]                                                 ; zCArchive->ReadInt
    addStack 4
        add     esp, 0x10                                                  ; Free 'shortKeyX' from stack

        mov     edx, [esp+stackoffset-g1g2(0x68,0x68,0xBC,0xBC)]           ; Get existing 'itemX' and try again
        mov     esi, [g1g2(ebp,ebp,ebx,ebx)]
        push    0x0
        mov     ecx, g1g2(ebp,ebp,ebx,ebx)
        call    [esi+0xAC]                                                 ; zCArchive->ReadObject
    addStack 4
        mov     esi, eax
    verifyStackoffset g1g2(0x94,0x94,0x100,0x100)

.back:
%if GOTHIC_BASE_VERSION == 1 || GOTHIC_BASE_VERSION == 112
        mov     DWORD [esp+stackoffset-0x78], 0xFFFFFFFF
%endif
        jmp     g1g2(0x66DC47,0x69B420,0x6AFBB9,0x70D6D9) + 6


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
        jmp     g1g2(0x63C7EE,0x663348,0x66A0EE,0x6C6D1E) + 5


global createGlobalVarIfNotExist
createGlobalVarIfNotExist:
%if GOTHIC_BASE_VERSION == 1 || GOTHIC_BASE_VERSION == 112                 ; zCParser::LoadGlobalVars differs for g1/g2
    resetStackoffset g1g2(0xC4,0xBC,,)
        jz      .createSymb
        mov     eax, [esi+0x20]                                            ; Rewritten what has been overwritten
        jmp     g1g2(0x6EDAD5,0x727105,,) + 5

.createSymb:
        push    zPAR_TYPE_INT | 0x1
        lea     ecx, [esp+stackoffset-g1g2(0x8C,0x80,,)]
        push    DWORD [ecx+0x4]
        call    ninja_createSymbol
    addStack 2*4
        mov     esi, eax
    verifyStackoffset g1g2(0xC4,0xBC,,)

        ; Jump back
        jmp    g1g2(0x6EDAF7,0x727128,,)

%elif GOTHIC_BASE_VERSION == 130 || GOTHIC_BASE_VERSION == 2
    resetStackoffset 0x1F0
        jle     g1g2(,,0x737BC8,0x797608)
        mov     ecx, [esp+stackoffset-0x1B0]                               ; zCPar_Symbol *
        test    ecx, ecx
        jnz     g1g2(,,0x7379A1,0x7973E1) + 5

        or      eax, zPAR_TYPE_INT
        push    eax
        lea     ecx, [esp+stackoffset-0x170]
        push    DWORD [ecx+0x8]
        call    ninja_createSymbol
    addStack 2*4
        mov     [esp+stackoffset-0x1B0], eax
    verifyStackoffset 0x1F0

        ; Jump back
        jmp    g1g2(,,0x7379A1,0x7973E1) + 5
%endif


global fix_Hlp_GetNpc
fix_Hlp_GetNpc:
    resetStackoffset 0x10
        mov     eax, [esi+zCPar_Symbol_offset_offset]
        test    eax, eax
        jz      g1g2(0x65880E,0x682D4E,0x691BFE,0x6EEE6E)

        push    ecx
        mov     ecx, eax
        mov     eax, [ecx]
        call    DWORD [eax]
        push    eax
        push    oCNpc__classDef
        call    zCObject__CheckInheritance
        add     esp, 0x8
        test    eax, eax
        pop     ecx
        jz      g1g2(0x65880E,0x682D4E,0x691BFE,0x6EEE6E)
    verifyStackoffset 0x10

        ; Jump back
        push    edi
        push    oCNpc_RTTI_Type_Descriptor
        jmp     g1g2(0x6587EC,0x682D2C,0x691BDC,0x6EEE4C) + 5


global fix_Hlp_IsValidNpc
fix_Hlp_IsValidNpc:
    resetStackoffset 0x18
        test    eax, eax
        jz      .back

        push    ecx
        mov     ecx, eax
        mov     eax, [ecx]
        call    DWORD [eax]
        push    eax
        push    oCNpc__classDef
        call    zCObject__CheckInheritance
        add     esp, 0x8
        test    eax, eax
        pop     ecx
        jz      .backClean
    verifyStackoffset 0x18

.back:
        ; Jump back
        call    dynamic_cast
.backClean:
        jmp     g1g2(0x65887E,0x682DCE,0x691C6E,0x6EEEDE) + 5


global fix_Hlp_IsValidItem
fix_Hlp_IsValidItem:
    resetStackoffset 0x18
        test    eax, eax
        jz      .back

        push    ecx
        mov     ecx, eax
        mov     eax, [ecx]
        call    DWORD [eax]
        push    eax
        push    oCItem__classDef
        call    zCObject__CheckInheritance
        add     esp, 0x8
        test    eax, eax
        pop     ecx
        jz      .backClean
    verifyStackoffset 0x18

.back:
        ; Jump back
        call    dynamic_cast
.backClean:
        jmp     g1g2(0x658B3E,0x6830AE,0x691F5E,0x6EF1CE) + 5


; Deinitialize VDFS on fast exit to ensure release of data file
global fastexit_deinit_vdfs
fastexit_deinit_vdfs:
        call    zFILE_VDFS__DeinitFileSystem
        call    _exit                                                      ; Never returns


; Deinitialize VDFS on improper CGameManager destruction (access violation)
global CGameMananager_destruction_deinit_vdfs
CGameMananager_destruction_deinit_vdfs:
    resetStackoffset g1g2(0x3C,0x38,0,0x3C)
        pusha
        call    zFILE_VDFS__DeinitFileSystem
        popa
    verifyStackoffset g1g2(0x3C,0x38,0,0x3C)

        ; Jump back
        mov     BYTE [esp+stackoffset-0x4], 0x4
        jmp     g1g2(0x423BDC,0x4265C4,0x42449C,0x4247CC) + 5


; Deinitialize VDFS on libExit (fatal error)
global libExit_deinit_vdfs
libExit_deinit_vdfs:
    resetStackoffset
        pusha
        call    zFILE_VDFS__DeinitFileSystem
        popa
    verifyStackoffset

        ; Jump back
        mov     eax, g1g2(0x86F51C,0x8B5138,0x8C5C5C,0x8D4294)
        jmp     g1g2(0x4F3C30,0x506620,0x4FFE30,0x502AB0) + 5
