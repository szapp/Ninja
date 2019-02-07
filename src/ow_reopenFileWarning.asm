; Remove warning when opening already opened file

%include "inc/macros.inc"

%if GOTHIC_BASE_VERSION == 1
    %include "inc/symbols_g1.inc"
%elif GOTHIC_BASE_VERSION == 2
    %include "inc/symbols_g2.inc"
%endif

%ifidn __OUTPUT_FORMAT__, bin
    org     g1g2(0x5CE925,0x5F9C15)
%endif

bits    32


section .text   align=1                                                    ; Prevent auto-alignment

        times 0xA nop
