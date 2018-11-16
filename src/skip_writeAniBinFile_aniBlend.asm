; Overwrite writing bin file for 'aniBlend' in zCModelPrototype::ReadAniEnum

%include "inc/macros.mac"

%if GOTHIC_BASE_VERSION == 1
    %fatal This file is for Gothic 2 only
%endif

%ifidn __OUTPUT_FORMAT__, bin
    org     0x597DCF
%endif

bits    32


section .text   align=1                                                    ; Prevent auto-alignment

        jmp     0x597F7F
