; Continued collection of functions

%include "inc/macros.mac"
%include "inc/engine.mac"

%ifidn __OUTPUT_FORMAT__, bin
    org     g1g2(0x410BAB,0x4110AB)
%endif

bits    32


section .text

        ; Redirect current function to jump beyond to make space
        jmp     g1g2(0x410DD5,0x41133D)


%include "func/initAnims.asm"

        times 6 nop


section .data

        NINJA_LOAD_ANIM     db   "J: MDS: Appending animations from ", 0
