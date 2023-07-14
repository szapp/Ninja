; Hook for general initialization

%include "inc/macros.inc"
%include "inc/symbols.inc"

%ifidn __OUTPUT_FORMAT__, bin
    org     g1g2(0x6019C1,0x62377E,0x630B5C)
%endif

bits    32


section .text   align=1                                                    ; Prevent auto-alignment

        jmp     createVdfArray
