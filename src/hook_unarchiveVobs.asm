; Hook zCWorld::UnarcTraverseVobs to catch invalid oCNpc objects

%include "inc/macros.inc"
%include "inc/symbols.inc"

%ifidn __OUTPUT_FORMAT__, bin
    org     g1g2(0x5F8149,0,0,0x62678A)
%endif

bits    32


section .text   align=1                                                    ; Prevent auto-alignment

        jmp     removeInvalidNpcs
        nop
