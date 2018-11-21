; Hook function parsing in zCParser::DeclareFunc

%include "inc/macros.inc"

%if GOTHIC_BASE_VERSION == 1
    %include "inc/symbols_g1.inc"
%elif GOTHIC_BASE_VERSION == 2
    %include "inc/symbols_g2.inc"
%endif

%ifidn __OUTPUT_FORMAT__, bin
    org     g1g2(0x6F494E,0x79E1AE)
%endif

bits    32


section .text   align=1                                                    ; Prevent auto-alignment

        jmp     parser_check_func

    %if GOTHIC_BASE_VERSION == 2
        times 2 nop
    %endif

        ; Overwrites
        ; %if GOTHIC_BASE_VERSION == 1
        ;   push    0x5AE
        ; %elif GOTHIC_BASE_VERSION == 2
        ;   push    0x3C
        ;   call    operator_new
        ; %endif
