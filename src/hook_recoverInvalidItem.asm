; Hook oCNpcInventory::Unarchive to recover invalid items to continue with the remaining ones
; When a spell item (rune or scroll) in the inventory does no longer exist in the game, loading results in a crash
; This hook tries to recover that crash

%include "inc/macros.inc"
%include "inc/symbols.inc"

%ifidn __OUTPUT_FORMAT__, bin
    org     g1g2(0x66DC47,0x69B420,0x6AFBB9,0x70D6D9)
%endif

bits    32


section .text   align=1                                                    ; Prevent auto-alignment

        jmp     recoverInvalidItem
        nop

    %if GOTHIC_BASE_VERSION == 1 || GOTHIC_BASE_VERSION == 112
        times 2 nop
    %endif

        ; Overwrites
        ; %if GOTHIC_BASE_VERSION == 1 || GOTHIC_BASE_VERSION == 112
        ;   mov     [esp+0x90-0x74], 0xFFFFFFFF
        ; %elif GOTHIC_BASE_VERSION == 130 || GOTHIC_BASE_VERSION == 2
        ;   jz      g1g2(,,0x6AFDA0,0x70D8C0)
        ; %endif
