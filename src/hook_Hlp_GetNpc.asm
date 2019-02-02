; Add safety check for the external Hlp_GetNpc in case a patch causes to save invalid symbol indices

%include "inc/macros.inc"

%if GOTHIC_BASE_VERSION == 1
    %include "inc/symbols_g1.inc"
%elif GOTHIC_BASE_VERSION == 2
    %include "inc/symbols_g2.inc"
%endif

%ifidn __OUTPUT_FORMAT__, bin
    org     g1g2(0x6587EC,0x6EEE4C)
%endif

bits    32


section .text   align=1                                                    ; Prevent auto-alignment

        jmp     fix_Hlp_GetNpc
        nop
