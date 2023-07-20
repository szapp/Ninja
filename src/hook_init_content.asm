; Hook initialization in oCGame::CallScriptInit
; In Gothic 1 there is no Init_Global, instead call AFTER Init_[World]

%include "inc/macros.inc"
%include "inc/symbols.inc"

%ifidn __OUTPUT_FORMAT__, bin
    org     g1g2(0x637F84,0x65E408,0x6C20C3)
%endif

bits    32


section .text   align=1                                                    ; Prevent auto-alignment

        jmp     init_content

    %if GOTHIC_BASE_VERSION == 1 || GOTHIC_BASE_VERSION == 112
        nop
    %endif

        ; Overwrites
        ;
        ; %if GOTHIC_BASE_VERSION == 1 || GOTHIC_BASE_VERSION == 112
        ;   mov    DWORD [zCParser_parser+zCParser_progressBar_offset], edi
        ; %elif GOTHIC_BASE_VERSION == 2
        ;   add     esp, 0x8
        ;   test    eax, eax
        ; %endif
