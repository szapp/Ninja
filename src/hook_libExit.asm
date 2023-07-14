; Hook libExit(void) to ensure deinitialization of VDFS to release data file

%include "inc/macros.inc"
%include "inc/symbols.inc"

%ifidn __OUTPUT_FORMAT__, bin
    org     g1g2(0x4F3C30,0,0x502AB0)
%endif

bits    32


section .text   align=1                                                    ; Prevent auto-alignment

        jmp     libExit_deinit_vdfs
