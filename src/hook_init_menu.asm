; Hook menu creation in zCMenu::SetByScript

%include "inc/macros.inc"
%include "inc/symbols.inc"

%ifidn __OUTPUT_FORMAT__, bin
    org     g1g2(0x4CE90F,0,0x4DB4FF)
%endif

bits    32


section .text   align=1                                                    ; Prevent auto-alignment

        jmp     init_menu

        ; Overwrites
        ; resetStackoffset 0x28
        ; pop     ebp
        ; mov     ecx, [esp+stackoffset-0xC]
