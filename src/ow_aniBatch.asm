; Overwrite 'aniBatch' in zCModelPrototype::ReadAniEnum

%include "inc/macros.inc"
%include "inc/engine.inc"
%include "inc/symbols.inc"

%ifidn __OUTPUT_FORMAT__, bin
    org     g1g2(0x57A72A,0,0x59875B)
%endif

bits    32


section .text   align=1                                                    ; Prevent auto-alignment

    resetStackoffset g1g2(0xF54,0,0x128C)
        push    eax                                                        ; Existing zCModelAni *
        mov     ecx, [esp+stackoffset+g1g2(-0xF24,0,-0x1244)]                ; zCModelPrototype *
        push    ecx
    %if GOTHIC_BASE_VERSION == 1
        mov     edx, [esp+stackoffset-0xF38]                               ; New zCModelAni *
        add     edx, 0x24
    %elif GOTHIC_BASE_VERSION == 2
        mov     edx, edi                                                   ; New zCModelAni *
    %endif
        call    zCModelPrototype__SearchAniIndex                           ; __fastcall
        pop     ecx
        mov     ecx, [ecx+0x48]
    %if GOTHIC_BASE_VERSION == 1
        mov     edx, [esp+stackoffset-0xF38]
    %endif
        mov     [ecx+eax*0x4], g1g2(edx,0,ebp)                             ; New ani
        pop     ecx                                                        ; Old ani
        mov     eax, [ecx+0x4]
        dec     eax                                                        ; Decrease refCtr
        mov     [ecx+0x4], eax
        cmp     eax, 0
    verifyStackoffset g1g2(0xF54,0,0x128C)
        jg      g1g2(0x57A795,0,0x5987C4)                                  ; Continue
        push    0x1                                                        ; If refCtr <= 0 then
        call    zCModelAni__deleting_destructor
    addStack 4
    verifyStackoffset g1g2(0xF54,0,0x128C)
        jmp     g1g2(0x57A795,0,0x5987C4)                                  ; Continue
    ; Room to 0x57A783 (g1), 0x5987AE (g2)
