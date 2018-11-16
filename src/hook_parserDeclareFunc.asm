; Hook function parsing in zCParser::DeclareFunc

%include "inc/macros.mac"

%if GOTHIC_BASE_VERSION == 1
    %include "inc/symboladdresses2_g1.mac"
%elif GOTHIC_BASE_VERSION == 2
    %include "inc/symboladdresses2_g2.mac"
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
