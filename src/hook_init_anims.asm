; Hook reading of animations in zCModelPrototype::ReadAniEnum (g1), zCModelPrototype::ReadAniEnumMSB (g2)

%include "inc/macros.mac"

%if GOTHIC_BASE_VERSION == 1
    %include "inc/symbols_g1.mac"
%elif GOTHIC_BASE_VERSION == 2
    %include "inc/symbols_g2.mac"
%endif

%ifidn __OUTPUT_FORMAT__, bin
    org     g1g2(0x57DC40,0x5961CD)
%endif

bits    32


section .text   align=1                                                    ; Prevent auto-alignment

        jmp     init_anims
        times 2 nop

        ; Overwrites
        ; %if GOTHIC_BASE_VERSION == 1
        ;   resetStackoffset 0xF54
        ;   cmp     [esp+stackoffset-0xE88], ebp
        ; %elif GOTHIC_BASE_VERSION == 2
        ;   resetStackoffset 0x49C
        ;   mov     eax, [esp+stackoffset-0x3E0]
        ; %endif
