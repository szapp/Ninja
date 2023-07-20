; Hook function linking in zCParser::PushOnStack

%include "inc/macros.inc"
%include "inc/symbols.inc"

%ifidn __OUTPUT_FORMAT__, bin
    org     g1g2(0x6E79C1,0,0,0x790CA8)
%endif

bits    32


section .text   align=1                                                    ; Prevent auto-alignment

        jmp     linker_replace_func

        ; Overwrites
        ; call    zCPar_Symbol__SetStackPos
