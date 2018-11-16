; Overwrite writing bin file in zCModelPrototype::ReadMeshAndTree

%include "inc/macros.mac"

%if GOTHIC_BASE_VERSION == 1
    %fatal This file is for Gothic 2 only
%endif

%ifidn __OUTPUT_FORMAT__, bin
    org     0x5937DE
%endif

bits    32


section .text   align=1                                                    ; Prevent auto-alignment

        jmp     0x59388B
