; Overwrite writing bin file in zCModelPrototype::RegisterMesh

%include "inc/macros.mac"

%if GOTHIC_BASE_VERSION == 1
    %fatal This file is for Gothic 2 only
%endif

%ifidn __OUTPUT_FORMAT__, bin
    org     0x593D72
%endif

bits    32


section .text   align=1                                                    ; Prevent auto-alignment

        jmp     0x593E2B
