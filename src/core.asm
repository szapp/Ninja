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

%include "exec/createVdfArray.asm"
%include "exec/deploy.asm"
%include "exec/init.asm"
%include "exec/parse.asm"
%include "exec/misc.asm"

%include "func/freeVdfArray.asm"
%include "func/dispatch.asm"
%include "func/parseVersionString.asm"
%include "func/scriptPathInvalid.asm"
%include "func/debugMessage.asm"
%include "func/zCPar_Symbol__GetNext_fix.asm"
%include "func/createSymbol.asm"
%include "func/armParser.asm"
%include "func/allowRedefine.asm"
%include "func/injectSrc.asm"
%include "func/injectMds.asm"
%include "func/injectOU.asm"
%include "func/initMenu.asm"
%include "func/initContent.asm"
%include "func/conEvalFunc.asm"
%include "func/oCSpawnManager__Archive_fix.asm"
%include "func/zCPlayerInfo__GetName_empty.asm"


section .data

%include "data/symbols.asm"
%include "data/io.asm"
%include "data/console.asm"
%include "data/messages.asm"
