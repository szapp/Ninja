; Overwrite call to zCPlayerInfo::GetName(void) in zCPlayerInfo::SetActive(void)

%include "inc/macros.inc"
%include "inc/engine.inc"
%include "inc/symbols.inc"

%ifidn __OUTPUT_FORMAT__, bin
    org     g1g2(0x462F13,0x46A9CD,0x4679DA,0x46860A)
%endif

bits    32


section .text   align=1                                                    ; Prevent auto-alignment

        call    zCPlayerInfo__GetName_empty
