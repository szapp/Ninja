; void __thiscall oCSpawnManager::Archive(class zCArchiver &)
; Re-implement oCSpawnManager::Archive to exclude non-persistent NPC
global oCSpawnManager__Archive_fix
oCSpawnManager__Archive_fix:
        resetStackoffset
        %assign var_total      0x8                                         ; int
        %assign var_element   -0x8                                         ; oTSpawnNode*
        %assign var_startpos  -0x4                                         ; int
        %assign arg_1         +0x4                                         ; zCArchiver &
        %assign arg_total      0x4

        sub     esp, var_total
        pusha

        mov     esi, [esp+stackoffset+arg_1]                               ; arc
        mov     eax, [esi]
        mov     ebx, ecx
        mov     ecx, esi
        call    DWORD [eax+0x100]                                          ; arc->InSaveGame(void)
        test    eax, eax
        jz      .loc_end

        mov     eax, [esi]                                                 ; Store cursor pos for changed writing order
        mov     ecx, esi
        call    DWORD [eax+0x12C]                                          ; arc->StoreGetPos(void)
        mov     [esp+stackoffset+var_startpos], eax
        mov     eax, [esi]
        xor     edx, edx                                                   ; Write zero for now
        push    edx
        mov     edx, char_noOfEntries
        mov     ecx, esi
        call    DWORD [eax+0x10]                                           ; arc->WriteInt(char const *,int)
    addStack 4

        mov     eax, [ebx+zCArray.numInArray]
        xor     edi, edi
        xor     ebp, ebp
        test    eax, eax
        jle     .loc_loopend

    .loc_loop:
        mov     ecx, [ebx]
        mov     edx, [ecx+edi*0x4]
        mov     [esp+stackoffset+var_element], edx                         ; oTSpawnNode*

        mov     ecx, [edx]                                                 ; oTSpawnNode.npc
    %if GOTHIC_BASE_VERSION == 1
        test    BYTE [ecx+0xF5], 0x1                                       ; zCVob.dontwritetoarchive
    %elif GOTHIC_BASE_VERSION == 2
        test    BYTE [ecx+0x114], 0x10                                     ; zCVob.dontwritetoarchive
    %endif
        jnz     .loc_next

        mov     eax, [esi]
        push    ecx
        mov     edx, char_npc
        mov     ecx, esi
        call    DWORD [eax+0x40]                                           ; arc->WriteObject(char const *,zCObject *)
    addStack 4

        mov     edx, [esp+stackoffset+var_element]
        mov     eax, [esi]
        add     edx, 0x4                                                   ; oTSpawnNode.spawnPos[3]
        push    edx
        mov     edx, char_spawnPos
        mov     ecx, esi
        call    DWORD [eax+0x28]                                           ; arc->WriteVec3(char const *,zVEC3 const &)
    addStack 4

        mov     edx, [esp+stackoffset+var_element]
        mov     eax, [esi]
        push    DWORD [edx+0x10]                                           ; oTSpawnNode.timer
        mov     edx, char_timer
        mov     ecx, esi
        call    DWORD [eax+0x1C]                                           ; arc->WriteFloat(char const *,float)
    addStack 4

        mov     eax, [ebx+zCArray.numInArray]
        inc     ebp

    .loc_next:
        inc     edi
        cmp     edi, eax
        jl      .loc_loop

    .loc_loopend:
        mov     eax, [esi]
        mov     ecx, esi
        call    DWORD [eax+0x12C]                                          ; arc->StoreGetPos(void)
        mov     edx, [esp+stackoffset+var_startpos]
        push    eax
        mov     eax, [esi]
        mov     ecx, esi
        call    DWORD [eax+0x130]                                          ; arc-StoreSeek(ulong)

        mov     eax, [esi]
        push    ebp
        mov     edx, char_noOfEntries
        mov     ecx, esi
        call    DWORD [eax+0x10]                                           ; arc->WriteInt(char const *,int)
    addStack 4

        pop     edx
        test    ebp, ebp
        jz      .loc_writelast

        mov     eax, [esi]
        mov     ecx, esi
        call    DWORD [eax+0x130]                                          ; arc->StoreSeek(ulong)

    .loc_writelast:
        mov     ecx, [ebx+0x0C]                                            ; oCSpawnManager.spawningEnabled
        mov     eax, [esi]
        push    ecx
        mov     edx, char_spawningEnabled
        mov     ecx, esi
        call    DWORD [eax+0x20]                                           ; arc->WriteBool(char const *,int)
    addStack 4
    %if GOTHIC_BASE_VERSION == 2
        mov     ecx, [ebx+0x20]                                            ; oCSpawnManager.spawnFlags
        mov     eax, [esi]
        push    ecx
        mov     edx, char_spawnFlags
        mov     ecx, esi
        call    DWORD [eax+0x10]                                           ; arc->WriteInt(char const *,int)
    addStack 4
    %endif

    .loc_end:
        popa
        add     esp, var_total
        ret     arg_total
    verifyStackoffset
