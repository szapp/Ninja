%ifndef MACROS_INC
    %define MACROS_INC

    ; Sanity check
    %ifndef GOTHIC_BASE_VERSION
        %fatal "Macro GOTHIC_BASE_VERSION must be defined (1 or 2)."
    %elif GOTHIC_BASE_VERSION != 1 && GOTHIC_BASE_VERSION != 2
        %fatal "GOTHIC_BASE_VERSION must either be 1 or 2."
    %endif

    ; General macros
    %define NINJA_VERSION   'v1.2'
    %define AUTHOR_PREFIX   'J'
    %define NINJA_WEBSITE   'http://tiny.cc/GothicNinja'
    %define NINJA_TEMPLATE  'http://tiny.cc/GothicNinjaTemplate'
    %if GOTHIC_BASE_VERSION == 1
        %define g1g2(g1,g2) g1
    %elif GOTHIC_BASE_VERSION == 2
        %define g1g2(g1,g2) g2
    %endif

    ; Keep track of stack offset manipulations
    %macro push 1
        %assign stackoffset stackoffset + 4
        reportStackoffset
        push %1
    %endmacro

    %macro pop 1
        %assign stackoffset stackoffset - 4
        reportStackoffset
        pop %1
    %endmacro

    %macro pusha 0
        %assign stackoffset stackoffset + 32
        reportStackoffset
        pusha
    %endmacro

    %macro popa 0
        %assign stackoffset stackoffset - 32
        reportStackoffset
        popa
    %endmacro

    %macro inc 1
        inc %1
        %if %1 == esp
            %assign stackoffset stackoffset - 1
            reportStackoffset
        %endif
    %endmacro

    %macro dec 1
        dec %1
        %if %1 == esp
            %assign stackoffset stackoffset + 1
            reportStackoffset
        %endif
    %endmacro

    %macro add 2
        add %1, %2
        %if %1 == esp
            %assign stackoffset stackoffset - %2
            reportStackoffset
        %endif
    %endmacro

    %macro sub 2
        sub %1, %2
        %if %1 == esp
            %assign stackoffset stackoffset + %2
            reportStackoffset
        %endif
    %endmacro

    %macro addStack 1
        %assign stackoffset stackoffset - %1
        reportStackoffset
    %endmacro

    %macro resetStackoffset 0-1 0
        %assign stackoffset %1
        reportStackoffset
    %endmacro

    %macro verifyStackoffset 0-1 0
        %assign tmpvar +%1
        %if stackoffset != %1
            %error Stack offset is not tmpvar (%[stackoffset]).
        %endif
    %endmacro

    %macro reportStackoffset 0
        %ifdef DEBUG
            %warning Stackoffset now: stackoffset
        %endif
    %endmacro

    %assign stackoffset 0

    %macro reportToSpy 1
        jmp     %%print
        %%msg:  db  AUTHOR_PREFIX, ':', %1, 0
    %%print:
        push    ecx
        push    eax
        push    edx
        sub     esp, 0x14
        mov     ecx, esp
        push    %%msg
        call    zSTRING__zSTRING
    addStack 4
        push    ecx
        call    zERROR__Message
    addStack 4
        mov     ecx, esp
        call    zSTRING___zSTRING
        add     esp, 0x14
        pop     edx
        pop     eax
        pop     ecx
    %endmacro

%endif
