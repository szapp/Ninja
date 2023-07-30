; Hook prototype parsing in zCParser::DeclarePrototype

%include "inc/macros.inc"
%include "inc/symbols.inc"

%ifidn __OUTPUT_FORMAT__, bin
    org     g1g2(0x6F36B2,0x72D1EA,0x73D532,0x79CF72)
%endif

bits    32


section .text   align=1                                                    ; Prevent auto-alignment

        jmp     parser_check_prototype

    %if GOTHIC_BASE_VERSION == 130 || GOTHIC_BASE_VERSION == 2
        times 2 nop
    %endif

        ; Overwrites
        ; %if GOTHIC_BASE_VERSION == 1 || GOTHIC_BASE_VERSION == 112
        ;   push    0x4DF
        ; %elif GOTHIC_BASE_VERSION == 130 || GOTHIC_BASE_VERSION == 2
        ;   push    0x3C
        ;   call    operator_new
        ; %endif
