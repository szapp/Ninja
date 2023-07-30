; Overwrite check for non-existent symbol in zCParser::LoadGlobalVars

%include "inc/macros.inc"

%if GOTHIC_BASE_VERSION != 130 && GOTHIC_BASE_VERSION != 2
    %fatal This file is for Gothic 130 / 2 only
%endif

%ifidn __OUTPUT_FORMAT__, bin
    org     g1g2(0x000000,0x000000,0x737905,0x797345)
%endif

bits    32


section .text   align=1                                                    ; Prevent auto-alignment

        jz      g1g2(,,0x737937,0x797377)
