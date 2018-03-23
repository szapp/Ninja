# Misc: Overwritten code and hooks


#########################
##  Overwritten Bytes  ##
#########################


loc_parser_redefined_var:

0x79BAD5         56                      push    esi
0x79BAD6         90                      nop
0x79BAD7         50                      push    eax

0x79BAD8         C6 84 24 F0 03 00 00 11 mov     BYTE PTR [esp+0x3F4-4], 0x11
0x79BAE0         E8 EB D1 C6 FF          call    0x408CD0-0x79BAE0-1         # ninja_parseMsgOverwrite(zSTRING const &)
0x79BAE5         5E                      pop     esi


loc_parser_redefined_class:

0x79C4BD         56                      push    esi
0x79C4BE         90                      nop
0x79C4BF         50                      push    eax
0x79C4C0         C6 44 24 50 02          mov     BYTE PTR [esp+0x54-4], 2
0x79C4C5         E8 06 C8 C6 FF          call    0x408CD0-0x79C4C5-1         # ninja_parseMsgOverwrite(zSTRING const &)
0x79C4CA         5E                      pop     esi


loc_parser_redefined_inst:

0x79CBFD         56                      push    esi
0x79CBFE         90                      nop
0x79CBFF         50                      push    eax
0x79CC00         C6 84 24 D0 00 00 00 11 mov     BYTE PTR [esp+0x0D4-4], 0x11
0x79CC08         E8 C3 C0 C6 FF          call    0x408CD0-0x79CC08-1         # ninja_parseMsgOverwrite(zSTRING const &)
0x79CC0D         5E                      pop     esi


loc_parser_redefined_proto:

0x79D017         56                      push    esi
0x79D018         90                      nop
0x79D019         50                      push    eax
0x79D01A         C6 84 24 BC 00 00 00 09 mov     BYTE PTR [esp+0x0C0-4], 9
0x79D022         E8 A9 BC C6 FF          call    0x408CD0-0x79D022-1         # ninja_parseMsgOverwrite(zSTRING const &)
0x79D027         5E                      pop     esi


loc_parser_redefined_func:

0x79E225         56                      push    esi
0x79E226         90                      nop
0x79E227         50                      push    eax
0x79E228         C6 84 24 A8 00 00 00 02 mov     BYTE PTR [esp+0x0AC-4], 2
0x79E230         E8 9B AA C6 FF          call    0x408CD0-0x79E230-1         # ninja_parseMsgOverwrite(zSTRING const &)
0x79E235         90                      nop
0x79E236         5E                      pop     esi


loc_skipWriteAniBinFile_ani:

0x59BFA9         8B 44 24 20           mov     eax, [esp+0x12AC-0x129C+0x10]
0x59BFAD         89 44 24 E4           mov     [esp+0x12AC-0x12C8], eax
0x59BFB1         E9 91 02 00 00        jmp     0x59C247-0x59BFB1-1


ani_replace:

0x59C406  1310   50                      push    eax                         # Existing zCModelAni *
0x59C407  1314   8B 4C 24 4C             mov     ecx, [esp+0x1314-0x12C8]
0x59C40B  1314   51                      push    ecx
0x59C40C  1318   8B 54 24 1C             mov     edx, [esp+0x1318-0x12FC]
0x59C410  1318   83 C2 24                add     edx, 0x24
0x59C413  1318   E8 A8 DB FE FF          call    0x589FC0-0x59C413-1         # zCModelPrototype::SearchAniIndex(zSTRING const &)
0x59C418  1318   59                      pop     ecx
0x59C419  1314   8B 49 48                mov     ecx, [ecx+0x48]
0x59C41C  1314   8B 54 24 18             mov     edx, [esp+0x1314-0x12FC]
0x59C420  1314   89 14 81                mov     [ecx+eax*4], edx            # New ani
0x59C423  1314   59                      pop     ecx                         # Old ani
0x59C424  1310   8B 41 04                mov     eax, [ecx+4]
0x59C427  1310   48                      dec     eax                         # Decrease refCtr
0x59C428  1310   89 41 04                mov     [ecx+4], eax
0x59C42B  1310   83 F8 00                cmp     eax, 0
0x59C42E  1310   0F 8F 8F 02 00 00       jg      0x59C6C3-0x59C42E-2         # Continue
0x59C434  1310   6A 01                   push    1                           # If refCtr <= 0 then
0x59C436  1314   E8 95 8E FE FF          call    0x5852D0-0x59C436-1         # zCModelAni::scalar_deleting_destructor
0x59C43B  1310   E9 83 02 00 00          jmp     0x59C6C3-0x59C43B-1
# Room up to 0x59C459


aniAlias_replace:

0x597AA7  12E8   50                      push    eax                         # Existing zCModelAni *
0x597AA8  12EC   8B 4C 24 4C             mov     ecx, [esp+0x12EC-0x12A0]
0x597AAC  12EC   51                      push    ecx
0x597AAD  12D0   89 EA                   mov     edx, ebp
0x597AAF  12D0   E8 0C 25 FF FF          call    0x589FC0-0x597AAF-1         # zCModelPrototype::SearchAniIndex(zSTRING const &)
0x597AB4  12D0   59                      pop     ecx
0x597AB5  12EC   8B 49 48                mov     ecx, [ecx+0x48]
0x597AB8  12EC   89 3C 81                mov     [ecx+eax*4], edi            # New ani
0x597ABB  12EC   59                      pop     ecx                         # Old ani
0x597ABC  12E8   8B 41 04                mov     eax, [ecx+4]
0x597ABF  12E8   48                      dec     eax                         # Decrease refCtr
0x597AC0  12E8   89 41 04                mov     [ecx+4], eax
0x597AC3  12E8   83 F8 00                cmp     eax, 0
0x597AC6  12E8   0F 8F 44 00 00 00       jg      0x597B10-0x597AC6-2         # Continue
0x597ACC  12E8   6A 01                   push    1                           # If refCtr <= 0 then
0x597ACE  12EC   E8 FD D7 FE FF          call    0x5852D0-0x597ACE-1         # zCModelAni::scalar_deleting_destructor
0x597AD3  12E8   E9 38 00 00 00          jmp     0x597B10-0x597AD3-1         # Continue
# Room up to 0x597AFA


aniComb_replace:

0x599456  12EC   50                      push    eax                         # Existing zCModelAni *
0x599457  12D0   89 F9                   mov     ecx, edi
0x599459  12D0   51                      push    ecx
0x59945A  12D4   89 DA                   mov     edx, ebx
0x59945C  12D4   E8 5F 0B FF FF          call    0x589FC0-0x59945C-1         # zCModelPrototype::SearchAniIndex(zSTRING const &)
0x599461  12D4   59                      pop     ecx
0x599462  12D0   8B 49 48                mov     ecx, [ecx+0x48]
0x599465  12D0   89 2C 81                mov     [ecx+eax*4], ebp            # New ani
0x599468  12D0   59                      pop     ecx                         # Old ani
0x599469  12EC   8B 41 04                mov     eax, [ecx+4]
0x59946C  12EC   48                      dec     eax                         # Decrease refCtr
0x59946D  12EC   89 41 04                mov     [ecx+4], eax
0x599470  12EC   83 F8 00                cmp     eax, 0
0x599473  12EC   0F 8F 42 00 00 00       jg      0x5994BB-0x599473-2         # Continue
0x599479  12EC   6A 01                   push    1                           # If refCtr <= 0 then
0x59947B  12D0   E8 50 BE FE FF          call    0x5852D0-0x59947B-1         # zCModelAni::scalar_deleting_destructor
0x599480  12EC   E9 36 00 00 00          jmp     0x5994BB-0x599480-1         # Continue
# Room up to 0x5994A9


aniBlend_replace:

0x598065  12D4   50                      push    eax                         # Existing zCModelAni *
0x598066  12D8   8B 4C 24 4C             mov     ecx, [esp+0x12D8-0x129C+0x10]
0x59806A  12D8   51                      push    ecx
0x59806B  12DC   89 EA                   mov     edx, ebp
0x59806D  12DC   E8 4E 1F FF FF          call    0x589FC0-0x59806D-1         # zCModelPrototype::SearchAniIndex(zSTRING const &)
0x598072  12DC   59                      pop     ecx
0x598073  12D8   8B 49 48                mov     ecx, [ecx+0x48]
0x598076  12D8   89 3C 81                mov     [ecx+eax*4], edi            # New ani
0x598079  12D8   59                      pop     ecx                         # Old ani
0x59807A  12D4   8B 41 04                mov     eax, [ecx+4]
0x59807D  12D4   48                      dec     eax                         # Decrease refCtr
0x59807E  12D4   89 41 04                mov     [ecx+4], eax
0x598081  12D4   83 F8 00                cmp     eax, 0
0x598084  12D4   0F 8F 44 00 00 00       jg      0x5980CE-0x598084-2         # Continue
0x59808A  12D4   6A 01                   push    1                           # If refCtr <= 0 then
0x59808C  12D4   E8 3F D2 FE FF          call    0x5852D0-0x59808C-1         # zCModelAni::scalar_deleting_destructor
0x598091  12D4   E9 38 00 00 00          jmp     0x5980CE-0x598091-1         # Continue
# Room up to 0x5980A9


aniSync_replace:

0x5984E1  12C4   50                      push    eax                         # Existing zCModelAni *
0x5984E2  12C8   8B 4C 24 4C             mov     ecx, [esp+0x12C8-0x1284+8]
0x5984E6  12C8   51                      push    ecx
0x5984E7  12CC   89 EA                   mov     edx, ebp
0x5984E9  12CC   E8 D2 1A FF FF          call    0x589FC0-0x5984E9-1         # zCModelPrototype::SearchAniIndex(zSTRING const &)
0x5984EE  12CC   59                      pop     ecx
0x5984EF  12C8   8B 49 48                mov     ecx, [ecx+0x48]
0x5984F2  12C4   89 3C 81                mov     [ecx+eax*4], edi            # New ani
0x5984F5  12C4   59                      pop     ecx                         # Old ani
0x5984F6  12C4   8B 41 04                mov     eax, [ecx+4]
0x5984F9  12C4   48                      dec     eax                         # Decrease refCtr
0x5984FA  12C4   89 41 04                mov     [ecx+4], eax
0x5984FD  12C4   83 F8 00                cmp     eax, 0
0x598500  12C4   0F 8F 44 00 00 00       jg      0x59854A-0x598500-2         # Continue
0x598506  12C4   6A 01                   push    1                           # If refCtr <= 0 then
0x598508  12C4   E8 C3 CD FE FF          call    0x5852D0-0x598508-1         # zCModelAni::scalar_deleting_destructor
0x59850D  12C4   E9 38 00 00 00          jmp     0x59854A-0x59850D-1         # Continue
# Room up to 0x598534


aniBatch_replace:

0x59875B  128C   50                      push    eax                         # Existing zCModelAni *
0x59875C  1290   8B 4C 24 4C             mov     ecx, [esp+0x1290-0x1244]
0x598760  1290   51                      push    ecx
0x598761  1294   89 FA                   mov     edx, edi
0x598763  1294   E8 58 18 FF FF          call    0x589FC0-0x598763-1         # zCModelPrototype::SearchAniIndex(zSTRING const &)
0x598768  1294   59                      pop     ecx
0x598769  1290   8B 49 48                mov     ecx, [ecx+0x48]
0x59876C  1290   89 2C 81                mov     [ecx+eax*4], ebp            # New ani
0x59876F  1290   59                      pop     ecx                         # Old ani
0x598770  128C   8B 41 04                mov     eax, [ecx+4]
0x598773  128C   48                      dec     eax                         # Decrease refCtr
0x598774  128C   89 41 04                mov     [ecx+4], eax
0x598777  128C   83 F8 00                cmp     eax, 0
0x59877A  128C   0F 8F 44 00 00 00       jg      0x5987C4-0x59877A-2         # Continue
0x598780  128C   6A 01                   push    1                           # If refCtr <= 0 then
0x598782  1290   E8 49 CB FE FF          call    0x5852D0-0x598782-1         # zCModelAni::scalar_deleting_destructor
0x598787  128C   E9 38 00 00 00          jmp     0x5987C4-0x598787-1         # Continue
# Room up to 0x5987AE


aniDisable_replace:

0x599783  12C0   50                      push    eax                         # Existing zCModelAni *
0x599784  12C4   8B 4C 24 4C             mov     ecx, [esp+0x12C4-0x1284+0xC]
0x599788  12C4   51                      push    ecx
0x599789  12C8   89 EA                   mov     edx, ebp
0x59978B  12C8   E8 30 08 FF FF          call    0x589FC0-0x59978B-1         # zCModelPrototype::SearchAniIndex(zSTRING const &)
0x599790  12C8   59                      pop     ecx
0x599791  12C4   8B 49 48                mov     ecx, [ecx+0x48]
0x599794  12C4   89 3C 81                mov     [ecx+eax*4], edi            # New ani
0x599797  12C0   59                      pop     ecx                         # Old ani
0x599798  12C0   8B 41 04                mov     eax, [ecx+4]
0x59979B  12C0   48                      dec     eax                         # Decrease refCtr
0x59979C  12C0   89 41 04                mov     [ecx+4], eax
0x59979F  12C0   83 F8 00                cmp     eax, 0
0x5997A2  12C0   0F 8F 26 E9 FF FF       jg      0x5980CE-0x5997A2-2         # Continue
0x5997A8  12C0   6A 01                   push    1                           # If refCtr <= 0 then
0x5997AA  12C4   E8 21 BB FE FF          call    0x5852D0-0x5997AA-1         # zCModelAni::scalar_deleting_destructor
0x5997AF  12C0   E9 1A E9 FF FF          jmp     0x5980CE-0x5997AF-1         # Continue
# Room up to 0x5997CE




###########
## Hooks ##
###########




# zCPar_Symbol * __thiscall zCPar_Symbol::GetNext(void)

0x7A1DD0         E9 1E 6F C6 FF          jmp     0x408CF3-0x7A1DD0-1         # loc_func_symbNext


loc_parser_check_var_hook:

0x79B3B5         E9 31 C6 CB FF          jmp     0x4579EB-0x79B3B5-1         # loc_parser_check_var
0x79B3BA         90                      nop
0x79B3BB         90                      nop
# Overwrites:    6A 3C                   push    0x3C
#                E8 94 AB DC FF          call    operator new(uint)


loc_parser_check_class_hook:

0x79C432         E9 4E B6 CB FF          jmp     0x457A85-0x79C432-1         # loc_parser_check_class
# Overwrites:    E8 19 9B DC FF          call    operator new(uint)


loc_parser_check_prototype_hook:

0x79CF72         E9 35 AB CB FF          jmp     0x457AAC-0x79CF72-1         # loc_parser_check_prototype
# Overwrites:    6A 3C                   push    0x3C
#                E8 D7 8F DC FF          call    operator new(uint)


loc_parser_check_func_hook:

0x79E1AE         E9 89 97 CB FF          jmp     0x45793C-0x79E1AE-1         # loc_parser_check_func
0x79E1B3         90                      nop
0x79E1B4         90                      nop
# Overwrites:    6A 3C                   push    0x3C
#                E8 9B 7D DC FF          call    operator new(uint)


loc_linker_replace_func_hook:

0x790CA8         E9 B9 6C CC FF          jmp     0x457966-0x790CA8-1         # loc_linker_replace_func
# Overwrites:    E8 73 11 01 00          call    zCPar_Symbol::SetStackPos(int,int)


loc_music:

0x4E765C         E9 36 01 F7 FF          jmp     0x457797-0x4E765C-1         # loc_deploy_music_ninja
# Overwrites:    8D 54 24 13             lea     edx, [esp+0x0C8-0xB5]
#                52                      push    edx


loc_sfx:

0x4EAE8B         E9 2E C9 F6 FF          jmp     0x4577BE-0x4EAE8B-1         # loc_deploy_sfx_ninja
# Overwrites:    8D 44 24 12             lea     eax, [esp+0x308-0x2F6]
#                50                      push    eax

loc_pfx:

0x5AC7BC         E9 24 B0 EA FF          jmp     0x4577E5-0x5AC7BC-1         # loc_deploy_pfx_ninja
# Overwrites:    8D 44 24 13             lea     eax, [esp+0x0C8-0xB5]
#                50                      push    eax


loc_vfx:

0x48B6EF         E9 18 C1 FC FF          jmp     0x45780C-0x48B6EF-1         # loc_deploy_vfx_ninja
# Overwrites:    8D 44 24 1B             lea     eax, [esp+0x250-0x235]
#                50                      push    eax


loc_content:

0x6C12A0         E9 8E 65 D9 FF          jmp     0x457833-0x6C12A0-1         # loc_deploy_content_ninja
0x6C12A5         90                      nop
# Overwrites:    6A 01                   push    1
#                8D 4C 24 68             lea     ecx, [esp+0x84-0x1C]


loc_fightai:

0x67C626         E9 2F B2 DD FF          jmp     0x45785A-0x67C626-1         # loc_deploy_fightai_ninja
# Overwrites:    8D 44 24 13             lea     eax, [esp+0x64-0x51]
#                50                      push    eax


loc_menu:

0x4DA196         E9 E1 D6 F7 FF          jmp     0x45787C-0x4DA196-1         # loc_deploy_menu_ninja
# Overwrites:    A1 3C B0 99 00          mov     eax, zCSoundSystem * zsound


loc_camera:

0x4A0554         E9 4A 73 FB FF          jmp     0x4578A3-0x4A0554-1         # loc_deploy_camera_ninja
# Overwrites:    8D 54 24 13             lea     edx, [esp+0x0B8-0xA5]
#                52                      push    edx


loc_createmenu:

0x4DB4FF         E9 C6 C3 F7 FF          jmp     0x4578CA-0x4DB4FF-1         # loc_init_menu
# Overwrites:    5D                      pop     ebp
#                8B 4C 24 1C             mov     ecx, [esp+0x28-0xC]


loc_initglobal:

0x6C20C3         E9 28 58 D9 FF          jmp     0x4578F0-0x6C20C3-1         # loc_init_content
# Overwrites:    83 C4 08                add     esp, 8
#                85 C0                   test    eax, eax


loc_readAniEnum_hook:

0x5961CD         E9 44 17 EC FF          jmp     0x457916-0x5961CD-1         # loc_init_anims
0x5961D2         90 90                   nop nop
# Overwrites:    8B 84 24 BC 00 00 00    mov     eax, [esp+0x49C-0x3E0]
