; Hook oCWorld::Archive to ignore writing of logical NPC that are non-persistent

%include "inc/macros.inc"

%if GOTHIC_BASE_VERSION == 1
    %include "inc/symbols_g1.inc"
%elif GOTHIC_BASE_VERSION == 2
    %include "inc/symbols_g2.inc"
%endif

%ifidn __OUTPUT_FORMAT__, bin
    org     g1g2(0x6D65A3,0x77F6E1)
%endif

bits    32


section .text   align=1                                                    ; Prevent auto-alignment

        jmp     checkNpcTransient2
        nop
