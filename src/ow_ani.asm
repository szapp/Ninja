; Overwrite 'ani' in zCModelPrototype::ReadAniEnum

%include "inc/macros.inc"
%include "inc/engine.inc"
%include "inc/symbols.inc"

%ifidn __OUTPUT_FORMAT__, bin
    org     g1g2(0x57D639,0x597D9E,0x596EA6,0x59C406)
%endif

bits    32


section .text   align=1                                                    ; Prevent auto-alignment

    resetStackoffset g1g2(0xF54,0xF58,0x1310,0x1310)
        push    eax                                                        ; Existing zCModelAni *
        mov     ecx, [esp+stackoffset+g1g2(-0xF24,-0xF28,-0x12C8,-0x12C8)] ; zCModelPrototype *
        push    ecx
        mov     edx, [esp+stackoffset+g1g2(-0xF44,-0xF48,-0x12FC,-0x12FC)]
        add     edx, 0x24                                                  ; New zCModelAni->name
        call    zCModelPrototype__SearchAniIndex                           ; __fastcall
        pop     ecx
        mov     ecx, [ecx+0x48]
        mov     edx, [esp+stackoffset+g1g2(-0xF44,-0xF48,-0x12FC,-0x12FC)] ; New zCModelAni *
        mov     [ecx+eax*0x4], edx                                         ; New ani
        pop     ecx                                                        ; Old ani
        mov     eax, [ecx+0x4]
        dec     eax                                                        ; Decrease refCtr
        mov     [ecx+0x4], eax
        cmp     eax, 0
    verifyStackoffset g1g2(0xF54,0xF58,0x1310,0x1310)
        jg      g1g2(0x57D8F8,0x5980B5,0x597163,0x59C6C3)                  ; Continue
        push    0x1                                                        ; If refCtr <= 0 then
        call    zCModelAni__deleting_destructor
    addStack 4
    verifyStackoffset g1g2(0xF54,0xF58,0x1310,0x1310)
        jmp     g1g2(0x57D8F8,0x5980B5,0x597163,0x59C6C3)
    ; Room to 0x57D69A (g1), 0x59C459 (g2)
