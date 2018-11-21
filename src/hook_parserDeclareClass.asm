; Hook class parsing in zCParser::DeclareClass

%include "inc/macros.inc"

%if GOTHIC_BASE_VERSION == 1
    %include "inc/symbols_g1.inc"
%elif GOTHIC_BASE_VERSION == 2
    %include "inc/symbols_g2.inc"
%endif

%ifidn __OUTPUT_FORMAT__, bin
    org     g1g2(0x6F2B21,0x79C432)
%endif

bits    32


section .text   align=1                                                    ; Prevent auto-alignment

        jmp     parser_check_class

        ; Overwrites
        ; %if GOTHIC_BASE_VERSION == 1
        ;   call    operator_new_len
        ; %elif GOTHIC_BASE_VERSION == 2
        ;   call    operator_new
        ; %endif
