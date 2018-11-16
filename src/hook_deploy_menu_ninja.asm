; Hook menu parser in zCMenu::Startup

%include "inc/macros.mac"

%if GOTHIC_BASE_VERSION == 1
    %include "inc/symboladdresses2_g1.mac"
%elif GOTHIC_BASE_VERSION == 2
    %include "inc/symboladdresses2_g2.mac"
%endif

%ifidn __OUTPUT_FORMAT__, bin
    org     g1g2(0x4CD57A,0x4DA196)
%endif

bits    32


section .text   align=1                                                    ; Prevent auto-alignment

        jmp     deploy_menu_ninja

        ; Overwrites
        ; mov     eax, zCSoundSystem_zsound
