; Hook oCSpawnManager::Archive

%include "inc/macros.inc"
%include "inc/symbols.inc"

%ifidn __OUTPUT_FORMAT__, bin
    org     g1g2(0x6D0F40,0,0,0x7797F0)
%endif

bits    32


section .text   align=1                                                    ; Prevent auto-alignment

        jmp     oCSpawnManager__Archive_fix
