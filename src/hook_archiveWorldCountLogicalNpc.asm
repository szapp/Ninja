; Hook oCWorld::Archive to ignore counting of logical NPC that are non-persistent

%include "inc/macros.inc"
%include "inc/symbols.inc"

%ifidn __OUTPUT_FORMAT__, bin
    org     g1g2(0x6D652A,0x70DF35,0x77F66A)
%endif

bits    32


section .text   align=1                                                    ; Prevent auto-alignment

        jmp     checkNpcTransient1
        nop
