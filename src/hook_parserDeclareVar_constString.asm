; Overwrite the setting of a string constant

%include "inc/macros.inc"
%include "inc/symbols.inc"

%ifidn __OUTPUT_FORMAT__, bin
    org     g1g2(0x6F24AC,0x72BF00,0x73C3EB,0x79BE2B)
%endif

bits    32


section .text   align=1                                                    ; Prevent auto-alignment

        jmp     parser_verify_lego_version
