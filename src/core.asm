; Core of the executing code of Ninja

%include "inc/macros.inc"
%include "inc/engine.inc"

%ifidn __OUTPUT_FORMAT__, bin
    org     g1g2(0x452640,0x457470)
%endif

bits    32


section .text

        ; Immediately return from zCNetEventManager::HandleNetMessage
        ret


%include "func/findVdfSrc.asm"
%include "func/initContent.asm"
%include "func/initMenu.asm"
%include "func/mergeSrc.asm"
%include "func/inject.asm"
%include "func/parseMsgOverwrite.asm"
%include "func/zCPar_Symbol__GetNext_fix.asm"
%include "func/initAnims.asm"

%include "exec/deploy.asm"
%include "exec/init.asm"
%include "exec/parse.asm"
%include "exec/misc.asm"


section .data   align=1                                                    ; Prevent auto-alignment

%include "data/core.asm"
