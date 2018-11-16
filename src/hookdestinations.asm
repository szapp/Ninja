; Collection of hook destinations deploying the ninjas and overwriting parsing

%include "inc/macros.mac"
%include "inc/engine.mac"

%if GOTHIC_BASE_VERSION == 1
    %include "inc/symboladdresses_g1.mac"
%elif GOTHIC_BASE_VERSION == 2
    %include "inc/symboladdresses_g2.mac"
%endif

%ifidn __OUTPUT_FORMAT__, bin
    org     g1g2(0x452873,0x457791)
%endif

bits    32


section .text

        ; Redirect current function to jump beyond to make space
        nop
        jmp     g1g2(0x4530B2,0x4580AE)


%include "exec/deploy.asm"
        times 6 nop
%include "exec/init.asm"
        times g1g2(6,5) nop
%include "exec/parse.asm"
        times 6 nop
%include "exec/misc.asm"

        times 12 nop


section .data   align=1                                                    ; Prevent auto-alignment

%include "data/core.asm"
