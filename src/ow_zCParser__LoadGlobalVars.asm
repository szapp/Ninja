; Overwrite check for non-existent symbol in zCParser::LoadGlobalVars

%include "inc/macros.inc"

%if GOTHIC_BASE_VERSION == 1
    %fatal This file is for Gothic 2 only
%endif

%ifidn __OUTPUT_FORMAT__, bin
    org     0x797345
%endif

bits    32


section .text   align=1                                                    ; Prevent auto-alignment

        jz      0x797377
