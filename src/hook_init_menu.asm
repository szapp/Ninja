; Hook menu creation in zCMenu::SetByScript

%include "inc/macros.inc"
%include "inc/symbols.inc"

%ifidn __OUTPUT_FORMAT__, bin
    org     g1g2(0x4CE909,0x4DF1A6,0x4DB4F9)
%endif

bits    32


section .text   align=1                                                    ; Prevent auto-alignment

        jmp     init_menu

        ; Overwrites
        ; call    zCArraySort_zCMenu___InsertSort
