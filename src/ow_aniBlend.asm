; Overwrite 'aniBlend' in zCModelPrototype::ReadAniEnum

%include "inc/macros.mac"
%include "inc/engine.mac"

%if GOTHIC_BASE_VERSION == 1
    %include "inc/symboladdresses_g1.mac"
%elif GOTHIC_BASE_VERSION == 2
    %include "inc/symboladdresses_g2.mac"
%endif

%ifidn __OUTPUT_FORMAT__, bin
    org     g1g2(0x57A17C,0x598065)
%endif

bits    32


section .text   align=1                                                    ; Prevent auto-alignment

    resetStackoffset g1g2(0xF54,0x12D4)
        push    eax                                                        ; Existing zCModelAni *
        mov     ecx, [esp+stackoffset+g1g2(-0xF24,(-0x129C+0x10))]         ; zCModelPrototype *
        push    ecx
        mov     edx, g1g2(edi,ebp)                                         ; New zCModelAni->name
        call    zCModelPrototype__SearchAniIndex                           ; __fastcall
        pop     ecx
        mov     ecx, [ecx+0x48]
    %if GOTHIC_BASE_VERSION == 1
        mov     edx, [esp+stackoffset-0xF38]                               ; New zCModelAni *
    %endif
        mov     [ecx+eax*4], g1g2(edx,edi)                                 ; New ani
        pop     ecx                                                        ; Old ani
        mov     eax, [ecx+0x4]
        dec     eax                                                        ; Decrease refCtr
        mov     [ecx+0x4], eax
        cmp     eax, 0
    verifyStackoffset g1g2(0xF54,0x12D4)
        jg      g1g2(0x57A1EA,0x5980CE)                                    ; Continue
        push    0x1                                                        ; If refCtr <= 0 then
        call    zCModelAni__deleting_destructor
    addStack 4
    verifyStackoffset g1g2(0xF54,0x12D4)
        jmp     g1g2(0x57A1EA,0x5980CE)                                    ; Continue
    ; Room to 0x57A1C7 (g1), 0x5980A9 (g2)
