; void __cdecl ninja_freeVdfArray()
; Free reserved resources
global ninja_freeVdfArray
ninja_freeVdfArray:
    resetStackoffset
        pusha

        reportToSpy " NINJA: Releasing array"

        mov     eax, [NINJA_PATCH_ARRAY+zCArray.array]
        test    eax, eax
        jz      .funcEnd

        xor     edi, edi

.arrayLoop:
        mov     eax, [NINJA_PATCH_ARRAY+zCArray.numInArray]
        cmp     edi, eax
        jge     .arrayLoopEnd

        mov     eax, [NINJA_PATCH_ARRAY+zCArray.array]
        mov     ecx, [eax+edi*0x4]
        push    ecx
        call    operator_delete
        add     esp, 0x4

        inc     edi
        jmp     .arrayLoop

.arrayLoopEnd:
        mov     ecx, NINJA_PATCH_ARRAY
        call    zCArray_int____zCArray_int_

.funcEnd:
        popa
        ret
    verifyStackoffset
