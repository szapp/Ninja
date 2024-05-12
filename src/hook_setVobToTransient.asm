; Hook oCNpc::InitByScript to set dontWriteToArchive flag for instances from patches

%include "inc/macros.inc"
%include "inc/symbols.inc"

%ifidn __OUTPUT_FORMAT__, bin
    org     g1g2(0x68CB31,0x6BD2E0,0x6D0F01,0x72F161)
%endif

bits    32


section .text   align=1                                                    ; Prevent auto-alignment

        jmp     setVobToTransient
        nop
