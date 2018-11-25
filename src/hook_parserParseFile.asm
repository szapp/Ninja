; Resolve '..\' in file paths when parsing

%include "inc/macros.inc"

%if GOTHIC_BASE_VERSION == 1
    %include "inc/symbols_g1.inc"
%elif GOTHIC_BASE_VERSION == 2
    %include "inc/symbols_g2.inc"
%endif

%ifidn __OUTPUT_FORMAT__, bin
    org     g1g2(0x6E6654,0x78F878)
%endif

bits    32


section .text   align=1                                                    ; Prevent auto-alignment

        jmp     parser_resolve_path_d
