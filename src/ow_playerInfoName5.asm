; Overwrite call to zCPlayerInfo::GetName(void) in zCWorldInfo::ShowDebugInfo(void)

%include "inc/macros.inc"
%include "inc/engine.inc"

%if GOTHIC_BASE_VERSION == 1
    %include "inc/symbols_g1.inc"
%elif GOTHIC_BASE_VERSION == 2
    %include "inc/symbols_g2.inc"
%endif

%ifidn __OUTPUT_FORMAT__, bin
    org     g1g2(0x46AAD7,0x46FF1B)
%endif

bits    32


section .text   align=1                                                    ; Prevent auto-alignment

        call    zCPlayerInfo__GetName_empty
