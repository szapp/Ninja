; Hook fight AI parser in oCNpc::InitFightAI

%include "inc/macros.mac"

%if GOTHIC_BASE_VERSION == 1
    %include "inc/symboladdresses2_g1.mac"
%elif GOTHIC_BASE_VERSION == 2
    %include "inc/symboladdresses2_g2.mac"
%endif

%ifidn __OUTPUT_FORMAT__, bin
    org     g1g2(0x747EBA,0x67C626)
%endif

bits    32


section .text   align=1                                                    ; Prevent auto-alignment

        jmp     deploy_fightai_ninja

        ; Overwrites
        ; resetStackoffset g1g2(0x7C,0x64)
        ; lea     g1g2(edx,eax), [esp+stackoffset+g1g2(-0x69,-0x51)]
        ; push    g1g2(edx,eax)
