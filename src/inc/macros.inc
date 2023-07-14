%ifndef MACROS_INC
    %define MACROS_INC

    ; Sanity check
    %ifndef GOTHIC_BASE_VERSION
        %fatal "Macro GOTHIC_BASE_VERSION must be defined (1, 112, or 2)."
    %elif GOTHIC_BASE_VERSION != 1 && GOTHIC_BASE_VERSION != 112 && GOTHIC_BASE_VERSION != 2
        %fatal "GOTHIC_BASE_VERSION must either be 1, 112, or 2."
    %endif

    ; General macros
    %defstr NINJA_VERSION   v%!VERSION
    %define AUTHOR_PREFIX   'J'
    %defstr NINJA_WEBSITE   %!NINJA_WEBSITE
    %define IKARUS_VERSION  %!IKARUS_VERSION
    %define LEGO_N_VERSION  %!LEGO_N_VERSION
    %define MAX_VDF_TIME    0x7F9FBF7D                                     ; 2043-12-23 23:59:58
    %if GOTHIC_BASE_VERSION == 1
        %define g1g2(g1,g112,g2) g1
    %elif GOTHIC_BASE_VERSION == 112
        %define g1g2(g1,g112,g2) g112
    %elif GOTHIC_BASE_VERSION == 2
        %define g1g2(g1,g112,g2) g2
    %endif

    %include "inc/stackops.inc"

    %macro reportToSpy 1
        pusha
        sub     esp, 0x14
        mov     ecx, esp
        push    %1
        call    zSTRING__zSTRING
    addStack 4
        push    ecx
        call    zERROR__Message
    addStack 4
        mov     ecx, esp
        call    zSTRING___zSTRING
        add     esp, 0x14
        popa
    %endmacro

    %macro reportToSpyReg 1-2
        pusha
        mov     edi, %1
        sub     esp, 0x14
        mov     ecx, esp
        push    NINJA_AUTHOR_PREFIX
        call    zSTRING__zSTRING
    addStack 4
%if %2 > 0
        sub     esp, 0x80
        mov     eax, esp
        push    ecx

        push    %2
        push    eax
        push    edi
        call    _itoa
        add     esp, 0xC

        pop     ecx
        push    eax
%else
        push    edi
%endif
        call    zSTRING__operator_plusEq
    addStack 4
%if %2 > 0
        add     esp, 0x80
%endif
        push    ecx
        call    zERROR__Message
    addStack 4
        mov     ecx, esp
        call    zSTRING___zSTRING
        add     esp, 0x14
        popa
    %endmacro

%endif
