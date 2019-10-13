; DLL wrapper for Ninja

%include "inc/stackops.inc"

%assign inject_g1_count 0
%macro add_inject_g1 2
        injectObj_g1_%[inject_g1_count]_addr   equ    %1
        injectObj_g1_%[inject_g1_count]_new:   incbin %2
        injectObj_g1_%[inject_g1_count]_size   equ    $-injectObj_g1_%[inject_g1_count]_new
    %assign inject_g1_count inject_g1_count + 1
%endmacro

%assign inject_g2_count 0
%macro add_inject_g2 2
        injectObj_g2_%[inject_g2_count]_addr   equ    %1
        injectObj_g2_%[inject_g2_count]_new    incbin %2
        injectObj_g2_%[inject_g2_count]_size   equ    $-injectObj_g2_%[inject_g2_count]_new
    %assign inject_g2_count inject_g2_count + 1
%endmacro

bits 32

DLL_PROCESS_DETACH                     equ  0x0
DLL_PROCESS_ATTACH                     equ  0x1
PAGE_READWRITE                         equ  0x4
MB_OK                                  equ  0x0
MB_ICONERROR                           equ  0x10
MB_TASKMODAL                           equ  0x2000
MB_SETFOREGROUND                       equ  0x10000
CREATE_ALWAYS                          equ  0x2
GENERIC_READ                           equ  0x80000000
GENERIC_WRITE                          equ  0x40000000
FILE_SHARE_READ                        equ  0x1
FILE_SHARE_WRITE                       equ  0x2
FILE_SHARE_DELETE                      equ  0x4
FILE_ATTRIBUTE_HIDDEN                  equ  0x2
INVALID_HANDLE_VALUE                   equ  0xFFFFFFFF

extern MessageBoxA
extern VirtualProtect
extern memcpy
extern lstrlenA
extern GetModuleFileNameA
extern SetFileAttributesA
extern CreateFileA
extern WriteFile
extern CloseHandle
extern DeleteFileA

export DllMain
export Ninja

section .data

        %define scriptsFileName             '_delete_me.vdf'

        msgCaption                     db   'Ninja', 0
        msgGeneralFail                 db   'Ninja failed to initialize!', 0
        msgInvalidGothicVersion        db   'Invalid Gothic version.', 0
        msgScriptsCreatingFailed       db   'IO operations failed. Try starting the application with administrative '
                                       db   'privileges and/or delete the hidden file \Data\', scriptsFileName, 0

        verify_addr_g1                 equ  0x82C0C0
        verify_addr_g2                 equ  0x89A7FC

        %include "inc/injections.inc"

        scriptsPathRel                 db   '..\'
        scriptsPathBase                db   'DATA\', scriptsFileName, 0
        scriptsData:                   incbin "inc/iklg.data"
        scriptsData_len                equ  $-scriptsData


section .text

Ninja:
        ret

; int __stdcall inject(void *, DWORD, void *)
inject:
        resetStackoffset
        %assign var_total   0x4
        %assign var_before -0x4                                            ; DWORD
        %assign arg_1      +0x4                                            ; void *
        %assign arg_2      +0x8                                            ; DWORD
        %assign arg_3      +0xC                                            ; void *
        %assign arg_total   0xC

        sub     esp, var_total
        push    ecx

        mov     DWORD [esp+stackoffset+var_before], 0x0
        lea     ecx, [esp+stackoffset+var_before]
        push    ecx
        push    PAGE_READWRITE
        push    DWORD [esp+stackoffset+arg_2]
        push    DWORD [esp+stackoffset+arg_1]
        call    VirtualProtect
    addStack 4*4
        test    eax, eax
        jz      .failed

        push    DWORD [esp+stackoffset+arg_2]
        push    DWORD [esp+stackoffset+arg_3]
        push    DWORD [esp+stackoffset+arg_1]
        call    memcpy
        add     esp, 0xC
        test    eax, eax
        jz      .failed

        lea     ecx, [esp+stackoffset+var_before]
        push    ecx
        push    DWORD [esp+stackoffset+var_before]
        push    DWORD [esp+stackoffset+arg_2]
        push    DWORD [esp+stackoffset+arg_1]
        call    VirtualProtect
    addStack 4*4
        mov     eax, 0x1
        jmp     .funcEnd

.failed:
        xor     eax, eax

.funcEnd:
        pop     ecx
        add     esp, var_total
        ret     arg_total
    verifyStackoffset


; int __cdecl injectAll(void)
injectAll:
        cmp     DWORD [verify_addr_g2], 'Goth'
        jz      .g2
        cmp     DWORD [verify_addr_g1], 'Goth'
        jz      .g1

        push    MB_OK | MB_ICONERROR | MB_TASKMODAL | MB_SETFOREGROUND
        push    msgCaption
        push    msgInvalidGothicVersion
        push    0x0
        call    MessageBoxA
    addStack 4*4

.failed:
        xor     eax, eax
        ret

.g1:
    %assign it 0
    %rep inject_g1_count
        push    injectObj_g1_%[it]_new
        push    injectObj_g1_%[it]_size
        push    injectObj_g1_%[it]_addr
        call    inject
    addStack 4*4
        test    eax, eax
        jz      .failed
        %assign it it + 1
    %endrep

.success:
        mov     eax, DWORD 0x1
        ret

.g2:
    %assign it 0
    %rep inject_g2_count
        push    injectObj_g2_%[it]_new
        push    injectObj_g2_%[it]_size
        push    injectObj_g2_%[it]_addr
        call    inject
        test    eax, eax
        jz      .failed
        %assign it it + 1
    %endrep

        jmp     .success


; int __cdecl verifyModuleName(void)
verifyModuleName:
        resetStackoffset
        %assign var_total   0x104
        %assign var_name   -0x104                                          ; char[0x104]

        sub     esp, var_total
        push    ecx
        push    edx

        lea     eax, [esp+stackoffset+var_name]
        push    0x104
        push    eax
        push    0x0
        call    GetModuleFileNameA
    addStack 3*4

        lea     eax, [esp+stackoffset+var_name]
        push    eax
        call    lstrlenA
    addStack 4
        lea     edx, [esp+stackoffset+var_name]
        add     eax, edx

.findBaseName:
        cmp     eax, edx
        jb      .baseName
        mov     cl, [eax]
        cmp     cl, '\'
        jz      .baseName
        cmp     cl, '/'
        jz      .baseName
        dec     eax
        jmp     .findBaseName

.baseName:
        mov     ecx, eax
        xor     eax, eax
        inc     ecx
        cmp     DWORD [ecx], 'Goth'
        jnz     .funcEnd
        inc     eax

.funcEnd:
        pop     edx
        pop     ecx
        add     esp, var_total
        verifyStackoffset
        ret


; int __cdecl createScripts(void)
createScripts:
        resetStackoffset
        %assign var_total   0x4
        %assign var_ret    -0x4                                            ; DWORD

        sub     esp, var_total
        push    ecx

        push    FILE_ATTRIBUTE_HIDDEN                                      ; If already exists, needs same attributes
        push    scriptsPathRel
        call    SetFileAttributesA
    addStack 2*4
        push    FILE_ATTRIBUTE_HIDDEN
        push    scriptsPathBase
        call    SetFileAttributesA
    addStack 2*4
        push    0x0
        push    FILE_ATTRIBUTE_HIDDEN
        push    CREATE_ALWAYS
        push    0x0
        push    FILE_SHARE_READ | FILE_SHARE_WRITE | FILE_SHARE_DELETE
        push    GENERIC_READ | GENERIC_WRITE
        push    scriptsPathBase
        call    CreateFileA
    addStack 7*4
        cmp     eax, INVALID_HANDLE_VALUE
        jnz     .created

        push    0x0
        push    FILE_ATTRIBUTE_HIDDEN
        push    CREATE_ALWAYS
        push    0x0
        push    FILE_SHARE_READ | FILE_SHARE_WRITE | FILE_SHARE_DELETE
        push    GENERIC_READ | GENERIC_WRITE
        push    scriptsPathRel
        call    CreateFileA
    addStack 7*4
        cmp     eax, INVALID_HANDLE_VALUE
        jz      .failed

.created:
        push    eax                                                        ; Argument for CloseHandle

        xor     ecx, ecx                                                   ; Create DWORD *
        push    ecx
        mov     ecx, esp

        push    0x0
        push    ecx
        push    scriptsData_len
        push    scriptsData
        push    eax
        call    WriteFile
    addStack 5*4
        add     esp, 0x4
        mov     [esp+stackoffset+var_ret], eax                             ; Remember return value
        call    CloseHandle
    addStack 4
        mov     eax, [esp+stackoffset+var_ret]
        test    eax, eax
        jnz     .funcEnd

.failed:
        push    MB_OK | MB_ICONERROR | MB_TASKMODAL | MB_SETFOREGROUND
        push    msgCaption
        push    msgScriptsCreatingFailed
        push    0x0
        call    MessageBoxA
    addStack 4*4
        xor     eax, eax

.funcEnd:
        pop     ecx
        add     esp, var_total
        ret
    verifyStackoffset


; bool __stdcall DLLMain(DWORD hinstDLL, DWORD fdwReason, void *lpvReserved)
DllMain:
        resetStackoffset
        mov     eax, [esp+stackoffset+0x8]                                 ; fdwReason
        cmp     eax, DLL_PROCESS_DETACH
        jnz     .attach
        push    scriptsPathRel
        call    DeleteFileA
    addStack 4
        push    scriptsPathBase
        call    DeleteFileA
    addStack 4
        jmp    .succeeded

.attach:
        cmp     eax, DLL_PROCESS_ATTACH
        jnz     .succeeded

        call    verifyModuleName
        test    eax, eax
        jz      .succeeded                                                 ; Ignore on invalid module file name

        call    injectAll
        test    eax, eax
        jz      .failed

        call    createScripts
        test    eax, eax
        jz      .failedNoMsg

.succeeded:
        mov     eax, DWORD 0x1
        ret     0xC

.failed:
        push    MB_OK | MB_ICONERROR | MB_TASKMODAL | MB_SETFOREGROUND
        push    msgCaption
        push    msgGeneralFail
        push    0x0
        call    MessageBoxA
    addStack 4*4

.failedNoMsg:
        xor     eax, eax
        ret     0xC
    verifyStackoffset
