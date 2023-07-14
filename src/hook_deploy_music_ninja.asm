; Hook music parser in zCMusicSys_DirectMusic::zCMusicSys_DirectMusic

%include "inc/macros.inc"
%include "inc/symbols.inc"

%ifidn __OUTPUT_FORMAT__, bin
    org     g1g2(0x4DA448,0,0x4E765C)
%endif

bits    32


section .text   align=1                                                    ; Prevent auto-alignment

        jmp     deploy_music_ninja

        ; Overwrites
        ; resetStackoffset g1g2(0xD8,0,0xC8)
        ; lea     edx, [esp+stackoffset+g1g2(-0xC5,0,-0xB5)]
        ; push    edx
