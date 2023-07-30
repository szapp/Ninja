; Resolve 'Ikarus' and 'LeGo' in SRC files when parsing

%include "inc/macros.inc"
%include "inc/symbols.inc"

%ifidn __OUTPUT_FORMAT__, bin
    org     g1g2(0x6E5F19,0x71EAB5,0x72F759,0x78F199)
%endif

bits    32


section .text   align=1                                                    ; Prevent auto-alignment

        jmp     parser_resolve_path_src
