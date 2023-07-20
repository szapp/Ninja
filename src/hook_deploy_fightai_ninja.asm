; Hook fight AI parser in oCNpc::InitFightAI

%include "inc/macros.inc"
%include "inc/symbols.inc"

%ifidn __OUTPUT_FORMAT__, bin
    org     g1g2(0x747EBA,0x788F52,0,0x67C626)
%endif

bits    32


section .text   align=1                                                    ; Prevent auto-alignment

        jmp     deploy_fightai_ninja

        ; Overwrites
        ; resetStackoffset g1g2(0x7C,0x50,0,0x64)
        ; lea     g1g2(edx,edx,0,eax), [esp+stackoffset+g1g2(-0x69,-0x34,0,-0x51)]
        ; push    g1g2(edx,edx,0,eax)
