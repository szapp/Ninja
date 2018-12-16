; Hook initialization in oCGame::EnterWorld
; At the point of this additional initialization the player will be defined (hero) and inserted into the world

%include "inc/macros.inc"

%if GOTHIC_BASE_VERSION == 1
    %include "inc/symbols_g1.inc"
%elif GOTHIC_BASE_VERSION == 2
    %include "inc/symbols_g2.inc"
%endif

%ifidn __OUTPUT_FORMAT__, bin
    org     g1g2(0x63EC9C,0x6C98D9)
%endif

bits    32


section .text   align=1                                                    ; Prevent auto-alignment

        jmp     init_posthero

        ; Overwrites
        ;
        ; %if GOTHIC_BASE_VERSION == 1
        ;   mov     ecx, ebp
        ;   call    DWORD [edx+0x70]
        ; %elif GOTHIC_BASE_VERSION == 2
        ;   mov     ecx, esi
        ;   call    DWORD [edx+0x70]
        ; %endif
