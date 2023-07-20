; Executive code for initializing the ninjas

global init_menu
init_menu:
    resetStackoffset g1g2(0x34,0x3C,0x34)
        call    zCArraySort_zCMenu___InsertSort                            ; Overwritten
        pusha
        push    ninja_initMenu
        push    char_src
        push    NINJA_PATH_CONTENT
        call    ninja_dispatch
    addStack 3*4
        popa
    verifyStackoffset g1g2(0x34,0x3C,0x34)

        ; Jump back
        jmp     g1g2(0x4CE909,0x4DF1A6,0x4DB4F9)+5


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
%if GOTHIC_BASE_VERSION == 1 || GOTHIC_BASE_VERSION == 112
        mov    DWORD [zCParser_parser+zCParser_progressBar_offset], edi
%elif GOTHIC_BASE_VERSION == 2
        add     esp, 0x8
        test    eax, eax
%endif
        jmp     g1g2(0x637F84,0x65E408,0x6C20C3)+5
