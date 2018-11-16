; Hook function linking in zCParser::PushOnStack

%include "inc/macros.mac"

%if GOTHIC_BASE_VERSION == 1
    %include "inc/symboladdresses2_g1.mac"
%elif GOTHIC_BASE_VERSION == 2
    %include "inc/symboladdresses2_g2.mac"
%endif

%ifidn __OUTPUT_FORMAT__, bin
    org     g1g2(0x6E79C1,0x790CA8)
%endif

bits    32


section .text   align=1                                                    ; Prevent auto-alignment

        jmp     linker_replace_func

        ; Overwrites
        ; call    zCPar_Symbol__SetStackPos
