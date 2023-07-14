; Remove warning when opening already opened file

%include "inc/macros.inc"
%include "inc/symbols.inc"

%ifidn __OUTPUT_FORMAT__, bin
    org     g1g2(0x5CE925,0,0x5F9C15)
%endif

bits    32


section .text   align=1                                                    ; Prevent auto-alignment

        times 0xA nop
