; Hook SFX parser in zCSndSys_MSS::zCSndSys_MSS

%include "inc/macros.inc"
%include "inc/symbols.inc"

%ifidn __OUTPUT_FORMAT__, bin
    org     g1g2(0x4DD88C,0x4EECDC,0,0x4EAE8B)
%endif

bits    32


section .text   align=1                                                    ; Prevent auto-alignment

        jmp     deploy_sfx_ninja

        ; Overwrites
        ; resetStackoffset g1g2(0x304,0x2F8,0,0x308)
        ; lea     g1g2(ecx,eax,0,eax), [esp+stackoffset+g1g2(-0x2F2,0x2E5,0,-0x2F6)]
        ; push    g1g2(ecx,eax,0,eax)
