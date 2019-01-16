; Hook after oCInfoManager::Unarchive in oCGame::LoadSavegame to add new infos to the info manager

%include "inc/macros.inc"

%if GOTHIC_BASE_VERSION == 1
    %include "inc/symbols_g1.inc"
%elif GOTHIC_BASE_VERSION == 2
    %include "inc/symbols_g2.inc"
%endif

%ifidn __OUTPUT_FORMAT__, bin
    org     g1g2(0x63C7EE,0x6C6D1E)
%endif

bits    32


section .text   align=1                                                    ; Prevent auto-alignment

        jmp     ninja_injectInfo
        nop
