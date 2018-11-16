; Overwrite writing bin file for 'ani' in zCModelPrototype::ReadAniEnum

%include "inc/macros.mac"

%if GOTHIC_BASE_VERSION == 1
    %fatal This file is for Gothic 2 only
%endif

%ifidn __OUTPUT_FORMAT__, bin
    org     0x59BFA9
%endif

bits    32


section .text   align=1                                                    ; Prevent auto-alignment

    resetStackoffset 0x12AC
        mov     eax, [esp+stackoffset-0x129C+0x10]
        mov     [esp+stackoffset-0x12C8], eax
        jmp     0x59C247
