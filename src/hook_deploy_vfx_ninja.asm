; Hook VFX parser in oCVisualFX::InitParser

%include "inc/macros.inc"
%include "inc/symbols.inc"

%ifidn __OUTPUT_FORMAT__, bin
    org     g1g2(0x483A3C,0x48EB1F,0x48B6EF)
%endif

bits    32


section .text   align=1                                                    ; Prevent auto-alignment

        jmp     deploy_vfx_ninja
%if GOTHIC_BASE_VERSION == 112
        nop
%endif

        ; Overwrites
        ; resetStackoffset g1g2(0x248,0x234,0x250)
        ; %if GOTHIC_BASE_VERSION == 1 || GOTHIC_BASE_VERSION == 2
        ;   lea     g1g2(edx,0,eax), [esp+stackoffset+g1g2(-0x239,0,-0x235)]
        ; %elif GOTHIC_BASE_VERSION == 112
        ;   mov     [esp+stackoffset-0x21C], cl
        ; %endif
        ;   push    g1g2(edx,0,eax)
