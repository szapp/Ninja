# Misc: Overwritten code and hooks


#########################
##  Overwritten Bytes  ##
#########################


loc_parser_redefined_var:

0x6F2129         56                      push    esi
0x6F212A         90                      nop
0x6F212B         50                      push    eax

0x6F212C         C6 84 24 98 03 00 00 16 mov     BYTE PTR [esp+0x39C-4], 0x16
0x6F2134         E8 23 69 D1 FF          call    0x408A5C-0x6F2134-1         # ninja_parseMsgOverwrite(zSTRING const &)
0x6F2139         5E                      pop     esi


loc_parser_redefined_class:

0x6F2BAC         56                      push    esi
0x6F2BAD         90                      nop
0x6F2BAE         50                      push    eax
0x6F2BAF         C6 44 24 50 02          mov     BYTE PTR [esp+0x50], 2
0x6F2BB4         E8 A3 5E D1 FF          call    0x408A5C-0x6F2BB4-1         # ninja_parseMsgOverwrite(zSTRING const &)
0x6F2BB9         5E                      pop     esi


loc_parser_redefined_inst:

0x6F3322         56                      push    esi
0x6F3323         90                      nop
0x6F3324         50                      push    eax
0x6F3325         C6 84 24 CC 00 00 00 11 mov     BYTE PTR [esp+0xD0-0x4], 0x11
0x6F332D         E8 2A 57 D1 FF          call    0x408A5C-0x6F332D-1         # ninja_parseMsgOverwrite(zSTRING const &)
0x6F3332         5E                      pop     esi


loc_parser_redefined_proto:

0x6F3766         56                      push    esi
0x6F3767         90                      nop
0x6F3768         50                      push    eax
0x6F3769         C6 84 24 BC 00 00 00 09 mov     BYTE PTR [esp+0xC0-4], 9
0x6F3771         E8 E6 52 D1 FF          call    0x408A5C-0x6F3771-1         # ninja_parseMsgOverwrite(zSTRING const &)
0x6F3776         5E                      pop     esi


loc_parser_redefined_func:

0x6F49D4         56                      push    esi
0x6F49D5         90                      nop
0x6F49D6         50                      push    eax
0x6F49D7         C6 84 24 A8 00 00 00 02 mov     BYTE PTR [esp+0xAC-4], 2
0x6F49DF         E8 78 40 D1 FF          call    0x408A5C-0x6F49DF-1         # ninja_parseMsgOverwrite(zSTRING const &)
0x6F49E4         90                      nop
0x6F49E5         5E                      pop     esi


loc_skipWriteAniBinFile_ani:  # Does not exist in Gothi 1

# 0x000000         8B 44 24 20           mov     eax, [esp+0x12AC-0x129C+0x10]
# 0x000000         89 44 24 E4           mov     [esp+0x12AC-0x12C8], eax
# 0x000000         E9 91 02 00 00        jmp     0x59C247-0x59BFB1-1


ani_replace:

0x57D639   F54   50                      push    eax                         # Existing zCModelAni *
0x57D63A   F58   8B 4C 24 34             mov     ecx, [esp+0xF58-0xF24]      # zCModelPrototype *
0x57D63E   F58   51                      push    ecx
0x57D63F   F5C   8B 54 24 18             mov     edx, [esp+0xF5C-0xF44]      # New zCModelAni *
0x57D643   F5C   83 C2 24                add     edx, 0x24
0x57D646   F5C   E8 05 22 FF FF          call    0x56F850-0x57D646-1         # zCModelPrototype::SearchAniIndex(zSTRING const &)
0x57D64B   F5C   59                      pop     ecx
0x57D64C   F58   8B 49 48                mov     ecx, [ecx+0x48]
0x57D64F   F58   8B 54 24 14             mov     edx, [esp+0xF58-0xF44]
0x57D653   F58   89 14 81                mov     [ecx+eax*4], edx            # New ani
0x57D656   F58   59                      pop     ecx                         # Old ani
0x57D657   F54   8B 41 04                mov     eax, [ecx+4]
0x57D65A   F54   48                      dec     eax                         # Decrease refCtr
0x57D65B   F54   89 41 04                mov     [ecx+4], eax
0x57D65E   F54   83 F8 00                cmp     eax, 0
0x57D661   F54   0F 8F 91 02 00 00       jg      0x57D8F8-0x57D661-2         # Continue
0x57D667   F54   6A 01                   push    1                           # If refCtr <= 0 then
0x57D669   F58   E8 B2 D3 FE FF          call    0x56AA20-0x57D669-1         # zCModelAni::scalar_deleting_destructor
0x57D66E   F54   E9 85 02 00 00          jmp     0x57D8F8-0x57D66E-1         # Continue
# Room up to 0x57D69A


aniAlias_replace:

0x579D54   F54   50                      push    eax                         # Existing zCModelAni *
0x579D55   F58   8B 4C 24 34             mov     ecx, [esp+0xF58-0xF24]      # zCModelPrototype *
0x579D59   F58   51                      push    ecx
0x579D5A   F3C   89 FA                   mov     edx, edi                    # New zCModelAni->name
0x579D5C   F3C   E8 EF 5A FF FF          call    0x56F850-0x579D5C-1         # zCModelPrototype::SearchAniIndex(zSTRING const &)
0x579D61   F3C   59                      pop     ecx
0x579D62   F58   8B 49 48                mov     ecx, [ecx+0x48]
0x579D65   F58   8B 54 24 20             mov     edx, [esp+0xF58-0xF38]      # New zCModelAni *
0x579D69   F58   89 14 81                mov     [ecx+eax*4], edx            # New ani
0x579D6C   F58   59                      pop     ecx                         # Old ani
0x579D6D   F54   8B 41 04                mov     eax, [ecx+4]
0x579D70   F54   48                      dec     eax                         # Decrease refCtr
0x579D71   F54   89 41 04                mov     [ecx+4], eax
0x579D74   F54   83 F8 00                cmp     eax, 0
0x579D77   F54   0F 8F 45 00 00 00       jg      0x579DC2-0x579D77-2         # Continue
0x579D7D   F54   6A 01                   push    1                           # If refCtr <= 0 then
0x579D7F   F58   E8 9C 0C FF FF          call    0x56AA20-0x579D7F-1         # zCModelAni::scalar_deleting_destructor
0x579D84   F54   E9 39 00 00 00          jmp     0x579DC2-0x579D84-1         # Continue
# Room up to 0x579DB5


aniComb_replace:

0x57B169   F54   50                      push    eax                         # Existing zCModelAni *
0x57B16A   F38   8B 4C 24 34             mov     ecx, [esp+0xF58-0xF24]      # zCModelPrototype *
0x57B16E   F38   51                      push    ecx
0x57B16F   F3C   89 FA                   mov     edx, edi                    # New zCModelAni->name
0x57B171   F3C   E8 DA 46 FF FF          call    0x56F850-0x57B171-1         # zCModelPrototype::SearchAniIndex(zSTRING const &)
0x57B176   F3C   59                      pop     ecx
0x57B177   F38   8B 49 48                mov     ecx, [ecx+0x48]
0x57B17A   F58   8B 54 24 20             mov     edx, [esp+0xF58-0xF38]      # New zCModelAni *
0x57B17E   F38   89 14 81                mov     [ecx+eax*4], edx            # New ani
0x57B181   F38   59                      pop     ecx                         # Old ani
0x57B182   F54   8B 41 04                mov     eax, [ecx+4]
0x57B185   F54   48                      dec     eax                         # Decrease refCtr
0x57B186   F54   89 41 04                mov     [ecx+4], eax
0x57B189   F54   83 F8 00                cmp     eax, 0
0x57B18C   F54   0F 8F 58 F0 FF FF       jg      0x57A1EA-0x57B18C-2         # Continue
0x57B192   F54   6A 01                   push    1                           # If refCtr <= 0 then
0x57B194   F38   E8 87 F8 FE FF          call    0x56AA20-0x57B194-1         # zCModelAni::scalar_deleting_destructor
0x57B199   F54   E9 4C F0 FF FF          jmp     0x57A1EA-0x57B199-1         # Continue
# Room up to 0x57B1CA


aniBlend_replace:

0x57A17C   F54   50                      push    eax                         # Existing zCModelAni *
0x57A17D   F58   8B 4C 24 34             mov     ecx, [esp+0xF58-0xF24]      # zCModelPrototype *
0x57A181   F58   51                      push    ecx
0x57A182   F5C   89 FA                   mov     edx, edi                    # New zCModelAni->name
0x57A184   F5C   E8 C7 56 FF FF          call    0x56F850-0x57A184-1         # zCModelPrototype::SearchAniIndex(zSTRING const &)
0x57A189   F5C   59                      pop     ecx
0x57A18A   F58   8B 49 48                mov     ecx, [ecx+0x48]
0x57A18D   F58   8B 54 24 20             mov     edx, [esp+0xF58-0xF38]      # New zCModelAni *
0x57A191   F38   89 14 81                mov     [ecx+eax*4], edx            # New ani
0x57A194   F58   59                      pop     ecx                         # Old ani
0x57A195   F54   8B 41 04                mov     eax, [ecx+4]
0x57A198   F54   48                      dec     eax                         # Decrease refCtr
0x57A199   F54   89 41 04                mov     [ecx+4], eax
0x57A19C   F54   83 F8 00                cmp     eax, 0
0x57A19F   F54   0F 8F 45 00 00 00       jg      0x57A1EA-0x57A19F-2         # Continue
0x57A1A5   F54   6A 01                   push    1                           # If refCtr <= 0 then
0x57A1A7   F54   E8 74 08 FF FF          call    0x56AA20-0x57A1A7-1         # zCModelAni::scalar_deleting_destructor
0x57A1AC   F54   E9 39 00 00 00          jmp     0x57A1EA-0x57A1AC-1         # Continue
# Room up to 0x57A1C7


aniSync_replace:

0x57A4A5   F54   50                      push    eax                         # Existing zCModelAni *
0x57A4A6   F58   8B 4C 24 34             mov     ecx, [esp+0xF58-0xF24]      # zCModelPrototype *
0x57A4AA   F58   51                      push    ecx
0x57A4AB   F5C   89 FA                   mov     edx, edi                    # New zCModelAni->name
0x57A4AD   F5C   E8 9E 53 FF FF          call    0x56F850-0x57A4AD-1         # zCModelPrototype::SearchAniIndex(zSTRING const &)
0x57A4B2   F5C   59                      pop     ecx
0x57A4B3   F58   8B 49 48                mov     ecx, [ecx+0x48]
0x57A4B6   F58   8B 54 24 20             mov     edx, [esp+0xF58-0xF38]      # New zCModelAni *
0x57A4BA   F38   89 14 81                mov     [ecx+eax*4], edx            # New ani
0x57A4BD   F54   59                      pop     ecx                         # Old ani
0x57A4BE   F54   8B 41 04                mov     eax, [ecx+4]
0x57A4C1   F54   48                      dec     eax                         # Decrease refCtr
0x57A4C2   F54   89 41 04                mov     [ecx+4], eax
0x57A4C5   F54   83 F8 00                cmp     eax, 0
0x57A4C8   F54   0F 8F 1C FD FF FF       jg      0x57A1EA-0x57A4C8-2         # Continue
0x57A4CE   F54   6A 01                   push    1                           # If refCtr <= 0 then
0x57A4D0   F54   E8 4B 05 FF FF          call    0x56AA20-0x57A4D0-1         # zCModelAni::scalar_deleting_destructor
0x57A4D5   F54   E9 10 FD FF FF          jmp     0x57A1EA-0x57A4D5-1         # Continue
# Room up to 0x57A4FD


aniBatch_replace:

0x57A72A   F54   50                      push    eax                         # Existing zCModelAni *
0x57A72B   F58   8B 4C 24 34             mov     ecx, [esp+0xF58-0xF24]      # zCModelPrototype *
0x57A72F   F58   51                      push    ecx
0x57A730   F5C   8B 54 24 24             mov     edx, [esp+0xF5C-0xF38]      # New zCModelAni *
0x57A734   F5C   83 C2 24                add     edx, 0x24
0x57A737   F5C   E8 14 51 FF FF          call    0x56F850-0x57A737-1         # zCModelPrototype::SearchAniIndex(zSTRING const &)
0x57A73C   F5C   59                      pop     ecx
0x57A73D   F58   8B 49 48                mov     ecx, [ecx+0x48]
0x57A740   F58   8B 54 24 20             mov     edx, [esp+0xF58-0xF38]
0x57A744   F58   89 14 81                mov     [ecx+eax*4], edx            # New ani
0x57A747   F58   59                      pop     ecx                         # Old ani
0x57A748   F54   8B 41 04                mov     eax, [ecx+4]
0x57A74B   F54   48                      dec     eax                         # Decrease refCtr
0x57A74C   F54   89 41 04                mov     [ecx+4], eax
0x57A74F   F54   83 F8 00                cmp     eax, 0
0x57A752   F54   0F 8F 3D 00 00 00       jg      0x57A795-0x57A752-2         # Continue
0x57A758   F54   6A 01                   push    1                           # If refCtr <= 0 then
0x57A75A   F58   E8 C1 02 FF FF          call    0x56AA20-0x57A75A-1         # zCModelAni::scalar_deleting_destructor
0x57A75F   F54   E9 31 00 00 00          jmp     0x57A795-0x57A75F-1         # Continue
# Room up to 0x57A783


aniDisable_replace:

0x57B372   F54   50                      push    eax                         # Existing zCModelAni *
0x57B373   F58   8B 4C 24 34             mov     ecx, [esp+0xF58-0xF24]      # zCModelPrototype *
0x57B377   F58   51                      push    ecx
0x57B378   F5C   89 FA                   mov     edx, edi                    # New zCModelAni->name
0x57B37A   F5C   E8 D1 44 FF FF          call    0x56F850-0x57B37A-1         # zCModelPrototype::SearchAniIndex(zSTRING const &)
0x57B37F   F5C   59                      pop     ecx
0x57B380   F58   8B 49 48                mov     ecx, [ecx+0x48]
0x57B383   F58   8B 54 24 20             mov     edx, [esp+0xF58-0xF38]      # New zCModelAni *
0x57B387   F38   89 14 81                mov     [ecx+eax*4], edx            # New ani
0x57B38A   F54   59                      pop     ecx                         # Old ani
0x57B38B   F54   8B 41 04                mov     eax, [ecx+4]
0x57B38E   F54   48                      dec     eax                         # Decrease refCtr
0x57B38F   F54   89 41 04                mov     [ecx+4], eax
0x57B392   F54   83 F8 00                cmp     eax, 0
0x57B395   F54   0F 8F 42 00 00 00       jg      0x57B3DD-0x57B395-2         # Continue
0x57B39B   F54   6A 01                   push    1                           # If refCtr <= 0 then
0x57B39D   F54   E8 7E F6 FE FF          call    0x56AA20-0x57B39D-1         # zCModelAni::scalar_deleting_destructor
0x57B3A2   F54   E9 36 00 00 00          jmp     0x57B3DD-0x57B3A2-1         # Continue
# Room up to 0x57B3CB




###########
## Hooks ##
###########




# zCPar_Symbol * __thiscall zCPar_Symbol::GetNext(void)

0x6F84D0         E9 AA 05 D1 FF          jmp     0x408A7F-0x6F84D0-1         # loc_func_symbNext


loc_parser_check_var_hook:

0x6F18CD         E9 17 12 D6 FF          jmp     0x452AE9-0x6F18CD-1         # loc_parser_check_var
# Overwrites:    68 BA 03 00 00          push    0x3BA


loc_parser_check_class_hook:

0x6F2B21         E9 36 00 D6 FF          jmp     0x452B5C-0x6F2B21-1         # loc_parser_check_class
# Overwrites:    E8 BA C0 E5 FF          call    operator new(uint,char const *,char const *,int)


loc_parser_check_prototype_hook:

0x6F36B2         E9 CF F4 D5 FF          jmp     0x452B86-0x6F36B2-1         # loc_parser_check_prototype
# Overwrites:    68 DF 04 00 00          push    0x4DF


loc_parser_check_func_hook:

0x6F494E         E9 E4 E0 D5 FF          jmp     0x452A37-0x6F494E-1         # loc_parser_check_func
# Overwrites:    68 AE 05 00 00          push    0x5AE


loc_linker_replace_func_hook:

0x6E79C1         E9 98 B0 D6 FF          jmp     0x452A5E-0x6E79C1-1         # loc_linker_replace_func
# Overwrites:    E8 5A 0B 01 00          call    zCPar_Symbol::SetStackPos(int,int)


loc_music:

0x4DA448         E9 2C 84 F7 FF          jmp     0x452879-0x4DA448-1         # loc_deploy_music_ninja
# Overwrites:    8D 54 24 13             lea     edx, [esp+0x0D8-0xC5]
#                52                      push    edx


loc_sfx:

0x4DD88C         E9 0F 50 F7 FF          jmp     0x4528A0-0x4DD88C-1         # loc_deploy_sfx_ninja
# Overwrites:    8D 4C 24 12             lea     ecx, [esp+0x304+0x2F2]
#                51                      push    ecx


loc_pfx:

0x58CA22         E9 A0 5E EC FF          jmp     0x4528C7-0x58CA22-1         # loc_deploy_pfx_ninja
# Overwrites:    8D 44 24 13             lea     eax, [esp+0x08C-0x79]
#                50                      push    eax


loc_vfx:

0x483A3C         E9 AD EE FC FF          jmp     0x4528EE-0x483A3C-1         # loc_deploy_vfx_ninja
# Overwrites:    8D 54 24 0F             lea     edx, [esp+0x248-0x239]
#                52                      push    edx


loc_content:

0x6371F1         E9 1F B7 E1 FF          jmp     0x452915-0x6371F1-1         # loc_deploy_content_ninja
0x6371F6         90                      nop
# Overwrites:    6A 01                   push    1
#                8D 4C 24 50             lea     ecx, [esp+0x94-0x44]


loc_fightai:

0x747EBA         E9 7D AA D0 FF          jmp     0x45293C-0x747EBA-1         # loc_deploy_fightai_ninja
# Overwrites:    8D 54 24 13             lea     edx, [esp+0x7C-0x69]
#                52                      push    edx


loc_menu:

0x4CD57A         E9 DF 53 F8 FF          jmp     0x45295E-0x4CD57A-1         # loc_deploy_menu_ninja
# Overwrites:    A1 4C EE 8C 00          mov     eax, zCSoundSystem * zsound


loc_camera:

0x49909E         E9 E2 98 FB FF          jmp     0x452985-0x49909E-1         # loc_deploy_camera_ninja
# Overwrites:    8D 44 24 13             lea     eax, [esp+0x0B4-0xA1]
#                50                      push    eax


loc_createmenu:

0x4CE90F         E9 98 40 F8 FF          jmp     0x4529AC-0x4CE90F-1         # loc_init_menu
# Overwrites:    5D                      pop     ebp
#                8B 4C 24 1C             mov     ecx, [esp+0x28-0xC]


loc_initglobal:  # In Gothic 1 there is no Init_Global, instead call AFTER Init_[World]

0x637F84         E9 49 AA E1 FF          jmp     0x4529D2-0x637F84-1         # loc_init_content
0x637F89         90                      nop
# Overwrites:    89 3D 90 DF 8D 00       mov     ds:0x8DDF90, edi


loc_readAniEnum_hook:

0x57DC40         E9 B3 4D ED FF          jmp     0x4529F8-0x57DC40-1         # loc_init_anims
0x5961D2         90 90                   nop nop
# Overwrites:    39 AC 24 CC 00 00 00    cmp     [esp+0xF54-0xE88], ebp
