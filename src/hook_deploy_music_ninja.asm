; Hook music parser in zCMusicSys_DirectMusic::zCMusicSys_DirectMusic

%include "inc/macros.mac"

%if GOTHIC_BASE_VERSION == 1
    %include "inc/symbols_g1.mac"
%elif GOTHIC_BASE_VERSION == 2
    %include "inc/symbols_g2.mac"
%endif

%ifidn __OUTPUT_FORMAT__, bin
    org     g1g2(0x4DA448,0x4E765C)
%endif

bits    32


section .text   align=1                                                    ; Prevent auto-alignment

        jmp     deploy_music_ninja

        ; Overwrites
        ; resetStackoffset g1g2(0xD8,0xC8)
        ; lea     edx, [esp+stackoffset+g1g2(-0xC5,-0xB5)]
        ; push    edx
