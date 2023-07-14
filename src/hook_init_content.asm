; Hook initialization in oCGame::CallScriptInit
; In Gothic 1 there is no Init_Global, instead call AFTER Init_[World]

%include "inc/macros.inc"
%include "inc/symbols.inc"

%ifidn __OUTPUT_FORMAT__, bin
    org     g1g2(0x637F84,0,0x6C20C3)
%endif

bits    32


section .text   align=1                                                    ; Prevent auto-alignment

        jmp     init_content

    %if GOTHIC_BASE_VERSION == 1
        nop
    %endif

        ; Overwrites
        ;
        ; %if GOTHIC_BASE_VERSION == 1
        ;   mov     DWORD [0x8DDF90], edi
        ; %elif GOTHIC_BASE_VERSION == 2
        ;   add     esp, 0x8
        ;   test    eax, eax
        ; %endif
