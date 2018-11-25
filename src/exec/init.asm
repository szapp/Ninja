; Executive code for initializing the ninjas

global init_menu
init_menu:
    resetStackoffset 0x2C
        pusha
        push    ninja_initMenu
        push    NINJA_PATH_CONTENT
        push    zCParser_parser
        call    ninja_inject
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
        push    NINJA_PATH_CONTENT
        push    zCParser_parser
        call    ninja_inject
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


global init_anims
init_anims:

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
        push    ninja_initAnims
        push    char_nul
        call    ninja_findVdfSrc
    addStack 2*4

    .back:
        popa
    verifyStackoffset 0xF54
        cmp     [esp+stackoffset-0xE88], ebp
        jmp     0x57DC47

%elif GOTHIC_BASE_VERSION == 2

    resetStackoffset 0x49C
        pusha
        mov     ebp, [esp+stackoffset-0x478]                               ; zCModelPrototype *
        push    ninja_initAnims
        push    char_nul
        call    ninja_findVdfSrc
    addStack 2*4
        popa
    verifyStackoffset 0x49C

        ; Jump back
        mov     eax, [esp+stackoffset-0x3E0]
        jmp     0x5961D4

%endif
