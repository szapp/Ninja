; Overwrite call to zCPlayerInfo::GetName(void) in zCPlayerInfo::CreateDistinctPlayer(void)

%include "inc/macros.inc"
%include "inc/engine.inc"
%include "inc/symbols.inc"

%ifidn __OUTPUT_FORMAT__, bin
    org     g1g2(0x4626FA,0,0,0x467DC2)
%endif

bits    32


section .text   align=1                                                    ; Prevent auto-alignment

        call    zCPlayerInfo__GetName_empty
