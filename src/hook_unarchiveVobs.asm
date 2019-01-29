; Hook zCWorld::UnarcTraverseVobs to catch invalid oCNpc objects

%include "inc/macros.inc"

%if GOTHIC_BASE_VERSION == 1
    %include "inc/symbols_g1.inc"
%elif GOTHIC_BASE_VERSION == 2
    %include "inc/symbols_g2.inc"
%endif

%ifidn __OUTPUT_FORMAT__, bin
    org     g1g2(0x5F8149,0x62678A)
%endif

bits    32


section .text   align=1                                                    ; Prevent auto-alignment

        jmp     removeInvalidNpcs
        nop
