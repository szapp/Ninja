; Overwrite the version information at the bottom right of the game menu

%include "inc/macros.inc"

%ifidn __OUTPUT_FORMAT__, bin
    org     g1g2(0x7CF576,0x82D48F)
%endif

bits    32


section .data   align=1                                                    ; Prevent auto-alignment

    %substr version NINJA_VERSION 2,3

    %if GOTHIC_BASE_VERSION == 1
        db  '1.08k-S1.7-N', version, 0, 0
    %elif GOTHIC_BASE_VERSION == 2
        db  '2.6fx-S1.7-N', version
    %endif

    ; Orig g1: 31 2E 30 38 6B 5F 6D 6F 64 28 53 50 20 31 2E 37 29
    ; Orig g2: 32 2E 36 28 66 69 78 2D 53 50 20 31 2E 37 29
