; Overwrite writing bin file for 'aniAlias' in zCModelPrototype::ReadAniEnum

%include "inc/macros.inc"

%if GOTHIC_BASE_VERSION != 130 && GOTHIC_BASE_VERSION != 2
    %fatal This file is for Gothic 1.30 and Gothic 2 only
%endif

%ifidn __OUTPUT_FORMAT__, bin
    org     g1g2(0x000000,0x000000,0x5921F5,0x597755)
%endif

bits    32


section .text   align=1                                                    ; Prevent auto-alignment

        jmp     g1g2(,,0x5923F6,0x597956)
