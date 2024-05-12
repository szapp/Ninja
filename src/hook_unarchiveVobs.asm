; Hook zCWorld::UnarcTraverseVobs to catch invalid oCNpc objects

%include "inc/macros.inc"
%include "inc/symbols.inc"

%ifidn __OUTPUT_FORMAT__, bin
    org     g1g2(0x5F8149,0x61959E,0x61EFFA,0x62678A)
%endif

bits    32


section .text   align=1                                                    ; Prevent auto-alignment

        jmp     removeInvalidNpcs
    %if GOTHIC_BASE_VERSION == 1 || GOTHIC_BASE_VERSION == 130 || GOTHIC_BASE_VERSION == 2
        nop
    %endif
