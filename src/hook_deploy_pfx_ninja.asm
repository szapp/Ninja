; Hook PFX parser in zCParticleFX::ParseParticleFXScript

%include "inc/macros.inc"

%if GOTHIC_BASE_VERSION == 1
    %include "inc/symbols_g1.inc"
%elif GOTHIC_BASE_VERSION == 2
    %include "inc/symbols_g2.inc"
%endif

%ifidn __OUTPUT_FORMAT__, bin
    org     g1g2(0x58CA22,0x5AC7BC)
%endif

bits    32


section .text   align=1                                                    ; Prevent auto-alignment

        jmp     deploy_pfx_ninja

        ; Overwrites
        ; resetStackoffset g1g2(0x8C,0xC8)
        ; lea     eax, [esp+stackoffset+g1g2(-0x79,-0xB5)]
        ; push    eax
