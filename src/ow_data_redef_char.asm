; Overwrite parser error message

%include "inc/macros.inc"

%ifidn __OUTPUT_FORMAT__, bin
    org     g1g2(0x8525C8,0x8BC220)
%endif

bits    32


section .data   align=1                                                    ; Prevent auto-alignment

        db  'J:NINJA: Overwriting : ', 0
