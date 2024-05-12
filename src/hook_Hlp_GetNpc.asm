; Add safety check for the external Hlp_GetNpc in case a patch causes to save invalid symbol indices

%include "inc/macros.inc"
%include "inc/symbols.inc"

%ifidn __OUTPUT_FORMAT__, bin
    org     g1g2(0x6587EC,0x682D2C,0x691BDC,0x6EEE4C)
%endif

bits    32


section .text   align=1                                                    ; Prevent auto-alignment

        jmp     fix_Hlp_GetNpc
        nop
