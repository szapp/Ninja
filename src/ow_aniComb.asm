; Overwrite 'aniComb' in zCModelPrototype::ReadAniEnum

%include "inc/macros.mac"
%include "inc/engine.mac"

%if GOTHIC_BASE_VERSION == 1
    %include "inc/symboladdresses_g1.mac"
%elif GOTHIC_BASE_VERSION == 2
    %include "inc/symboladdresses_g2.mac"
%endif

%ifidn __OUTPUT_FORMAT__, bin
    org     g1g2(0x57B169,0x599456)
%endif

bits    32


section .text   align=1                                                    ; Prevent auto-alignment

    resetStackoffset g1g2(0xF54,0x12EC)
        push    eax                                                        ; Existing zCModelAni *
    %if GOTHIC_BASE_VERSION == 1
        mov     ecx, [esp+stackoffset-0xF24]                               ; zCModelPrototype *
    %elif GOTHIC_BASE_VERSION == 2
        mov     ecx, edi
    %endif
        push    ecx
        mov     edx, g1g2(edi,ebx)                                         ; New zCModelAni->name
        call    zCModelPrototype__SearchAniIndex                           ; __fastcall
        pop     ecx
        mov     ecx, [ecx+0x48]
    %if GOTHIC_BASE_VERSION == 1
        mov     edx, [esp+stackoffset-0xF38]                               ; New zCModelAni *
    %endif
        mov     [ecx+eax*4], g1g2(edx,ebp)                                 ; New ani
        pop     ecx                                                        ; Old ani
        mov     eax, [ecx+0x4]
        dec     eax                                                        ; Decrease refCtr
        mov     [ecx+0x4], eax
        cmp     eax, 0
    verifyStackoffset g1g2(0xF54,0x12EC)
        jg      g1g2(0x57A1EA,0x5994BB)                                    ; Continue
        push    0x1                                                        ; If refCtr <= 0 then
        call    zCModelAni__deleting_destructor
    addStack 4
    verifyStackoffset g1g2(0xF54,0x12EC)
        jmp     g1g2(0x57A1EA,0x5994BB)                                    ; Continue
    ; Room to 0x57B1CA (g1), 0x5994A9 (g2)
