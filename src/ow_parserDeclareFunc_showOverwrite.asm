; Overwrite error message during parsing in zCParser::DeclareFunc

%include "inc/macros.inc"
%include "inc/symbols.inc"

%ifidn __OUTPUT_FORMAT__, bin
    org     g1g2(0x6F49C1,0,0x79E212)
%endif

bits    32


section .text   align=1                                                    ; Prevent auto-alignment

    resetStackoffset 0xA4
        mov     eax, [ebp+0x8]
        push    eax
        push    esi
        call    ninja_allowRedefine
    addStack 2*4
    verifyStackoffset 0xA4
        jmp     g1g2(0x6F49FD,0,0x79E24E)
