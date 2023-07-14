; Hook oCWorld::Unarchive to catch invalid oCNpc objects

%include "inc/macros.inc"
%include "inc/symbols.inc"

%ifidn __OUTPUT_FORMAT__, bin
    org     g1g2(0x6D6823,0,0x77F9BB)
%endif

bits    32


section .text   align=1                                                    ; Prevent auto-alignment

        jmp     removeInvalidNpcs2
