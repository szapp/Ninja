; Hook camera parser in zCAICamera::StartUp

%include "inc/macros.inc"
%include "inc/symbols.inc"

%ifidn __OUTPUT_FORMAT__, bin
    org     g1g2(0x49909E,0x4A6138,0x4A0554)
%endif

bits    32


section .text   align=1                                                    ; Prevent auto-alignment

        jmp     deploy_camera_ninja

        ; Overwrites
        ; resetStackoffset g1g2(0xB4,0,0xB8)
        ; lea     g1g2(eax,edx,edx), [esp+stackoffset+g1g2(-0xA1,-0x89,-0xA5)]
        ; push    g1g2(eax,edx,edx)
