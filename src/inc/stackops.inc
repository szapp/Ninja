%ifndef STACKOPS_INC
    %define STACKOPS_INC

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

%endif
