; Hook fast exit to ensure deinitialization of VDFS to release data file

%include "inc/macros.inc"
%include "inc/symbols.inc"

%ifidn __OUTPUT_FORMAT__, bin
    org     g1g2(0x4249B2,0,0,0x4256AF)
%endif

bits    32


section .text   align=1                                                    ; Prevent auto-alignment

        jmp     fastexit_deinit_vdfs
