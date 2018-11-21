; Hook content parser in oCGame::Init

%include "inc/macros.inc"

%if GOTHIC_BASE_VERSION == 1
    %include "inc/symbols_g1.inc"
%elif GOTHIC_BASE_VERSION == 2
    %include "inc/symbols_g2.inc"
%endif

%ifidn __OUTPUT_FORMAT__, bin
    org     g1g2(0x6371F1,0x6C12A0)
%endif

bits    32


section .text   align=1                                                    ; Prevent auto-alignment

        jmp     deploy_content_ninja
        nop

        ; Overwrites
        ; resetStackoffset g1g2(0x94,0x84)
        ; push    0x1
        ; lea     ecx, [esp+stackoffset+g1g2(-0x44,-0x1C)]
