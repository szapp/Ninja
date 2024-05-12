; Overwrite 'aniDisable' in zCModelPrototype::ReadAniEnum

%include "inc/macros.inc"
%include "inc/engine.inc"
%include "inc/symbols.inc"

%ifidn __OUTPUT_FORMAT__, bin
    org     g1g2(0x57B372,0x595824,0x594223,0x599783)
%endif

bits    32


section .text   align=1                                                    ; Prevent auto-alignment

    resetStackoffset g1g2(0xF54,0xF58,0x12C0,0x12C0)
        push    eax                                                        ; Existing zCModelAni *
        mov     ecx, [esp+stackoffset+g1g2(-0xF24,-0xF28,-0x1278,-0x1278)] ; zCModelPrototype *
        push    ecx
    %if GOTHIC_BASE_VERSION == 112
        mov     edx, [esp+stackoffset-0xF48]
        add     edx, 0x24                                                  ; New zCModelAni->name
    %elif GOTHIC_BASE_VERSION == 1 || GOTHIC_BASE_VERSION == 130 || GOTHIC_BASE_VERSION == 2
        mov     edx, g1g2(edi,,ebp,ebp)                                    ; New zCModelAni->name
    %endif
        call    zCModelPrototype__SearchAniIndex                           ; __fastcall
        pop     ecx
        mov     ecx, [ecx+0x48]
    %if GOTHIC_BASE_VERSION == 1 || GOTHIC_BASE_VERSION == 112
        mov     edx, [esp+stackoffset+g1g2(-0xF38,-0xF48,,)]               ; New zCModelAni *
    %endif
        mov     [ecx+eax*0x4], g1g2(edx,edx,edi,edi)                       ; New ani
        pop     ecx                                                        ; Old ani
        mov     eax, [ecx+0x4]
        dec     eax                                                        ; Decrease refCtr
        mov     [ecx+0x4], eax
        cmp     eax, 0
    verifyStackoffset g1g2(0xF54,0xF58,0x12C0,0x12C0)
        jg      g1g2(0x57B3DD,0x59589C,0x592B6E,0x5980CE)                  ; Continue
        push    0x1                                                        ; If refCtr <= 0 then
        call    zCModelAni__deleting_destructor
    addStack 4
    verifyStackoffset g1g2(0xF54,0xF58,0x12C0,0x12C0)
        jmp     g1g2(0x57B3DD,0x59589C,0x592B6E,0x5980CE)                  ; Continue
    ; Room to 0x57B3CB (g1), 0x5997CE (g2)
