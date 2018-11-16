; Overwrite error message during parsing in zCParser::DeclareVar

%include "inc/macros.mac"

%if GOTHIC_BASE_VERSION == 1
    %include "inc/symboladdresses_g1.mac"
%elif GOTHIC_BASE_VERSION == 2
    %include "inc/symboladdresses_g2.mac"
%endif

%ifidn __OUTPUT_FORMAT__, bin
    org     g1g2(0x6F2129,0x79BAD5)
%endif

bits    32


section .text   align=1                                                    ; Prevent auto-alignment

    resetStackoffset g1g2(0x394,0x3EC)
        push    esi
        nop
        push    eax
        mov     BYTE [esp+stackoffset-0x4], g1g2(0x16,0x11)
        call    ninja_parseMsgOverwrite
        pop     esi
