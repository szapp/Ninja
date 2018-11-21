; Overwrite writing bin file in zCModelPrototype::ModelTag

%include "inc/macros.inc"

%if GOTHIC_BASE_VERSION == 1
    %fatal This file is for Gothic 2 only
%endif

%ifidn __OUTPUT_FORMAT__, bin
    org     0x5999AE
%endif

bits    32


section .text   align=1                                                    ; Prevent auto-alignment

        jmp     0x599C65
