; Hook oCNpc::Unarchive to recover the archiver's cursor on previously invalid items

%include "inc/macros.inc"
%include "inc/symbols.inc"

%ifidn __OUTPUT_FORMAT__, bin
    org     g1g2(0x6A3DD9,0x6D67BB,0x6E96C1,0x748161)
%endif

bits    32


section .text   align=1                                                    ; Prevent auto-alignment

        jmp     recoverInvalidItem2
        nop

        ; Overwrites
        ;   call    [ebx+0x80]
