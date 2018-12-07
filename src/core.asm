; Core of the executing code of Ninja

%include "inc/macros.inc"
%include "inc/engine.inc"

%ifidn __OUTPUT_FORMAT__, bin
    org     g1g2(0x453410,0x458380)
%endif

bits    32


section .text

        ; Immediately return from zCNetEventManager::OnMessage(zCEventMessage *, zCVob *)
        ret     0x8


%include "func/freeVdfArray.asm"
%include "func/findVdfSrc.asm"
%include "func/parseVersionString.asm"
%include "func/resolvePath.asm"
%include "func/initContent.asm"
%include "func/initMenu.asm"
%include "func/mergeSrc.asm"
%include "func/inject.asm"
%include "func/parseMsgOverwrite.asm"
%include "func/zCPar_Symbol__GetNext_fix.asm"
%include "func/injectOU.asm"
%include "func/initAnims.asm"
%include "func/conEvalFunc.asm"

%include "exec/createVdfArray.asm"
%include "exec/deploy.asm"
%include "exec/init.asm"
%include "exec/parse.asm"


section .data   align=1                                                    ; Prevent auto-alignment

%include "data/core.asm"
