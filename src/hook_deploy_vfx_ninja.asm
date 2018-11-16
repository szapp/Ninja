; Hook VFX parser in oCVisualFX::InitParser

%include "inc/macros.mac"

%if GOTHIC_BASE_VERSION == 1
    %include "inc/symboladdresses2_g1.mac"
%elif GOTHIC_BASE_VERSION == 2
    %include "inc/symboladdresses2_g2.mac"
%endif

%ifidn __OUTPUT_FORMAT__, bin
    org     g1g2(0x483A3C,0x48B6EF)
%endif

bits    32


section .text   align=1                                                    ; Prevent auto-alignment

        jmp     deploy_vfx_ninja

        ; Overwrites
        ; resetStackoffset g1g2(0x248,0x250)
        ; lea     g1g2(edx,eax), [esp+stackoffset+g1g2(-0x239,0x235)]
        ; push    g1g2(edx,eax)
