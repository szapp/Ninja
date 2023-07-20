; Hook prototype parsing in zCParser::DeclarePrototype

%include "inc/macros.inc"
%include "inc/symbols.inc"

%ifidn __OUTPUT_FORMAT__, bin
    org     g1g2(0x6F36B2,0,0,0x79CF72)
%endif

bits    32


section .text   align=1                                                    ; Prevent auto-alignment

        jmp     parser_check_prototype

        ; Overwrites
        ; %if GOTHIC_BASE_VERSION == 1
        ;   push    0x4DF
        ; %elif GOTHIC_BASE_VERSION == 2
        ;   push    0x3C
        ;   call    operator_new
        ; %endif
