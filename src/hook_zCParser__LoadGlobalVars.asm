; Hook loading of global Daedalus symbols in zCParser::LoadGlobalVars

%include "inc/macros.inc"
%include "inc/symbols.inc"

%ifidn __OUTPUT_FORMAT__, bin
    org     g1g2(0x6EDAD5,0x727105,0x7379A1,0x7973E1)
%endif

bits    32


section .text   align=1                                                    ; Prevent auto-alignment

        jmp     createGlobalVarIfNotExist
%if GOTHIC_BASE_VERSION == 130 || GOTHIC_BASE_VERSION == 2
        nop
%endif
