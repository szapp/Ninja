; Overwrite call to zCPlayerInfo::GetName(void) in zCWorldInfo::ShowDebugInfo(void)

%include "inc/macros.inc"
%include "inc/engine.inc"
%include "inc/symbols.inc"

%ifidn __OUTPUT_FORMAT__, bin
    org     g1g2(0x46AAD7,0,0x46FF1B)
%endif

bits    32


section .text   align=1                                                    ; Prevent auto-alignment

        call    zCPlayerInfo__GetName_empty
