; Divert execution if zCNetMessage::Get fails in zCNetEventManager::HandleNetMessage to preserve the freed address space

%include "inc/macros.inc"

%ifidn __OUTPUT_FORMAT__, bin
    org     g1g2(0x452724,0x45759C)
%endif

bits    32


section .text   align=1                                                    ; Prevent auto-alignment

        jz      g1g2(0x452BAB,0x457AD3)
