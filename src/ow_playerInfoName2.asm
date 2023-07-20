; Overwrite call to zCPlayerInfo::GetName(void) in zCPlayerInfo::~zCPlayerInfo(void)

%include "inc/macros.inc"
%include "inc/engine.inc"
%include "inc/symbols.inc"

%ifidn __OUTPUT_FORMAT__, bin
    org     g1g2(0x462475,0,0,0x467B15)
%endif

bits    32


section .text   align=1                                                    ; Prevent auto-alignment

        call    zCPlayerInfo__GetName_empty
