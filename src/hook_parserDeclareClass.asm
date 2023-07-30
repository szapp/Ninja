; Hook class parsing in zCParser::DeclareClass

%include "inc/macros.inc"
%include "inc/symbols.inc"

%ifidn __OUTPUT_FORMAT__, bin
    org     g1g2(0x6F2B21,0x72C545,0x73C9F2,0x79C432)
%endif

bits    32


section .text   align=1                                                    ; Prevent auto-alignment

        jmp     parser_check_class

        ; Overwrites
        ; %if GOTHIC_BASE_VERSION == 1 || GOTHIC_BASE_VERSION == 112
        ;   call    operator_new_len
        ; %elif GOTHIC_BASE_VERSION == 130 || GOTHIC_BASE_VERSION == 2
        ;   call    operator_new
        ; %endif
