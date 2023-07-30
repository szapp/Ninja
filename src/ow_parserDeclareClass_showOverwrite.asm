; Overwrite error message during parsing in zCParser::DeclareClass

%include "inc/macros.inc"
%include "inc/symbols.inc"

%ifidn __OUTPUT_FORMAT__, bin
    org     g1g2(0x6F2B99,0x72C5CC,0x73CA6A,0x79C4AA)
%endif

bits    32


section .text   align=1                                                    ; Prevent auto-alignment

    resetStackoffset
        mov     eax, [eax+0x8]
        push    eax
        push    esi
        call    ninja_allowRedefine
    addStack 2*4
    verifyStackoffset
        jmp     g1g2(0x6F2BEA,0x72C637,0x73CABB,0x79C4FB)
