; Executive code for deploying the ninjas

global deploy_music_ninja
deploy_music_ninja:
    resetStackoffset g1g2(0xD8,0xB0,0xC8)
        pusha
        push    ninja_injectSrc
        push    NINJA_PATH_MUSIC
        mov     eax, DWORD [zCMusicSys_DirectMusic__musicParser]
        push    eax
        call    ninja_armParser
    addStack 3*4
        popa
    verifyStackoffset g1g2(0xD8,0xB0,0xC8)

        ; Jump back
        lea     g1g2(edx,eax,edx), [esp+stackoffset+g1g2(-0xC5,-0x9D,-0xB5)]
        push    g1g2(edx,eax,edx)
        jmp     g1g2(0x4DA448,0x4EB55C,0x4E765C)+5


global deploy_sfx_ninja
deploy_sfx_ninja:
    resetStackoffset g1g2(0x304,0x2F8,0x308)
        pusha
        push    ninja_injectSrc
        push    NINJA_PATH_SFX
        mov     eax, DWORD [zCSndSys_MSS__sfxParser]
        push    eax
        call    ninja_armParser
    addStack 3*4
        popa
    verifyStackoffset g1g2(0x304,0x2F8,0x308)

        ; Jump back
        lea     g1g2(ecx,eax,eax), [esp+stackoffset+g1g2(-0x2F2,0x2E5,-0x2F6)]
        push    g1g2(ecx,eax,eax)
        jmp     g1g2(0x4DD88C,0x4EECDC,0x4EAE8B)+5


global deploy_pfx_ninja
deploy_pfx_ninja:
    resetStackoffset g1g2(0x8C,0x7C,0xC8)
        pusha
        push    ninja_injectSrc
        push    NINJA_PATH_PFX
        mov     eax, DWORD [zCParticleFX__s_pfxParser]
        push    eax
        call    ninja_armParser
    addStack 3*4
        popa
    verifyStackoffset g1g2(0x8C,0x7C,0xC8)

        ; Jump back
        lea     g1g2(eax,ecx,eax), [esp+stackoffset+g1g2(-0x79,-0x69,-0xB5)]
        push    g1g2(eax,ecx,eax)
        jmp     g1g2(0x58CA22,0x5A7F33,0x5AC7BC)+5


global deploy_vfx_ninja
deploy_vfx_ninja:
    resetStackoffset g1g2(0x248,0x234,0x250)
        pusha
        push    ninja_injectSrc
        push    NINJA_PATH_VFX
        mov     eax, DWORD [oCVisualFX__fxParser]
        push    eax
        call    ninja_armParser
    addStack 3*4
        popa
    verifyStackoffset g1g2(0x248,0x234,0x250)

        ; Jump back
%if GOTHIC_BASE_VERSION == 1 || GOTHIC_BASE_VERSION == 2
        lea     g1g2(edx,0,eax), [esp+stackoffset+g1g2(-0x239,0,-0x235)]
%elif GOTHIC_BASE_VERSION == 112
        mov     [esp+stackoffset-0x21C], cl
%endif
        push    g1g2(edx,0,eax)
        jmp     g1g2(0x483A3C,0x48EB1F,0x48B6EF)+5


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
    resetStackoffset g1g2(0x90,0x7C,0x80)
        call    sysEvent                                                   ; Overwritten
        pusha
        push    ninja_injectSrc
        push    NINJA_PATH_CONTENT
        push    zCParser_parser
        call    ninja_armParser
    addStack 3*4
        popa
    verifyStackoffset g1g2(0x90,0x7C,0x80)

        ; Jump back
        jmp     g1g2(0x637208,0x65D5A1,0x6C12B7)+5


global deploy_fightai_ninja
deploy_fightai_ninja:
    resetStackoffset g1g2(0x7C,0x50,0x64)
        pusha
        push    ninja_injectSrc
        push    NINJA_PATH_FIGHT
        push    g1g2(ebx,ebp,ebx)
        call    ninja_armParser
    addStack 3*4
        popa
    verifyStackoffset g1g2(0x7C,0x50,0x64)

        ; Jump back
        lea     g1g2(edx,edx,eax), [esp+stackoffset+g1g2(-0x69,-0x34,-0x51)]
        push    g1g2(edx,edx,eax)
        jmp     g1g2(0x747EBA,0x788F52,0x67C626)+5


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
        jmp     g1g2(0x4CD57A,0x4DDC34,0x4DA196)+5


global deploy_camera_ninja
deploy_camera_ninja:
    resetStackoffset g1g2(0xB4,0x9C,0xB8)
        pusha
        push    ninja_injectSrc
        push    NINJA_PATH_CAMERA
        mov     eax, DWORD [zCAICamera__cameraParser]
        push    eax
        call    ninja_armParser
    addStack 3*4
        popa
    verifyStackoffset g1g2(0xB4,0x9C,0xB8)

        ; Jump back
        lea     g1g2(eax,edx,edx), [esp+stackoffset+g1g2(-0xA1,-0x89,-0xA5)]
        push    g1g2(eax,edx,edx)
        jmp     g1g2(0x49909E,0x4A6138,0x4A0554)+5


global deploy_ani_ninja
deploy_ani_ninja:

%if GOTHIC_BASE_VERSION == 1 || GOTHIC_BASE_VERSION == 112

    resetStackoffset g1g2(0xF54,0xFD8,0x0)
        pusha
        mov     ebp, [esp+stackoffset-g1g2(0xF24,0xFA8,0x0)]               ; zCModelPrototype *
        mov     esi, [ebp+0x14]                                            ; name->ptr
        push    esi
        mov     esi, DWORD [zFILE_cur_mds_file]
        mov     esi, [esi+0x40]                                            ; name->ptr
        push    esi
        call    DWORD [ds_lstrcmpiA]
    addStack 2*4
        test    eax, eax
    verifyStackoffset g1g2(0xF54,0xFD8,0x0)+32                             ; Base + pusha
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
    verifyStackoffset g1g2(0xF54,0xFD8,0x0)
        cmp     [esp+stackoffset-g1g2(0xE88,0xF20,0x0)], ebp
        jmp     g1g2(0x57DC40,0x598474,0x0)+7

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
        jmp     0x5961CD+7

%endif
