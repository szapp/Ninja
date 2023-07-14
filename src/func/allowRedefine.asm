; void __stdcall ninja_allowRedefine(zCParser *, char *)
; Decide if redefinition of symbol is allowed in current context
global ninja_allowRedefine
ninja_allowRedefine:
        resetStackoffset
        %assign var_total   0x14
        %assign var_string -0x14                                           ; zString
        %assign arg_1      +0x4                                            ; zCParser *
        %assign arg_2      +0x8                                            ; char *
        %assign arg_total   0x8

        sub     esp, var_total
        pusha

        xor     ebx, ebx
        mov     ecx, [esp+stackoffset+arg_1]
        mov     esi, [ecx+zCParser_datsave_offset]
        add     esi, DWORD [zCParser__enableParsing]                       ; Check if wrapped by Ninja
        mov     eax, char_redefinedIdentifier
        cmp     ecx, 0x2A
        jnz     .createString
        mov     eax, NINJA_OVERWRITING

.createString:
        push    eax
        lea     ecx, [esp+stackoffset+var_string]
        call    zSTRING__zSTRING
    addStack 4
        push    DWORD [esp+stackoffset+arg_2]
        call    zSTRING__operator_plusEq
    addStack 4
        cmp     esi, 0x2A
        jz      .noteOnly
        push    ebx
        push    eax
        mov     ecx, [esp+stackoffset+arg_1]
        call    zCParser__Error
    addStack 2*4
        jmp     .funcEnd

.noteOnly:
        cmp     BYTE [zERROR_zerr+0x20], 0x6                               ; zerr.filter_level
        jl      .funcEnd

        push    char_line                                                  ; Add line in file for extra information
        call    zSTRING__operator_plusEq
    addStack 4
        sub     esp, 0xC
        mov     ecx, esp
        push    eax

        mov     eax, [esp+stackoffset+arg_1]
        mov     eax, [eax+g1g2(0x10A4,0,0x20A4)]                           ; parser->line
        push    0xA
        push    ecx
        push    eax
        call    _itoa
        add     esp, 0xC

        pop     ecx
        push    esp
        call    zSTRING__operator_plusEq
    addStack 4
        add     esp, 0xC
        push    char_spaceClosingParanthesis
        call    zSTRING__operator_plusEq
    addStack 4

        push    eax
        call    ninja_debugMessage
    addStack 4

.funcEnd:
        lea     ecx, [esp+stackoffset+var_string]
        call    zSTRING___zSTRING
        popa
        add     esp, var_total
        ret     arg_total
    verifyStackoffset
