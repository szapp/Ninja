; Hook menu creation in zCMenu::SetByScript

%include "inc/macros.inc"

%if GOTHIC_BASE_VERSION == 1
    %include "inc/symbols_g1.inc"
%elif GOTHIC_BASE_VERSION == 2
    %include "inc/symbols_g2.inc"
%endif

%ifidn __OUTPUT_FORMAT__, bin
    org     g1g2(0x4CE90F,0x4DB4FF)
%endif

bits    32


section .text   align=1                                                    ; Prevent auto-alignment

        jmp     init_menu

        ; Overwrites
        ; resetStackoffset 0x28
        ; pop     ebp
        ; mov     ecx, [esp+stackoffset-0xC]
