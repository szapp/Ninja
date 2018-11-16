; Overwrite 'ani' in zCModelPrototype::ReadAniEnum

%include "inc/macros.mac"
%include "inc/engine.mac"

%if GOTHIC_BASE_VERSION == 1
    %include "inc/symboladdresses_g1.mac"
%elif GOTHIC_BASE_VERSION == 2
    %include "inc/symboladdresses_g2.mac"
%endif

%ifidn __OUTPUT_FORMAT__, bin
    org     g1g2(0x57D639,0x59C406)
%endif

bits    32


section .text   align=1                                                    ; Prevent auto-alignment

    resetStackoffset g1g2(0xF54,0x1310)
        push    eax                                                        ; Existing zCModelAni *
        mov     ecx, [esp+stackoffset+g1g2(-0xF24,-0x12C8)]
        push    ecx
        mov     edx, [esp+stackoffset+g1g2(-0xF44,-0x12FC)]
        add     edx, 0x24
        call    zCModelPrototype__SearchAniIndex                           ; __fastcall
        pop     ecx
        mov     ecx, [ecx+0x48]
        mov     edx, [esp+stackoffset+g1g2(-0xF44,-0x12FC)]
        mov     [ecx+eax*4], edx                                           ; New ani
        pop     ecx                                                        ; Old ani
        mov     eax, [ecx+0x4]
        dec     eax                                                        ; Decrease refCtr
        mov     [ecx+0x4], eax
        cmp     eax, 0
    verifyStackoffset g1g2(0xF54,0x1310)
        jg      g1g2(0x57D8F8,0x59C6C3)                                    ; Continue
        push    0x1                                                        ; If refCtr <= 0 then
        call    zCModelAni__deleting_destructor
    addStack 4
    verifyStackoffset g1g2(0xF54,0x1310)
        jmp     g1g2(0x57D8F8,0x59C6C3)
    ; Room to 0x57D69A (g1), 0x59C459 (g2)
