; Hook retrieval of next Daedalus symbol in zCPar_Symbol::GetNext

%include "inc/macros.inc"
%include "inc/symbols.inc"

%ifidn __OUTPUT_FORMAT__, bin
    org     g1g2(0x6F84D0,0x732740,0,0x7A1DD0)
%endif

bits    32


section .text   align=1                                                    ; Prevent auto-alignment

        jmp     zCPar_Symbol__GetNext_fix
