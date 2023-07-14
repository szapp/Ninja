; Overwrite error message during parsing in zCParser::DeclareVar

%include "inc/macros.inc"
%include "inc/symbols.inc"

%ifidn __OUTPUT_FORMAT__, bin
    org     g1g2(0x6F2113,0,0x79BABF)
%endif

bits    32


section .text   align=1                                                    ; Prevent auto-alignment

    resetStackoffset g1g2(0x394,0,0x3EC)
        mov     eax, [ebp+0x8]
        push    eax
        push    esi
        call    ninja_allowRedefine
    addStack 2*4
    verifyStackoffset g1g2(0x394,0,0x3EC)
        jmp     g1g2(0x6F215B,0,0x79BB07)
