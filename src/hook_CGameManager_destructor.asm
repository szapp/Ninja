; Hook improper destruction of CGameManager to ensure deinitialization of VDFS to release data file

%include "inc/macros.inc"
%include "inc/symbols.inc"

%ifidn __OUTPUT_FORMAT__, bin
    org     g1g2(0x423BDC,0x4265C4,0,0x4247CC)
%endif

bits    32


section .text   align=1                                                    ; Prevent auto-alignment

        jmp     CGameMananager_destruction_deinit_vdfs
