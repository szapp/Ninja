; Overwrite the version information at the bottom right of the game menu

%include "inc/macros.inc"

%ifidn __OUTPUT_FORMAT__, bin
    org     g1g2(0x839D18,0x89DA98)
%endif

bits    32


section .data   align=1                                                    ; Prevent auto-alignment

    %substr .version NINJA_VERSION 2,3

    db  g1g2('1.08k-N','2.6fx-N'), .version, 0
