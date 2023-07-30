; Hook function parsing in zCParser::DeclareFunc

%include "inc/macros.inc"
%include "inc/symbols.inc"

%ifidn __OUTPUT_FORMAT__, bin
    org     g1g2(0x6F494E,0x72E5DE,0x73E76E,0x79E1AE)
%endif

bits    32


section .text   align=1                                                    ; Prevent auto-alignment

        jmp     parser_check_func

    %if GOTHIC_BASE_VERSION == 130 || GOTHIC_BASE_VERSION == 2
        times 2 nop
    %endif

        ; Overwrites
        ;    push    g1g2(0x5AE, 0x5AE, 0x3C, 0x3C)
        ; %if GOTHIC_BASE_VERSION == 130 || GOTHIC_BASE_VERSION == 2
        ;    call    operator_new
        ; %endif
