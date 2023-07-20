; Hook content parser in oCGame::Init

%include "inc/macros.inc"
%include "inc/symbols.inc"

%ifidn __OUTPUT_FORMAT__, bin
    org     g1g2(0x637208,0x65D5A1,0x6647F2,0x6C12B7)
%endif

bits    32


section .text   align=1                                                    ; Prevent auto-alignment

        jmp     deploy_content_ninja

        ; Overwrites
        ; call    sysEvent
