; Hook menu parser in zCMenu::Startup

%include "inc/macros.inc"
%include "inc/symbols.inc"

%ifidn __OUTPUT_FORMAT__, bin
    org     g1g2(0x4CD57A,0x4DDC34,0x4DA196)
%endif

bits    32


section .text   align=1                                                    ; Prevent auto-alignment

        jmp     deploy_menu_ninja

        ; Overwrites
        ; mov     eax, zCSoundSystem_zsound
