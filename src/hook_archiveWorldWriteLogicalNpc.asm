; Hook oCWorld::Archive to ignore writing of logical NPC that are non-persistent

%include "inc/macros.inc"
%include "inc/symbols.inc"

%ifidn __OUTPUT_FORMAT__, bin
    org     g1g2(0x6D65A3,0,0x77F6E1)
%endif

bits    32


section .text   align=1                                                    ; Prevent auto-alignment

        jmp     checkNpcTransient2
        nop
