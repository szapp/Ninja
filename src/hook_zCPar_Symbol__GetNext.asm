; Hook retrieval of next Daedalus symbol in zCPar_Symbol::GetNext

%include "inc/macros.inc"

%if GOTHIC_BASE_VERSION == 1
    %include "inc/symbols_g1.inc"
%elif GOTHIC_BASE_VERSION == 2
    %include "inc/symbols_g2.inc"
%endif

%ifidn __OUTPUT_FORMAT__, bin
    org     g1g2(0x6F84D0,0x7A1DD0)
%endif

bits    32


section .text   align=1                                                    ; Prevent auto-alignment

        jmp     zCPar_Symbol__GetNext_fix
