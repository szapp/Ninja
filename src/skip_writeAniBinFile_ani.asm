; Overwrite writing bin file for 'ani' in zCModelPrototype::ReadAniEnum

%include "inc/macros.inc"

%if GOTHIC_BASE_VERSION != 130 && GOTHIC_BASE_VERSION != 2
    %fatal This file is for Gothic 1.30 and Gothic 2 only
%endif

%ifidn __OUTPUT_FORMAT__, bin
    org     g1g2(0x000000,0x000000,0x596A49,0x59BFA9)
%endif

bits    32


section .text   align=1                                                    ; Prevent auto-alignment

    resetStackoffset 0x12AC
        mov     eax, [esp+stackoffset-0x129C+0x10]
        mov     [esp+stackoffset-0x12C8], eax
        jmp     g1g2(,,0x596CE7,0x59C247)
