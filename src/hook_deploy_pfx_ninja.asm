; Hook PFX parser in zCParticleFX::ParseParticleFXScript

%include "inc/macros.inc"
%include "inc/symbols.inc"

%ifidn __OUTPUT_FORMAT__, bin
    org     g1g2(0x58CA22,0x5A7F33,0,0x5AC7BC)
%endif

bits    32


section .text   align=1                                                    ; Prevent auto-alignment

        jmp     deploy_pfx_ninja

        ; Overwrites
        ; resetStackoffset g1g2(0x8C,0x7C,0,0xC8)
        ; lea     g1g2(eax,ecx,0,eax), [esp+stackoffset+g1g2(-0x79,-0x69,0,-0xB5)]
        ; push    g1g2(eax,ecx,0,eax)
