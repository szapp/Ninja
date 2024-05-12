; Overwrite the setting of a integer constant

%include "inc/macros.inc"
%include "inc/symbols.inc"

%ifidn __OUTPUT_FORMAT__, bin
    org     g1g2(0x6F2451,0x72BEA6,0x73C390,0x79BDD0)
%endif

bits    32


section .text   align=1                                                    ; Prevent auto-alignment

        jmp     parser_verify_ikarus_version
        times 3 nop
