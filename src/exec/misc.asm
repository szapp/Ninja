; Miscellaneous executive code

global detour_netMessage_failed
detour_netMessage_failed:
    resetStackoffset g1g2(0x23C,0x2D8)
%if GOTHIC_BASE_VERSION == 1
        mov     DWORD [esp+stackoffset-0x218], 0
        mov     ebp, [esp+stackoffset-0x218]
        jmp     0x45273F
%elif GOTHIC_BASE_VERSION == 2
        mov     [esp+stackoffset-0x2B4], ebx
        mov     esi, ebx
        jmp     0x4575B9
%endif
    verifyStackoffset g1g2(0x23C,0x2D8)
