; DLL wrapper for Ninja

%include "inc/stackops.inc"

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

bits 32

DLL_PROCESS_ATTACH                     equ  0x1
PAGE_READWRITE                         equ  0x4
MB_OK                                  equ  0x0
MB_ICONERROR                           equ  0x10
MB_TASKMODAL                           equ  0x2000
MB_SETFOREGROUND                       equ  0x10000

extern MessageBoxA
extern VirtualProtect
extern memcpy
extern GetSystemDirectoryA
extern LoadLibraryA
extern GetProcAddress

export DllMain

section .bss
        DLLhndl                        resd 1
        _DCIBeginAccess                resd 1
        _DCICloseProvider              resd 1
        _DCICreateOffscreen            resd 1
        _DCICreateOverlay              resd 1
        _DCICreatePrimary              resd 1
        _DCIDestroy                    resd 1
        _DCIDraw                       resd 1
        _DCIEndAccess                  resd 1
        _DCIEnum                       resd 1
        _DCIOpenProvider               resd 1
        _DCISetClipList                resd 1
        _DCISetDestination             resd 1
        _DCISetSrcDestClip             resd 1
        _GetDCRegionData               resd 1
        _GetWindowRegionData           resd 1
        _WinWatchClose                 resd 1
        _WinWatchDidStatusChange       resd 1
        _WinWatchGetClipList           resd 1
        _WinWatchNotify                resd 1
        _WinWatchOpen                  resd 1

section .data

        msgCaption                     db   'Ninja', 0
        msgGeneralFail                 db   'Ninja failed to initialize!', 0
        msgInvalidGothicVersion        db   'Invalid Gothic version.', 0
        msgFailedToFindSysDir          db   'Failed to find system directory.', 0
        msgFailedToLoadDLL             db   'Failed to load DCIMAN32.DLL.', 0

        char_DCIBeginAccess            db   'DCIBeginAccess', 0
        char_DCICloseProvider          db   'DCICloseProvider', 0
        char_DCICreateOffscreen        db   'DCICreateOffscreen', 0
        char_DCICreateOverlay          db   'DCICreateOverlay', 0
        char_DCICreatePrimary          db   'DCICreatePrimary', 0
        char_DCIDestroy                db   'DCIDestroy', 0
        char_DCIDraw                   db   'DCIDraw', 0
        char_DCIEndAccess              db   'DCIEndAccess', 0
        char_DCIEnum                   db   'DCIEnum', 0
        char_DCIOpenProvider           db   'DCIOpenProvider', 0
        char_DCISetClipList            db   'DCISetClipList', 0
        char_DCISetDestination         db   'DCISetDestination', 0
        char_DCISetSrcDestClip         db   'DCISetSrcDestClip', 0
        char_GetDCRegionData           db   'GetDCRegionData', 0
        char_GetWindowRegionData       db   'GetWindowRegionData', 0
        char_WinWatchClose             db   'WinWatchClose', 0
        char_WinWatchDidStatusChange   db   'WinWatchDidStatusChange', 0
        char_WinWatchGetClipList       db   'WinWatchGetClipList', 0
        char_WinWatchNotify            db   'WinWatchNotify', 0
        char_WinWatchOpen              db   'WinWatchOpen', 0

        verify_addr_g1                 equ  0x82C0C0
        verify_addr_g2                 equ  0x89A7FC

        version_sp_g1                  equ  0x7CF576
        version_sp_g2                  equ  0x82D48F

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
        xor     eax, eax

.funcEnd:
        pop     ecx
        add     esp, var_total
        ret     arg_total
    verifyStackoffset


; __cdecl injectAll(voir)
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

        xor     eax, eax
        push    eax
        push    esp
        push    PAGE_READWRITE
        push    0x10
        push    version_sp_g1
        call    VirtualProtect
    addStack 4*4
        test    eax, eax
        pop     eax
        jz      .failed

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

        xor     eax, eax
        push    eax
        push    esp
        push    PAGE_READWRITE
        push    0x10
        push    version_sp_g2
        call    VirtualProtect
    addStack 4*4
        test    eax, eax
        pop     eax
        jz      .failed
        jmp     .success


; __cdecl redirectDLL(void)
redirectDLL:
        resetStackoffset
        %assign var_total   0x100
        %assign var_path   -0x100                                          ; char[0x100]

        sub     esp, var_total
        push    ecx

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
        mov     BYTE [eax+ecx], '\'
        mov     DWORD [eax+ecx+0x1], 'DCIM'
        mov     DWORD [eax+ecx+0x5], 'AN32'
        mov     DWORD [eax+ecx+0x9], '.DLL'
        mov     BYTE [eax+ecx+0xD], 0
        push    ecx
        call    LoadLibraryA
    addStack 4
        test    eax, eax
        jnz     .getProcAddr
        mov     eax, msgFailedToLoadDLL
        jmp     .failed

.getProcAddr:
        mov     DWORD [DLLhndl], eax

    %macro fillAPI 1
        push    char_%1
        push    DWORD [DLLhndl]
        call    GetProcAddress
        mov     DWORD [_%1], eax
    addStack 2*4
    %endmacro

        fillAPI DCIBeginAccess
        fillAPI DCICloseProvider
        fillAPI DCICreateOffscreen
        fillAPI DCICreateOverlay
        fillAPI DCICreatePrimary
        fillAPI DCIDestroy
        fillAPI DCIDraw
        fillAPI DCIEndAccess
        fillAPI DCIEnum
        fillAPI DCIOpenProvider
        fillAPI DCISetClipList
        fillAPI DCISetDestination
        fillAPI DCISetSrcDestClip
        fillAPI GetDCRegionData
        fillAPI GetWindowRegionData
        fillAPI WinWatchClose
        fillAPI WinWatchDidStatusChange
        fillAPI WinWatchGetClipList
        fillAPI WinWatchNotify
        fillAPI WinWatchOpen

        jmp     .funcEnd

.failed:
        push    MB_OK | MB_ICONERROR | MB_TASKMODAL | MB_SETFOREGROUND
        push    msgCaption
        push    eax
        push    0x0
        call    MessageBoxA
    addStack 4*4
        xor     eax, eax

.funcEnd:
        pop     ecx
        add     esp, var_total
        verifyStackoffset
        ret


; bool __stdcall DLLMain(DWORD hinstDLL, DWORD fdwReason, void *lpvReserved)
DllMain:
        resetStackoffset
        mov     eax, [esp+0x8]
        cmp     eax, DLL_PROCESS_ATTACH
        jnz     .succeeded

    %macro initAPI 1
        mov     DWORD [_%1], %1.init
    %endmacro

        initAPI DCIBeginAccess
        initAPI DCICloseProvider
        initAPI DCICreateOffscreen
        initAPI DCICreateOverlay
        initAPI DCICreatePrimary
        initAPI DCIDestroy
        initAPI DCIDraw
        initAPI DCIEndAccess
        initAPI DCIEnum
        initAPI DCIOpenProvider
        initAPI DCISetClipList
        initAPI DCISetDestination
        initAPI DCISetSrcDestClip
        initAPI GetDCRegionData
        initAPI GetWindowRegionData
        initAPI WinWatchClose
        initAPI WinWatchDidStatusChange
        initAPI WinWatchGetClipList
        initAPI WinWatchNotify
        initAPI WinWatchOpen

        call    injectAll
        test    eax, eax
        jnz     .succeeded

        push    MB_OK | MB_ICONERROR | MB_TASKMODAL | MB_SETFOREGROUND
        push    msgCaption
        push    msgGeneralFail
        push    0x0
        call    MessageBoxA
    addStack 4*4
        xor     eax, eax
        ret     0xC

.succeeded:
        mov     eax, DWORD 0x1
        ret     0xC
    verifyStackoffset


; Load library on very first call, after that jump to function directly
%macro setupAPI 1
export %1
%1:
        jmp     DWORD [_%1]
.init:
        call    redirectDLL
        jmp     %1
%endmacro

setupAPI DCIBeginAccess
setupAPI DCICloseProvider
setupAPI DCICreateOffscreen
setupAPI DCICreateOverlay
setupAPI DCICreatePrimary
setupAPI DCIDestroy
setupAPI DCIDraw
setupAPI DCIEndAccess
setupAPI DCIEnum
setupAPI DCIOpenProvider
setupAPI DCISetClipList
setupAPI DCISetDestination
setupAPI DCISetSrcDestClip
setupAPI GetDCRegionData
setupAPI GetWindowRegionData
setupAPI WinWatchClose
setupAPI WinWatchDidStatusChange
setupAPI WinWatchGetClipList
setupAPI WinWatchNotify
setupAPI WinWatchOpen
