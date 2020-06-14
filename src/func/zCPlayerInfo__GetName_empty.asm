; zSTRING __thiscall zCPlayerInfo::GetName(void)
; Re-implement zCPlayerInfo::GetName to return empty string
global zCPlayerInfo__GetName_empty
zCPlayerInfo__GetName_empty:
        resetStackoffset
        %assign arg_1         +0x4                                         ; zSTRING *
        %assign arg_total      0x4

        mov     ecx, [esp+stackoffset+arg_1]
        call    zSTRING__zSTRING_void
        ret     arg_total
    verifyStackoffset
