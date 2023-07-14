; Executive code for deploying the ninjas

global deploy_music_ninja
deploy_music_ninja:
    resetStackoffset g1g2(0xD8,0,0xC8)
        pusha
        push    ninja_injectSrc
        push    NINJA_PATH_MUSIC
        mov     eax, DWORD [zCMusicSys_DirectMusic__musicParser]
        push    eax
        call    ninja_armParser
    addStack 3*4
        popa
    verifyStackoffset g1g2(0xD8,0,0xC8)

        ; Jump back
        lea     edx, [esp+stackoffset+g1g2(-0xC5,0,-0xB5)]
        push    edx
        jmp     g1g2(0x4DA44D,0,0x4E7661)


global deploy_sfx_ninja
deploy_sfx_ninja:
    resetStackoffset g1g2(0x304,0,0x308)
        pusha
        push    ninja_injectSrc
        push    NINJA_PATH_SFX
        mov     eax, DWORD [zCSndSys_MSS__sfxParser]
        push    eax
        call    ninja_armParser
    addStack 3*4
        popa
    verifyStackoffset g1g2(0x304,0,0x308)

        ; Jump back
        lea     g1g2(ecx,0,eax), [esp+stackoffset+g1g2(-0x2F2,0,-0x2F6)]
        push    g1g2(ecx,0,eax)
        jmp     g1g2(0x4DD891,0,0x4EAE90)


global deploy_pfx_ninja
deploy_pfx_ninja:
    resetStackoffset g1g2(0x8C,0,0xC8)
        pusha
        push    ninja_injectSrc
        push    NINJA_PATH_PFX
        mov     eax, DWORD [zCParticleFX__s_pfxParser]
        push    eax
        call    ninja_armParser
    addStack 3*4
        popa
    verifyStackoffset g1g2(0x8C,0,0xC8)

        ; Jump back
        lea     eax, [esp+stackoffset+g1g2(-0x79,0,-0xB5)]
        push    eax
        jmp     g1g2(0x58CA27,0,0x5AC7C1)


global deploy_vfx_ninja
deploy_vfx_ninja:
    resetStackoffset g1g2(0x248,0,0x250)
        pusha
        push    ninja_injectSrc
        push    NINJA_PATH_VFX
        mov     eax, DWORD [oCVisualFX__fxParser]
        push    eax
        call    ninja_armParser
    addStack 3*4
        popa
    verifyStackoffset g1g2(0x248,0,0x250)

        ; Jump back
        lea     g1g2(edx,0,eax), [esp+stackoffset+g1g2(-0x239,0,-0x235)]
        push    g1g2(edx,0,eax)
        jmp     g1g2(0x483A41,0,0x48B6F4)


global deploy_ou_ninja
deploy_ou_ninja:
    resetStackoffset
        pusha
        push   ninja_injectOU
        push   char_bin
        push   NINJA_PATH_OU
        call   ninja_dispatch
    addStack 3*4
        popa
    verifyStackoffset
        ret


global deploy_content_ninja
deploy_content_ninja:
    resetStackoffset g1g2(0x90,0,0x80)
        pusha
        push    ninja_injectSrc
        push    NINJA_PATH_CONTENT
        push    zCParser_parser
        call    ninja_armParser
    addStack 3*4
        popa
    verifyStackoffset g1g2(0x90,0,0x80)

        ; Jump back
        push    0x1
        lea     ecx, [esp+stackoffset+g1g2(-0x44,0,-0x1C)]
        jmp     g1g2(0x6371F7,0,0x6C12A6)


global deploy_fightai_ninja
deploy_fightai_ninja:
    resetStackoffset g1g2(0x7C,0,0x64)
        pusha
        push    ninja_injectSrc
        push    NINJA_PATH_FIGHT
        push    ebx
        call    ninja_armParser
    addStack 3*4
        popa
    verifyStackoffset g1g2(0x7C,0,0x64)

        ; Jump back
        lea     g1g2(edx,0,eax), [esp+stackoffset+g1g2(-0x69,0,-0x51)]
        push    g1g2(edx,0,eax)
        jmp     g1g2(0x747EBF,0,0x67C62B)


global deploy_menu_ninja
deploy_menu_ninja:
    resetStackoffset
        pusha
        push    ninja_injectSrc
        push    NINJA_PATH_MENU
        mov     eax, DWORD [zCMenu__menuParser]
        push    eax
        call    ninja_armParser
    addStack 3*4
        popa
    verifyStackoffset

        ; Jump back
        mov     eax, DWORD [zCSoundSystem_zsound]
        jmp     g1g2(0x4CD57F,0,0x4DA19B)


global deploy_camera_ninja
deploy_camera_ninja:
    resetStackoffset g1g2(0xB4,0,0xB8)
        pusha
        push    ninja_injectSrc
        push    NINJA_PATH_CAMERA
        mov     eax, DWORD [zCAICamera__cameraParser]
        push    eax
        call    ninja_armParser
    addStack 3*4
        popa
    verifyStackoffset g1g2(0xB4,0,0xB8)

        ; Jump back
        lea     g1g2(eax,0,edx), [esp+stackoffset+g1g2(-0xA1,0,-0xA5)]
        push    g1g2(eax,0,edx)
        jmp     g1g2(0x4990A3,0,0x4A0559)


global deploy_ani_ninja
deploy_ani_ninja:

%if GOTHIC_BASE_VERSION == 1

    resetStackoffset 0xF54
        pusha
        mov     ebp, [esp+stackoffset-0xF24]                               ; zCModelPrototype *
        mov     esi, [ebp+0x14]                                            ; name->ptr
        push    esi
        mov     esi, DWORD [zFILE_cur_mds_file]
        mov     esi, [esi+0x40]                                            ; name->ptr
        push    esi
        call    DWORD [ds_lstrcmpiA]
    addStack 2*4
        test    eax, eax
    verifyStackoffset 0xF54+32                                             ; Base + pusha
        jnz     .back
        sub     esp, 0x120
        mov     eax, esp
        push    NINJA_MDS_PREFIX
        push    eax
        call    DWORD [ds_lstrcpyA]
    addStack 2*4
        push    DWORD [ebp+0x14]                                           ; name->ptr
        push    eax
        call    DWORD [ds_lstrcatA]
    addStack 2*4
        push    ninja_injectMds
        push    char_mds
        push    eax
        call    ninja_dispatch
    addStack 3*4
        add     esp, 0x120

    .back:
        popa
    verifyStackoffset 0xF54
        cmp     [esp+stackoffset-0xE88], ebp
        jmp     0x57DC47

%elif GOTHIC_BASE_VERSION == 2

    resetStackoffset 0x49C
        pusha
        mov     ebp, [esp+stackoffset-0x478]                               ; zCModelPrototype *
        sub     esp, 0x120
        mov     eax, esp
        push    NINJA_MDS_PREFIX
        push    eax
        call    DWORD [ds_lstrcpyA]
    addStack 2*4
        push    DWORD [ebp+0x14]                                           ; name->ptr
        push    eax
        call    DWORD [ds_lstrcatA]
    addStack 2*4
        push    ninja_injectMds
        push    char_mds
        push    eax
        call    ninja_dispatch
    addStack 3*4
        add     esp, 0x120
        popa
    verifyStackoffset 0x49C

        ; Jump back
        mov     eax, [esp+stackoffset-0x3E0]
        jmp     0x5961D4

%endif
