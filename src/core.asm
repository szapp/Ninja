; Core of the executing code of Ninja

%include "inc/macros.inc"
%include "inc/engine.inc"

%ifidn __OUTPUT_FORMAT__, bin
    org     g1g2(0x452640,0x457470)
%endif

bits    32

; This address space spans multiple methods of the deprecated class
; 'zCNetEventManager' starting with zCNetEventManager::HandleNetMessage.
; After a long testing period any safety checks for ensuring that the
; overwritten methods are indeed never called are now omitted.

section .text

%include "func/freeVdfArray.asm"
%include "func/dispatch.asm"
%include "func/parseVersionString.asm"
%include "func/scriptPathInvalid.asm"
%include "func/resolvePath.asm"
%include "func/debugMessage.asm"
%include "func/zCPar_Symbol__GetNext_fix.asm"
%include "func/armParser.asm"
%include "func/injectSrc.asm"
%include "func/injectMds.asm"
%include "func/injectOU.asm"
%include "func/initMenu.asm"
%include "func/initContent.asm"
%include "func/initPostHero.asm"
%include "func/conEvalFunc.asm"

%include "exec/createVdfArray.asm"
%include "exec/deploy.asm"
%include "exec/init.asm"
%include "exec/parse.asm"


section .data   align=1                                                    ; Prevent auto-alignment

%include "data/core.asm"
