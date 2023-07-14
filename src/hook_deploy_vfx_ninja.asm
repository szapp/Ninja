; Hook VFX parser in oCVisualFX::InitParser

%include "inc/macros.inc"
%include "inc/symbols.inc"

%ifidn __OUTPUT_FORMAT__, bin
    org     g1g2(0x483A3C,0,0x48B6EF)
%endif

bits    32


section .text   align=1                                                    ; Prevent auto-alignment

        jmp     deploy_vfx_ninja

        ; Overwrites
        ; resetStackoffset g1g2(0x248,0,0x250)
        ; lea     g1g2(edx,0,eax), [esp+stackoffset+g1g2(-0x239,0,0x235)]
        ; push    g1g2(edx,0,eax)
