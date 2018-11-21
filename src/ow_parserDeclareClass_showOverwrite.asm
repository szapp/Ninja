; Overwrite error message during parsing in zCParser::DeclareClass

%include "inc/macros.inc"

%if GOTHIC_BASE_VERSION == 1
    %include "inc/symbols_g1.inc"
%elif GOTHIC_BASE_VERSION == 2
    %include "inc/symbols_g2.inc"
%endif

%ifidn __OUTPUT_FORMAT__, bin
    org     g1g2(0x6F2BAC,0x79C4BD)
%endif

bits    32


section .text   align=1                                                    ; Prevent auto-alignment

    resetStackoffset 0x4C
        push    esi
        nop
        push    eax
        mov     BYTE [esp+stackoffset-0x4], 0x2
        call    ninja_parseMsgOverwrite
        pop     esi
