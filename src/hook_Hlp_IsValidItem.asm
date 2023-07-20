; Add safety check for the external Hlp_IsValidItem in case a patch causes to save invalid symbol indices

%include "inc/macros.inc"
%include "inc/symbols.inc"

%ifidn __OUTPUT_FORMAT__, bin
    org     g1g2(0x658B3E,0,0,0x6EF1CE)
%endif

bits    32


section .text   align=1                                                    ; Prevent auto-alignment

        jmp     fix_Hlp_IsValidItem
