; Overwrite error message during parsing in zCParser::DeclarePrototype

%include "inc/macros.inc"
%include "inc/symbols.inc"

%ifidn __OUTPUT_FORMAT__, bin
    org     g1g2(0x6F3753,0,0x79D004)
%endif

bits    32


section .text   align=1                                                    ; Prevent auto-alignment

    resetStackoffset 0xB8
        mov     eax, [eax+0x8]
        push    eax
        push    esi
        call    ninja_allowRedefine
    addStack 2*4
    verifyStackoffset 0xB8
        jmp     g1g2(0x6F3794,0,0x79D045)
