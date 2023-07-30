; Hook variable parsing in zCParser::DeclareVar

%include "inc/macros.inc"
%include "inc/symbols.inc"

%ifidn __OUTPUT_FORMAT__, bin
    org     g1g2(0x6F18CD,0x72B30A,0x73B975,0x79B3B5)
%endif

bits    32


section .text   align=1                                                    ; Prevent auto-alignment

        jmp     parser_check_var

    %if GOTHIC_BASE_VERSION == 130 || GOTHIC_BASE_VERSION == 2
        times 2 nop
    %endif

        ; Overwrites
        ;   push    g1g2(0x3BA, 0x3BA, 0x3C, 0x3C)
        ; %elif GOTHIC_BASE_VERSION == 2
        ;   call    operator_new
        ; %endif
