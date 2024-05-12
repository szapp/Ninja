; Overwrite error message during parsing in zCParser::DeclareVar

%include "inc/macros.inc"
%include "inc/symbols.inc"

%ifidn __OUTPUT_FORMAT__, bin
    org     g1g2(0x6F2113,0x72BBB3,0x73C07F,0x79BABF)
%endif

bits    32


section .text   align=1                                                    ; Prevent auto-alignment

    resetStackoffset g1g2(0x394,0x388,0x3EC,0x3EC)
        mov     eax, [g1g2(ebp,ebx,ebp,ebp)+0x8]
        push    eax
        push    esi
        call    ninja_allowRedefine
    addStack 2*4
    verifyStackoffset g1g2(0x394,0x388,0x3EC,0x3EC)
        jmp     g1g2(0x6F215B,0x72BBFC,0x73C0C7,0x79BB07)
