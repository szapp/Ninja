; Overwrite call to zCPlayerInfo::GetName(void) in zCPlayerGroup::ShowDebugInfo(void)

%include "inc/macros.inc"
%include "inc/engine.inc"
%include "inc/symbols.inc"

%ifidn __OUTPUT_FORMAT__, bin
    org     g1g2(0x4618DB,0x4692B2,0x46639E,0x466FCE)
%endif

bits    32


section .text   align=1                                                    ; Prevent auto-alignment

        call    zCPlayerInfo__GetName_empty
