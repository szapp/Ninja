; Hook reading of animations in zCModelPrototype::ReadAniEnum (g1), zCModelPrototype::ReadAniEnumMSB (g2)

%include "inc/macros.inc"
%include "inc/symbols.inc"

%ifidn __OUTPUT_FORMAT__, bin
    org     g1g2(0x57DC40,0x598474,0x590C6D,0x5961CD)
%endif

bits    32


section .text   align=1                                                    ; Prevent auto-alignment

        jmp     deploy_ani_ninja
        times 2 nop

        ; Overwrites
        ; %if GOTHIC_BASE_VERSION == 1 || GOTHIC_BASE_VERSION == 112
        ;   resetStackoffset g1g2(0xF54,0xFD8,,)
        ;   cmp     [esp+stackoffset-g1g2(0xE88,0xF20,,)], ebp
        ; %elif GOTHIC_BASE_VERSION == 130 || GOTHIC_BASE_VERSION == 2
        ;   resetStackoffset 0x49C
        ;   mov     eax, [esp+stackoffset-0x3E0]
        ; %endif
