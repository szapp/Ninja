; DLL loader for Ninja

%include "inc/stackops.inc"

bits 32

extern LoadLibraryA
extern GetProcAddress
extern SetUnhandledExceptionFilter
extern Ninja

export DllMain

section .data

        DLLhndl                        dd   0x0
        _GetFaultReason                dd   GetFaultReason.init
        _GetFirstStackTraceString      dd   GetFirstStackTraceString.init
        _GetNextStackTraceString       dd   GetNextStackTraceString.init
        _GetRegisterString             dd   GetRegisterString.init
        _SetCrashHandlerFilter         dd   SetCrashHandlerFilter.init

        %define DLLFileName                 'BUGSLAYERUTILG.DLL'

        msgFaultReasonDLLNotFound      db   'Fault reason could not be determined, because ', DLLFileName,' was not '
                                       db   'found.', 0
        msgStackTraceDLLNotFound       db   'Stack trace could not be determined, because ', DLLFileName,' was not '
                                       db   'found.', 0
        msgRegisterDLLNotFound         db   'Registers could not be determined, because ', DLLFileName,' was not '
                                       db   'found.', 0

        dllFileName                    db   DLLFileName, 0
        char_GetFaultReason            db   'GetFaultReason', 0
        char_GetFirstStackTraceString  db   'GetFirstStackTraceString', 0
        char_GetNextStackTraceString   db   'GetNextStackTraceString', 0
        char_GetRegisterString         db   'GetRegisterString', 0
        char_SetCrashHandlerFilter     db   'SetCrashHandlerFilter', 0


section .text

; int __cdecl redirectDLL(void)
redirectDLL:
        resetStackoffset

        push    dllFileName
        call    LoadLibraryA
    addStack 4
        test    eax, eax
        jnz     .getProcAddr
        ret

.getProcAddr:
        mov     DWORD [DLLhndl], eax

    %macro fillAPI 1
        push    char_%1
        push    DWORD [DLLhndl]
        call    GetProcAddress
        test    eax, eax
        jnz     %%succ
        ret
    %%succ:
        mov     DWORD [_%1], eax
    addStack 2*4
    %endmacro

        fillAPI GetFaultReason
        fillAPI GetFirstStackTraceString
        fillAPI GetNextStackTraceString
        fillAPI GetRegisterString
        fillAPI SetCrashHandlerFilter

    verifyStackoffset
        mov     eax, [DLLhndl]
        ret


; bool __stdcall DLLMain(DWORD hinstDLL, DWORD fdwReason, void *lpvReserved)
DllMain:
        resetStackoffset
        mov     eax, [esp+stackoffset+0x8]                                 ; fdwReason
        mov     eax, DWORD 0x1
        ret     0xC
    verifyStackoffset


; Load library on very first call, after that jump to function directly
%macro setupAPI 3
export %1
%1:
        jmp     DWORD [_%1]
.init:
        call    redirectDLL
        test    eax, eax
        jnz     %1

        mov     eax, %3
        ret     %2
%endmacro

setupAPI GetFaultReason,0x4,msgFaultReasonDLLNotFound
setupAPI GetFirstStackTraceString,0x8,msgStackTraceDLLNotFound             ; Must always return a valid string pointer
setupAPI GetNextStackTraceString,0x8,0                                     ; May always return zero (do-while condition)
setupAPI GetRegisterString,0x4,msgRegisterDLLNotFound


; int __stdcall SetCrashHandlerFilter(int (__stdcall *lpTopLevelExceptionFilter)())
export SetCrashHandlerFilter
SetCrashHandlerFilter:
        jmp     DWORD [_SetCrashHandlerFilter]
.init:
        call    redirectDLL
        test    eax, eax
        jnz     SetCrashHandlerFilter

        push    DWORD [esp+0x4]                                            ; If DLL not found, set manually
        call    SetUnhandledExceptionFilter
        xor     eax, eax
        ret     0x4
