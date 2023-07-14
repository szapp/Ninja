%ifndef SYMBOLS_INC
    %define SYMBOLS_INC

    ; Version dependent macros
    %if GOTHIC_BASE_VERSION == 1

        %include "inc/symbols_g1.inc"

    %elif GOTHIC_BASE_VERSION == 112

        %include "inc/symbols_g112.inc"

    %elif GOTHIC_BASE_VERSION == 2

        %include "inc/symbols_g2.inc"

    %endif
%endif
