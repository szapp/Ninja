; DLL wrapper for Ninja

%include "inc/stackops.inc"

BITS 32

%assign inject_g1_count 0
%macro add_inject_g1 2
        injectObj_g1_%[inject_g1_count]_addr   equ   %1
        injectObj_g1_%[inject_g1_count]_new    db    %2
        injectObj_g1_%[inject_g1_count]_size   equ   $-injectObj_g1_%[inject_g1_count]_new
    %assign inject_g1_count inject_g1_count + 1
%endmacro

%assign inject_g2_count 0
%macro add_inject_g2 2
        injectObj_g2_%[inject_g2_count]_addr   equ   %1
        injectObj_g2_%[inject_g2_count]_new    db    %2
        injectObj_g2_%[inject_g2_count]_size   equ   $-injectObj_g2_%[inject_g2_count]_new
    %assign inject_g2_count inject_g2_count + 1
%endmacro

DLL_PROCESS_ATTACH      equ  0x1
PAGE_READWRITE          equ  0x4
MB_OK                   equ  0x0
MB_ICONERROR            equ  0x10
MB_TASKMODAL            equ  0x2000
MB_SETFOREGROUND        equ  0x10000

extern MessageBoxA
extern VirtualProtect
extern memcpy
extern GetSystemDirectoryA
extern LoadLibraryA
extern GetProcAddress

export DllMain
export DCIOpenProvider
export DCIBeginAccess
export DCIEndAccess
export DCICloseProvider
export DCIDestroy
export DCICreatePrimary

section .bss
        gBase                   resb 1
        DLLhndl                 resd 1
        DCIOpenProvider         resd 1
        DCIBeginAccess          resd 1
        DCIEndAccess            resd 1
        DCICloseProvider        resd 1
        DCIDestroy              resd 1
        DCICreatePrimary        resd 1

section .data

        msgCaption              db   'Ninja', 0
        msgGeneralFail          db   'Ninja failed to initialize!', 0
        msgInvalidGothicVersion db   'Invalid Gothic version.', 0
        msgFailedToFindSysDir   db   'Failed to find system directory.', 0
        msgFailedToLoadDLL      db   'Failed to load DCIMAN32.DLL.', 0

        char_DCIOpenProvider    db   'DCIOpenProvider', 0
        char_DCIBeginAccess     db   'DCIBeginAccess', 0
        char_DCIEndAccess       db   'DCIEndAccess', 0
        char_DCICloseProvider   db   'DCICloseProvider', 0
        char_DCIDestroy         db   'DCIDestroy', 0
        char_DCICreatePrimary   db   'DCICreatePrimary', 0

        verify_addr_g1          equ  0x82C0C0
        verify_addr_g2          equ  0x89A7FC

        version_sp_g1           equ  0x7CF576
        version_sp_g2           equ  0x82D48F

        %include "inc/injections.inc"


section .text

; void __stdcall inject(void *, DWORD, DWORD *)
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
        push    MB_OK | MB_ICONERROR | MB_TASKMODAL | MB_SETFOREGROUND
        push    msgCaption
        push    msgGeneralFail
        push    0x0
        call    MessageBoxA
    addStack 4*4
        xor     eax, eax

.funcEnd:
        pop     ecx
        add     esp, var_total
        ret     arg_total
    verifyStackoffset


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

    ; Partial version string for main menu
    %defstr NINJA_VERSION v%!VERSION
    %substr .nversion1 NINJA_VERSION 2,1
    %substr .nversion2 NINJA_VERSION 4,1
    %strcat .nversion .nversion1 '.' .nversion2 ' '

.g1:
        mov     BYTE [gBase], 0x1
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

        ; Set version info if SP is installed
        lea     eax, [version_sp_g1+0xA]
        cmp     WORD [eax], 'SP'
        jnz     .success
        sub     esp, 0x10
        mov     DWORD [esp], '1.08'
        mov     DWORD [esp+0x4], 'k-S '
        mov     eax, [version_sp_g1+0xD]
        mov     DWORD [esp+0x7], eax
        mov     WORD [esp+0xA], '-N'
        mov     DWORD [esp+0xC], .nversion
        mov     BYTE [esp+0xF], 0
        push    esp
        push    0x10
        push    version_sp_g1
        call    inject
    addStack 4*4
       add     esp, 0x10
       test    eax, eax
       jz      .failed

.success:
        mov     eax, DWORD 0x1
        ret

.g2:
        mov     BYTE [gBase], 0x2
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

        ; Set version info if SP is installed
        lea     eax, [version_sp_g2+0x8]
        cmp     WORD [eax], 'SP'
        jnz     .success
        sub     esp, 0x10
        mov     DWORD [esp], '2.6f'
        mov     DWORD [esp+0x4], 'x-S '
        mov     eax, [version_sp_g2+0xB]
        mov     DWORD [esp+0x7], eax
        mov     WORD [esp+0xA], '-N'
        mov     DWORD [esp+0xC], .nversion
        mov     BYTE [esp+0xF], 0
        push    esp
        push    0x10
        push    version_sp_g2
        call    inject
    addStack 4*4
        add     esp, 0x10
        test    eax, eax
        jz      .failed
        mov     eax, DWORD 0x1
        ret


redirectDLL:
        resetStackoffset
        %assign var_total   0x100
        %assign var_path   -0x100                                          ; char[0x100]

        sub     esp, var_total

        lea     eax, [esp+stackoffset+var_path]
        push    0x100
        push    eax
        call    GetSystemDirectoryA
    addStack 2*4
        test    eax, eax
        jnz     .loadDLL
        mov     eax, msgFailedToFindSysDir
        jmp     .failed

.loadDLL:
        lea     ecx, [esp+stackoffset+var_path]
        mov     BYTE [eax+ecx+0x1], '\'
        mov     DWORD [eax+ecx+0x2], 'DCIM'
        mov     DWORD [eax+ecx+0x6], 'AN32'
        mov     DWORD [eax+ecx+0xA], '.DLL'
        mov     BYTE [eax+ecx+0xE], 0
        push    eax
        call    LoadLibraryA
    addStack 4
        test    eax, eax
        jnz     .getProcAddr
        mov     eax, msgFailedToLoadDLL
        jmp     .failed

.getProcAddr:
        mov     DWORD [DLLhndl], eax

    %macro loadProcAddr 2
        push    %1
        push    DWORD [DLLhndl]
        call    GetProcAddress
        mov     DWORD [%2], eax
    addStack 2*4
    %endmacro

        loadProcAddr char_DCIOpenProvider,DCIOpenProvider
        loadProcAddr char_DCIBeginAccess,DCIBeginAccess
        loadProcAddr char_DCIEndAccess,DCIEndAccess
        loadProcAddr char_DCICloseProvider,DCICloseProvider
        loadProcAddr char_DCIDestroy,DCIDestroy
        loadProcAddr char_DCICreatePrimary,DCICreatePrimary

        jmp     .funcEnd

.failed:
        push    MB_OK | MB_ICONERROR | MB_TASKMODAL | MB_SETFOREGROUND
        push    msgCaption
        push    eax
        push    0x0
        call    MessageBoxA
    addStack 4*4
        xor     eax, eax
        jmp     .funcEnd

.funcEnd:
        add     esp, var_total
        verifyStackoffset
        ret


DllMain:
        mov     eax, [esp+0x8]
        cmp     eax, DLL_PROCESS_ATTACH
        jnz     .endFunc
        call    redirectDLL
        test    eax, eax
        jnz     .endFunc
        call    injectAll
        ret     0xC

.endFunc:
        mov     eax, DWORD 0x1
        ret     0xC
