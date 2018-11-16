; Overwrite error message during parsing in zCParser::DeclarePrototype

%include "inc/macros.mac"

%if GOTHIC_BASE_VERSION == 1
    %include "inc/symboladdresses_g1.mac"
%elif GOTHIC_BASE_VERSION == 2
    %include "inc/symboladdresses_g2.mac"
%endif

%ifidn __OUTPUT_FORMAT__, bin
    org     g1g2(0x6F3766,0x79D017)
%endif

bits    32


section .text   align=1                                                    ; Prevent auto-alignment

    resetStackoffset 0xB8
        push    esi
        nop
        push    eax
        mov     BYTE [esp+stackoffset-0x4], 0x9
        call    ninja_parseMsgOverwrite
        pop     esi
