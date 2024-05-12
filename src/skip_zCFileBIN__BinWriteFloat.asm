; Disable function zCFileBIN::BinWriteFloat

%include "inc/macros.inc"

%if GOTHIC_BASE_VERSION != 130 && GOTHIC_BASE_VERSION != 2
    %fatal This file is for Gothic 1.30 and Gothic 2 only
%endif

%ifidn __OUTPUT_FORMAT__, bin
    org     g1g2(0x000000,0x000000,0x597C20,0x59D180)
%endif

bits    32


section .text   align=1                                                    ; Prevent auto-alignment

        ret     0x4
