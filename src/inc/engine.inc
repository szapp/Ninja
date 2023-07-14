%ifndef ENGINE_INC
    %define ENGINE_INC

    ; Version dependent macros (i.e. addresses, offsets and constants)
    %if GOTHIC_BASE_VERSION == 1

        %include "inc/engine_g1.inc"

    %elif GOTHIC_BASE_VERSION == 112

        %include "inc/engine_g112.inc"

    %elif GOTHIC_BASE_VERSION == 2

        %include "inc/engine_g2.inc"

    %endif
%endif
