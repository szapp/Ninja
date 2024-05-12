; Hook after oCInfoManager::Unarchive in oCGame::LoadSavegame to add new infos to the info manager

%include "inc/macros.inc"
%include "inc/symbols.inc"

%ifidn __OUTPUT_FORMAT__, bin
    org     g1g2(0x63C7EE,0x663348,0x66A0EE,0x6C6D1E)
%endif

bits    32


section .text   align=1                                                    ; Prevent auto-alignment

        jmp     ninja_injectInfo
        nop
