; Collection of functions referenced elsewhere

%include "inc/macros.mac"
%include "inc/engine.mac"

%ifidn __OUTPUT_FORMAT__, bin
    org     g1g2(0x4087A9,0x408A1D)
%endif

bits    32


section .text

        ; Redirect current function to jump beyond to make space
        jmp     g1g2(0x408BCA,0x408E67)


%include "func/findVdfSrc.asm"
        times 84 nop
%include "func/initContent.asm"
        times 6 nop
%include "func/initMenu.asm"
        times 6 nop
%include "func/mergeSrc.asm"
        times 6 nop
%include "func/inject.asm"
        times 2 nop
%include "func/parseMsgOverwrite.asm"
        times 6 nop
%include "func/zCPar_Symbol__GetNext_fix.asm"

        times 6 nop


section .data

        NINJA_PATH_VDF  db "DATA\NINJA_*.VDF", 0
