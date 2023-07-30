; Overwrite 'aniComb' in zCModelPrototype::ReadAniEnum

%include "inc/macros.inc"
%include "inc/engine.inc"
%include "inc/symbols.inc"

%ifidn __OUTPUT_FORMAT__, bin
    org     g1g2(0x57B169,0x5955E3,0x593EF6,0x599456)
%endif

bits    32


section .text   align=1                                                    ; Prevent auto-alignment

    resetStackoffset g1g2(0xF54,0xF58,0x12EC,0x12EC)
        push    eax                                                        ; Existing zCModelAni *
        mov     ecx, [esp+stackoffset+g1g2(-0xF24,-0xF28,-0x12A4,-0x12A4)] ; zCModelPrototype *
        push    ecx
    %if GOTHIC_BASE_VERSION == 112
        mov     edx, [esp+stackoffset-0xF48]
        add     edx, 0x24                                                  ; New zCModelAni->name
    %elif GOTHIC_BASE_VERSION == 1 || GOTHIC_BASE_VERSION == 130 || GOTHIC_BASE_VERSION == 2
        mov     edx, g1g2(edi,,ebx,ebx)                                    ; New zCModelAni->name
    %endif
        call    zCModelPrototype__SearchAniIndex                           ; __fastcall
        pop     ecx
        mov     ecx, [ecx+0x48]
    %if GOTHIC_BASE_VERSION == 1 || GOTHIC_BASE_VERSION == 112
        mov     edx, [esp+stackoffset+g1g2(-0xF38,-0xF48,,)]               ; New zCModelAni *
    %endif
        mov     [ecx+eax*0x4], g1g2(edx,edx,ebp,ebp)                       ; New ani
        pop     ecx                                                        ; Old ani
        mov     eax, [ecx+0x4]
        dec     eax                                                        ; Decrease refCtr
        mov     [ecx+0x4], eax
        cmp     eax, 0
    verifyStackoffset g1g2(0xF54,0xF58,0x12EC,0x12EC)
        jg      g1g2(0x57A1EA,0x594467,0x593F5B,0x5994BB)                  ; Continue
        push    0x1                                                        ; If refCtr <= 0 then
        call    zCModelAni__deleting_destructor
    addStack 4
    verifyStackoffset g1g2(0xF54,0xF58,0x12EC,0x12EC)
        jmp     g1g2(0x57A1EA,0x594467,0x593F5B,0x5994BB)                  ; Continue
    ; Room to 0x57B1CA (g1), 0x5994A9 (g2)
