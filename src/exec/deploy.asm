; Executive code for deploying the ninjas

global deploy_music_ninja
deploy_music_ninja:
    resetStackoffset g1g2(0xD8,0xC8)
        pusha
        reportToSpy "PAR: Deploy music ninjas"
        push    ninja_mergeSrc
        push    NINJA_PATH_MUSIC
        mov     eax, DWORD [zCMusicSys_DirectMusic__musicParser]
        push    eax
        call    ninja_inject
    addStack 3*4
        popa
    verifyStackoffset g1g2(0xD8,0xC8)

        ; Jump back
        lea     edx, [esp+stackoffset+g1g2(-0xC5,-0xB5)]
        push    edx
        jmp     g1g2(0x4DA44D,0x4E7661)


global deploy_sfx_ninja
deploy_sfx_ninja:
    resetStackoffset g1g2(0x304,0x308)
        pusha
        reportToSpy "PAR: Deploy SFX ninjas"
        push    ninja_mergeSrc
        push    NINJA_PATH_SFX
        mov     eax, DWORD [zCSndSys_MSS__sfxParser]
        push    eax
        call    ninja_inject
    addStack 3*4
        popa
    verifyStackoffset g1g2(0x304,0x308)

        ; Jump back
        lea     g1g2(ecx,eax), [esp+stackoffset+g1g2(-0x2F2,-0x2F6)]
        push    g1g2(ecx,eax)
        jmp     g1g2(0x4DD891,0x4EAE90)


global deploy_pfx_ninja
deploy_pfx_ninja:
    resetStackoffset g1g2(0x8C,0xC8)
        pusha
        reportToSpy "PAR: Deploy PFX ninjas"
        push    ninja_mergeSrc
        push    NINJA_PATH_PFX
        mov     eax, DWORD [zCParticleFX__s_pfxParser]
        push    eax
        call    ninja_inject
    addStack 3*4
        popa
    verifyStackoffset g1g2(0x8C,0xC8)

        ; Jump back
        lea     eax, [esp+stackoffset+g1g2(-0x79,-0xB5)]
        push    eax
        jmp     g1g2(0x58CA27,0x5AC7C1)


global deploy_vfx_ninja
deploy_vfx_ninja:
    resetStackoffset g1g2(0x248,0x250)
        pusha
        reportToSpy "PAR: Deploy VFX ninjas"
        push    ninja_mergeSrc
        push    NINJA_PATH_VFX
        mov     eax, DWORD [oCVisualFX__fxParser]
        push    eax
        call    ninja_inject
    addStack 3*4
        popa
    verifyStackoffset g1g2(0x248,0x250)

        ; Jump back
        lea     g1g2(edx,eax), [esp+stackoffset+g1g2(-0x239,-0x235)]
        push    g1g2(edx,eax)
        jmp     g1g2(0x483A41,0x48B6F4)


global deploy_content_ninja
deploy_content_ninja:
    resetStackoffset g1g2(0x90,0x80)
        pusha
        reportToSpy "PAR: Deploy content ninjas"
        push    ninja_mergeSrc
        push    NINJA_PATH_CONTENT
        push    zCParser_parser
        call    ninja_inject
    addStack 3*4
        popa
    verifyStackoffset g1g2(0x90,0x80)

        ; Jump back
        push    0x1
        lea     ecx, [esp+stackoffset+g1g2(-0x44,-0x1C)]
        jmp     g1g2(0x6371F7,0x6C12A6)


global deploy_fightai_ninja
deploy_fightai_ninja:
    resetStackoffset g1g2(0x7C,0x64)
        pusha
        reportToSpy "PAR: Deploy fight-ai ninjas"
        push    ninja_mergeSrc
        push    NINJA_PATH_FIGHT
        push    ebx
        call    ninja_inject
    addStack 3*4
        popa
    verifyStackoffset g1g2(0x7C,0x64)

        ; Jump back
        lea     g1g2(edx,eax), [esp+stackoffset+g1g2(-0x69,-0x51)]
        push    g1g2(edx,eax)
        jmp     g1g2(0x747EBF,0x67C62B)


global deploy_menu_ninja
deploy_menu_ninja:
    resetStackoffset
        pusha
        reportToSpy "PAR: Deploy menu ninjas"
        push    ninja_mergeSrc
        push    NINJA_PATH_MENU
        mov     eax, DWORD [zCMenu__menuParser]
        push    eax
        call    ninja_inject
    addStack 3*4
        popa
    verifyStackoffset

        ; Jump back
        mov     eax, DWORD [zCSoundSystem_zsound]
        jmp     g1g2(0x4CD57F,0x4DA19B)


global deploy_camera_ninja
deploy_camera_ninja:
    resetStackoffset g1g2(0xB4,0xB8)
        pusha
        push    ninja_mergeSrc
        reportToSpy "PAR: Deploy camera ninjas"
        push    NINJA_PATH_CAMERA
        mov     eax, DWORD [zCAICamera__cameraParser]
        push    eax
        call    ninja_inject
    addStack 3*4
        popa
    verifyStackoffset g1g2(0xB4,0xB8)

        ; Jump back
        lea     g1g2(eax,edx), [esp+stackoffset+g1g2(-0xA1,-0xA5)]
        push    g1g2(eax,edx)
        jmp     g1g2(0x4990A3,0x4A0559)
