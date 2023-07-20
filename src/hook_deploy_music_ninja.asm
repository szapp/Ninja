; Hook music parser in zCMusicSys_DirectMusic::zCMusicSys_DirectMusic

%include "inc/macros.inc"
%include "inc/symbols.inc"

%ifidn __OUTPUT_FORMAT__, bin
    org     g1g2(0x4DA448,0x4EB55C,0x4E4B83,0x4E765C)
%endif

bits    32


section .text   align=1                                                    ; Prevent auto-alignment

        jmp     deploy_music_ninja

        ; Overwrites
        ; resetStackoffset g1g2(0xD8,0xB0,0xB0,0xC8)
        ; lea     g1g2(edx,eax,eax,edx), [esp+stackoffset+g1g2(-0xC5,-0x9D,-0x9D,-0xB5)]
        ; push    g1g2(edx,eax,eax,edx)
