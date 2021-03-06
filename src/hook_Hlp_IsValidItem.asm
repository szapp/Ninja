; Add safety check for the external Hlp_IsValidItem in case a patch causes to save invalid symbol indices

%include "inc/macros.inc"

%if GOTHIC_BASE_VERSION == 1
    %include "inc/symbols_g1.inc"
%elif GOTHIC_BASE_VERSION == 2
    %include "inc/symbols_g2.inc"
%endif

%ifidn __OUTPUT_FORMAT__, bin
    org     g1g2(0x658B3E,0x6EF1CE)
%endif

bits    32


section .text   align=1                                                    ; Prevent auto-alignment

        jmp     fix_Hlp_IsValidItem
