; Hook oCNpc::CleanUp to remove instance references

%include "inc/macros.inc"
%include "inc/symbols.inc"

%ifidn __OUTPUT_FORMAT__, bin
    org     g1g2(0x68C0F6,0x6BC7DD,0x6D0445,0x72E625)
%endif

bits    32


section .text   align=1                                                    ; Prevent auto-alignment

        jmp     removeNpcInstRef
        nop
