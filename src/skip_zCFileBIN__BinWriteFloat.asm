; Disable function zCFileBIN::BinWriteFloat

%include "inc/macros.inc"

%if GOTHIC_BASE_VERSION == 1
    %fatal This file is for Gothic 2 only
%endif

%ifidn __OUTPUT_FORMAT__, bin
    org     0x59D180
%endif

bits    32


section .text   align=1                                                    ; Prevent auto-alignment

        ret     0x4
