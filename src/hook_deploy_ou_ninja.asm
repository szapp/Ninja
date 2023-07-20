; Hook OU loader in/after zCCSManager::LibForceToLoad

%include "inc/macros.inc"
%include "inc/symbols.inc"

%ifidn __OUTPUT_FORMAT__, bin
    org     g1g2(0x41BE77,0x41DCD7,0,0x41C407)
%endif

bits    32


section .text   align=1                                                    ; Prevent auto-alignment

        jmp     deploy_ou_ninja

        ; Overwrites
        ; ret
