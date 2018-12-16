; Executive code for initializing the ninjas

global init_menu
init_menu:
    resetStackoffset 0x2C
        pusha
        push    ninja_initMenu
        push    char_src
        push    NINJA_PATH_CONTENT
        call    ninja_dispatch
    addStack 3*4
        popa
    verifyStackoffset 0x2C

        ; Jump back
        pop     ebp
        mov     ecx, [esp+stackoffset-0xC]
        jmp     g1g2(0x4CE914,0x4DB504)


global init_content
init_content:
    resetStackoffset
        pusha
        push    ninja_initContent
        push    char_src
        push    NINJA_PATH_CONTENT
        call    ninja_dispatch
    addStack 3*4
        popa
    verifyStackoffset

        ; Jump back
%if GOTHIC_BASE_VERSION == 1
        mov    DWORD [0x8DDF90], edi
%elif GOTHIC_BASE_VERSION == 2
        add     esp, 0x8
        test    eax, eax
%endif
        jmp     g1g2(0x637F8A,0x6C20C8)


global init_posthero
init_posthero:
    resetStackoffset
        pusha
        push    ninja_initPostHero
        push    char_src
        push    NINJA_PATH_CONTENT
        call    ninja_dispatch
    addStack 3*4
        popa
    verifyStackoffset

        ; Jump back
        mov     ecx, g1g2(ebp,esi)
        call    DWORD [edx+0x70]
        jmp     g1g2(0x63ECA1,0x6C98DE)
