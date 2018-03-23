# Third location: executing code continued and data


# Parsers in order:
# - Music:               zCParser * zCMusicSys_DirectMusic::musicParser     0x86D6A8
# - SFX:                 zCParser * zCSndSys_MSS::sfxParser                 0x86DCFC
# - PFX:                 zCParser * zCParticleFX::s_pfxParser               0x874380
# - VFX:                 zCParser * oCVisualFX::fxParser                    0x869E6C
# - Content:             zCParser parser                                    0x8DCE08 (offset)
# - FightAI:             [temporary parser]                                 ebx
# - Menu:                zCParser * zCMenu::menuParser                      0x86D3D8
# Later: on game init
# - Camera:              zCParser * zCAICamera::cameraParser                0x86A1E0



# Jump from 0x452873 to 0x4530B2
# Gives about 2122 "free" (unused) bytes


loc_start:

0x452873         90                      nop
0x452874         E9 3A 08 00 00          jmp     loc_skip                    # 0x4530B2-0x452873-1


loc_deploy_music_ninja:

0x452879         60                      pusha
0x45287A         68 AB 89 40 00          push    0x4089AB                    # offset ninja_mergeSrc(char *)
0x45287F         68 E8 2B 45 00          push    0x452BE8                    # offset NINJA_PATH_MUSIC
0x452884         A1 A8 D6 86 00          mov     eax, ds:0x86D6A8            # zCParser * zCMusicSys_DirectMusic::musicParser
0x452889         50                      push    eax
0x45288A         E8 5C 61 FB FF          call    0x4089EB-0x45288A-1         # ninja_inject(zCParser *,char *,void (__stdcall *)(char *))
0x45288F         61                      popa
0x452890         8D 54 24 13             lea     edx, [esp+0x0D8-0xC5]
0x452894         52                      push    edx
0x452895         E9 B3 7B 08 00          jmp     0x4DA44D-0x452895-1         # back


0x45289A         90 90 90 90 90 90       nop nop nop nop nop nop


loc_deploy_sfx_ninja:

0x4528A0         60                      pusha
0x4528A1         68 AB 89 40 00          push    0x4089AB                    # offset ninja_mergeSrc(char *)
0x4528A6         68 F6 2B 45 00          push    0x452BF6                    # offset NINJA_PATH_SFX
0x4528AB         A1 FC DC 86 00          mov     eax, ds:0x86DCFC            # zCParser * zCSndSys_MSS::sfxParser
0x4528B0         50                      push    eax
0x4528B1         E8 35 61 FB FF          call    0x4089EB-0x4528B1-1         # ninja_inject(zCParser *,char *,void (__stdcall *)(char *))
0x4528B6         61                      popa
0x4528B7         8D 4C 24 12             lea     ecx, [esp+0x304-0x2F2]
0x4528BB         51                      push    ecx
0x4528BC         E9 D0 AF 08 00          jmp     0x4DD891-0x4528BC-1         # back


0x4528C1         90 90 90 90 90 90       nop nop nop nop nop nop


loc_deploy_pfx_ninja:

0x4528C7         60                      pusha
0x4528C8         68 AB 89 40 00          push    0x4089AB                    # offset ninja_mergeSrc(char *)
0x4528CD         68 02 2C 45 00          push    0x452C02                    # offset NINJA_PATH_PFX
0x4528D2         A1 80 43 87 00          mov     eax, ds:0x874380            # zCParser * zCParticleFX::s_pfxParser
0x4528D7         50                      push    eax
0x4528D8         E8 0E 61 FB FF          call    0x4089EB-0x4528D8-1         # ninja_inject(zCParser *,char *,void (__stdcall *)(char *))
0x4528DD         61                      popa
0x4528DE         8D 44 24 13             lea     eax, [esp+0x08C-0x79]
0x4528E2         50                      push    eax
0x4528E3         E9 3F A1 13 00          jmp     0x58CA27-0x4528E3-1         # back


0x4528E8         90 90 90 90 90 90       nop nop nop nop nop nop


loc_deploy_vfx_ninja:

0x4528EE         60                      pusha
0x4528EF         68 AB 89 40 00          push    0x4089AB                    # offset ninja_mergeSrc(char *)
0x4528F4         68 0E 2C 45 00          push    0x452C0E                    # offset NINJA_PATH_VFX
0x4528F9         A1 6C 9E 86 00          mov     eax, ds:0x869E6C            # zCParser * oCVisualFX::fxParser
0x4528FE         50                      push    eax
0x4528FF         E8 E7 60 FB FF          call    0x4089EB-0x4528FF-1         # ninja_inject(zCParser *,char *,void (__stdcall *)(char *))
0x452904         61                      popa
0x452905         8D 54 24 0F             lea     edx, [esp+0x248-0x239]
0x452909         52                      push    edx
0x45290A         E9 32 11 03 00          jmp     0x483A41-0x45290A-1         # back


0x45290F         90 90 90 90 90 90       nop nop nop nop nop nop


loc_deploy_content_ninja:

0x452915         60                      pusha
0x452916         68 AB 89 40 00          push    0x4089AB                    # offset ninja_mergeSrc(char *)
0x45291B         68 1A 2C 45 00          push    0x452C1A                    # offset NINJA_PATH_CONTENT
0x452920         68 08 CE 8D 00          push    0x8DCE08                    # offset zCParser parser
0x452925         E8 C1 60 FB FF          call    0x4089EB-0x452925-1         # ninja_inject(zCParser *,char *,void (__stdcall *)(char *))
0x45292A         61                      popa
0x45292B         6A 01                   push    1
0x45292D         8D 4C 24 50             lea     ecx, [esp+0x94-0x44]
0x452931         E9 C1 48 1E 00          jmp     0x6371F7-0x452931-1         # back


0x452936         90 90 90 90 90 90       nop nop nop nop nop nop


loc_deploy_fightai_ninja:

0x45293C         60                      pusha
0x45293D         68 AB 89 40 00          push    0x4089AB                    # offset ninja_mergeSrc(char *)
0x452942         68 2A 2C 45 00          push    0x452C2A                    # offset NINJA_PATH_FIGHT
0x452947         53                      push    ebx
0x452948         E8 9E 60 FB FF          call    0x4089EB-0x452948-1         # ninja_inject(zCParser *,char *,void (__stdcall *)(char *))
0x45294D         61                      popa
0x45294E         8D 54 24 13             lea     edx, [esp+0x7C-0x69]
0x452952         52                      push    edx
0x452953         E9 67 55 2F 00          jmp     0x747EBF-0x452953-1         # back


0x452958         90 90 90 90 90 90       nop nop nop nop nop nop


loc_deploy_menu_ninja:

0x45295E         60                      pusha
0x45295F         68 AB 89 40 00          push    0x4089AB                    # offset ninja_mergeSrc(char *)
0x452964         68 38 2C 45 00          push    0x452C38                    # offset NINJA_PATH_MENU
0x452969         A1 D8 D3 86 00          mov     eax, ds:0x86D3D8            # eax, zCParser * zCMenu::menuParser
0x45296E         50                      push    eax
0x45296F         E8 77 60 FB FF          call    0x4089EB-0x45296F-1         # ninja_inject(zCParser *,char *,void (__stdcall *)(char *))
0x452974         61                      popa
0x452975         A1 4C EE 8C 00          mov     eax, ds:0x8CEE4C            # zCSoundSystem * zsound
0x45297A         E9 00 AC 07 00          jmp     0x4CD57F-0x45297A-1         # back


0x45297F         90 90 90 90 90 90       nop nop nop nop nop nop


loc_deploy_camera_ninja:

0x452985         60                      pusha
0x452986         68 AB 89 40 00          push    0x4089AB                    # offset ninja_mergeSrc(char *)
0x45298B         68 45 2C 45 00          push    0x452C45                    # offset NINJA_PATH_CAMERA
0x452990         A1 E0 A1 86 00          mov     eax, ds:0x86A1E0            # zCParser * zCAICamera::cameraParser
0x452995         50                      push    eax
0x452996         E8 50 60 FB FF          call    0x4089EB-0x452996-1         # ninja_inject(zCParser *,char *,void (__stdcall *)(char *))
0x45299B         61                      popa
0x45299C         8D 44 24 13             lea     eax, [esp+0x0B4-0xA1]
0x4529A0         50                      push    eax
0x4529A1         E9 FD 66 04 00          jmp     0x4990A3-0x4529A1-1         # back


0x4529A6         90 90 90 90 90 90       nop nop nop nop nop nop


loc_init_menu:

0x4529AC         60                      pusha
0x4529AD         68 47 89 40 00          push    0x408947                    # offset ninja_initMenu(char *)
0x4529B2         68 1A 2C 45 00          push    0x452C1A                    # offset NINJA_PATH_CONTENT
0x4529B7         68 08 CE 8D 00          push    0x8DCE08                    # offset zCParser parser
0x4529BC         E8 2A 60 FB FF          call    0x4089EB-0x4529BC-1         # ninja_inject(zCParser *,char *,void (__stdcall *)(char *))
0x4529C1         61                      popa
0x4529C2         5D                      pop     ebp
0x4529C3         8B 4C 24 1C             mov     ecx, [esp+0x28-0xC]
0x4529C7         E9 48 BF 07 00          jmp     0x4CE914-0x4529C7-1         # back


0x4529CC         90 90 90 90 90 90       nop nop nop nop nop nop


loc_init_content:

0x4529D2         60                      pusha
0x4529D3         68 E7 88 40 00          push    0x4088E7                    # offset ninja_initContent(char *)
0x4529D8         68 1A 2C 45 00          push    0x452C1A                    # offset NINJA_PATH_CONTENT
0x4529DD         68 08 CE 8D 00          push    0x8DCE08                    # offset zCParser parser
0x4529E2         E8 04 60 FB FF          call    0x4089EB-0x4529E2-1         # ninja_inject(zCParser *,char *,void (__stdcall *)(char *))
0x4529E7         61                      popa
0x4529E8         89 3D 90 DF 8D 00       mov     ds:0x8DDF90, edi
0x4529EE         E9 97 55 1E 00          jmp     0x637F8A-0x4529EE-1         # back


0x4529F3         90 90 90 90 90          nop nop nop nop nop


loc_init_anims:

0x4529F8         60                      pusha
0x4529F9         8B 6C 24 50             mov     ebp, [esp+0xF74-0xF24]      # zCModelPrototype *
0x4529FD         8B 75 14                mov     esi, [ebp+0x14]             # name->ptr
0x452A00         56                      push    esi
0x452A01         8B 35 6C 3D 87 00       mov     esi, DWORD PTR ds:0x873D6C  # zFILE *cur_mds_file
0x452A07         8B 76 40                mov     esi, [esi+0x40]             # name->ptr
0x452A0A         56                      push    esi
0x452A0B         FF 15 C4 02 7D 00       call    ds:0x7D02C4                 # lstrcmpiA(LPCSTR,LPCSTR)
0x452A11         85 C0                   test    eax, eax
0x452A13         75 0F                   jnz     short loc_ia_back
0x452A15         68 B0 0B 41 00          push    0x410BB0                    # offset ninja_initAnims(char *)
0x452A1A         68 54 2C 45 00          push    0x452C54                    # offset NINJA_PATH_ANIMATION
0x452A1F         E8 8A 5D FB FF          call    0x4087AE-0x452A1F-1         # ninja_findVdfSrc(char *,void (__stdcall *)(char *))

loc_ia_back:

0x452A24         61                      popa
0x452A25         39 AC 24 CC 00 00 00    cmp     [esp+0xF54-0xE88], ebp
0x452A2C         E9 16 B2 12 00          jmp     0x57DC47-0x452A2C-1         # back


0x452A31         90 90 90 90 90 90       nop nop nop nop nop nop


loc_parser_check_func:

0x452A37         8D 4C 24 28             lea     ecx, [esp+0xA4-0x7C]
0x452A3B         51                      push    ecx
0x452A3C         8D 4E 10                lea     ecx, [esi+0x10]
0x452A3F         E8 2C 79 2A 00          call    0x6FA370-0x452A3F-1         # zCPar_SymbolTable::GetSymbol(zSTRING const &)
0x452A44         85 C0                   test    eax, eax
0x452A46         89 C5                   mov     ebp, eax
0x452A48         0F 85 32 1F 2A 00       jnz     0x6F4980-0x452A48-2         # back_1
0x452A4E         68 AE 05 00 00          push    0x5AE
0x452A53         E9 FB 1E 2A 00          jmp     0x6F4953-0x452A53-1         # back_2


0x452A58         90 90 90 90 90 90       nop nop nop nop nop nop


loc_linker_replace_func:

0x452A5E   0A8   51                      push    ecx                         # symbol
0x452A5F   0AC   50                      push    eax                         # Calculated stack position
0x452A60   0B0   8B 41 18                mov     eax, [ecx+0x18]             # symbol->content
0x452A63   0B0   85 C0                   test    eax, eax
0x452A65   0B0   74 66                   jz      short loc_rf_back

0x452A67   0B0   50                      push    eax                         # symbol->content
0x452A68   0B4   55                      push    ebp                         # parser
0x452A69   0B8   8B 69 08                mov     ebp, [ecx+8]                # symbol->name->ptr

0x452A6C   0B8   68 C8 2B 45 00          push    0x452BC8                    # offset CHAR_REPEAT
0x452A71   0BC   55                      push    ebp
0x452A72   0C0   FF 15 C4 02 7D 00       call    ds:0x7D02C4                 # lstrcmpiA(LPCSTR,LPCSTR)
0x452A78   0B8   85 C0                   test    eax, eax
0x452A7A   0B8   74 5F                   jz      short loc_no_rf_back
0x452A7C   0B8   68 CF 2B 45 00          push    0x452BCF                    # offset CHAR_WHILE
0x452A81   0BC   55                      push    ebp
0x452A82   0C0   FF 15 C4 02 7D 00       call    ds:0x7D02C4                 # lstrcmpiA(LPCSTR,LPCSTR)
0x452A88   0B8   85 C0                   test    eax, eax
0x452A8A   0B8   74 4F                   jz      short loc_no_rf_back
0x452A8C   0B8   68 D5 2B 45 00          push    0x452BD5                    # offset CHAR_MEM_LABEL
0x452A91   0BC   55                      push    ebp
0x452A92   0C0   FF 15 C4 02 7D 00       call    ds:0x7D02C4                 # lstrcmpiA(LPCSTR,LPCSTR)
0x452A98   0B8   85 C0                   test    eax, eax
0x452A9A   0B8   74 3F                   jz      short loc_no_rf_back
0x452A9C   0B8   68 DF 2B 45 00          push    0x452BDF                    # offset CHAR_MEM_GOTO
0x452AA1   0BC   55                      push    ebp
0x452AA2   0C0   FF 15 C4 02 7D 00       call    ds:0x7D02C4                 # lstrcmpiA(LPCSTR,LPCSTR)
0x452AA8   0B8   85 C0                   test    eax, eax
0x452AAA   0B8   74 2F                   jz      short loc_no_rf_back

0x452AAC   0B8   8B 2C 24                mov     ebp, [esp+0xF4-0xF4]        # parser
0x452AAF   0B4   8B 4D 48                mov     ecx, [ebp+0x48]             # parser->stackPos
0x452AB2   0B8   8B 44 24 04             mov     eax, [esp+0xF4-0xF0]        # symbol->content
0x452AB6   0B8   80 3C 08 3C             cmp     BYTE PTR [eax+ecx*1], 0x3C  # zPAR_TOK_RET
0x452ABA   0B8   74 1F                   jz      short loc_no_rf_back

0x452ABC   0B8   5D                      pop     ebp                         # parser
0x452ABD   0B4   8B 4D 48                mov     ecx, [ebp+0x48]             # parser->stackPos
0x452AC0   0B4   58                      pop     eax                         # symbol->content
0x452AC1   0B0   01 C8                   add     eax, ecx
0x452AC3   0B0   59                      pop     ecx                         # Calculated stack position
0x452AC4   0AC   C6 00 4B                mov     BYTE PTR [eax], 0x4B        # zPAR_TOK_JUMP
0x452AC7   0AC   89 48 01                mov     [eax+1], ecx
0x452ACA   0AC   83 EC 04                sub     esp, 4

loc_rf_back:

0x452ACD   0B0   83 C4 04                add     esp, 4
0x452AD0   0AC   59                      pop     ecx
0x452AD1   0A8   E8 4A 5A 2A 00          call    0x6F8520-0x452AD1-1         # zCPar_Symbol::SetStackPos(int,int)
0x452AD6   0A0   E9 8E 57 29 00          jmp     0x6E8269-0x452AD6-1         # back

loc_no_rf_back:

0x452ADB   0B8   83 C4 18                add     esp, 0x18
0x452ADE   0A0   E9 86 57 29 00          jmp     0x6E8269-0x452ADE-1         # back


0x452AE3         90 90 90 90 90 90       nop nop nop nop nop nop


loc_parser_check_var:

0x452AE9   394   8B 86 D4 10 00 00       mov     eax, DWORD PTR [esi+0x10D4] # parser->in_func->name
0x452AEF   394   85 C0                   test    eax, eax
0x452AF1   394   75 1A                   jnz     short loc_sub_var
0x452AF3   394   8B 86 D8 10 00 00       mov     eax, DWORD PTR [esi+0x10D8] # parser->in_class->name
0x452AF9   394   85 C0                   test    eax, eax
0x452AFB   394   75 10                   jnz     short loc_sub_var
0x452AFD   394   8D 4C 24 40             lea     ecx, [esp+0x394-0x354]      # Variable name
0x452B01   394   51                      push    ecx
0x452B02   398   89 F1                   mov     ecx, esi
0x452B04   398   E8 17 7A 29 00          call    0x6EA520-0x452B04-1         # zCParser::GetSymbol(zSTRING const &)
0x452B09   394   89 C7                   mov     edi, eax
0x452B0B   394   EB 37                   jmp     short loc_check_sym

loc_sub_var:

0x452B0D   394   83 EC 14                sub     esp, 0x14
0x452B10   3A8   68 B4 AF 82 00          push    0x82AFB4                    # offset str__0 "(dot)"
0x452B15   3AC   50                      push    eax                         # Prefix (function or class name)
0x452B16   3B0   8D 44 24 08             lea     eax, [esp+0x3B0-0x3A8]      # New string
0x452B1A   3B0   50                      push    eax
0x452B1B   4B4   E8 20 1C FB FF          call    0x404740-0x452B1B-1         # operator+(zSTRING const &,char const *)
0x452B20   4B4   83 C4 0C                add     esp, 0xC
0x452B23   3A8   8B 4C 24 5C             mov     ecx, [esp+0x3A8-0x34C]      # Variable name
0x452B27   3A8   51                      push    ecx
0x452B28   3AC   89 C1                   mov     ecx, eax
0x452B2A   3AC   E8 A1 23 1F 00          call    0x644ED0-0x452B2A-1         # zSTRING::operator+=(char const *)
0x452B2F   3A8   51                      push    ecx                         # Prefix_variableName
0x452B30   3AC   89 F1                   mov     ecx, esi
0x452B32   3AC   E8 E9 79 29 00          call    0x6EA520-0x452B32-1         # zCParser::GetSymbol(zSTRING const &)
0x452B37   3A8   89 C7                   mov     edi, eax
0x452B39   3A8   8D 0C 24                lea     ecx, [esp+0x3A8-0x3A8]      # New string
0x452B3C   3A8   E8 1F E7 FA FF          call    0x401260-0x452B3C-1         # zSTRING::~zSTRING(void)
0x452B41   3A8   83 C4 14                add     esp, 0x14

loc_check_sym:

0x452B44   394   85 FF                   test    edi, edi
0x452B46   394   0F 85 B7 ED 29 00       jnz     0x6F1903-0x452B46-2         # back_2
0x452B4C   394   68 BA 03 00 00          push    0x3BA
0x452B51   398   E9 7C ED 29 00          jmp     0x6F18D2-0x452B51-1         # back_1


0x452B56         90 90 90 90 90 90       nop nop nop nop nop nop


loc_parser_check_class:

0x452B5C   05C   8D 4C 24 28             lea     ecx, [esp+0x5C-0x34]
0x452B60   05C   51                      push    ecx
0x452B61   060   8D 4E 10                lea     ecx, [esi+0x10]
0x452B64   060   E8 07 78 2A 00          call    0x6FA370-0x452B64-1         # zCPar_SymbolTable::GetSymbol(zSTRING const &)
0x452B69   05C   85 C0                   test    eax, eax
0x452B6B   05C   74 09                   jz      short loc_pcc_new
0x452B6D   05C   83 C4 10                add     esp, 0x10
0x452B70   04C   0F 85 CB FF 29 00       jnz     0x6F2B41-0x452B70-2         # back_1

loc_pcc_new:

0x452B76   05C   E8 65 C0 0F 00          call    0x54EBE0-0x452B76-1         # operator new(uint,char const *,char const *,int)
0x452B7B   05C   E9 A6 FF 29 00          jmp     0x6F2B26-0x452B7B-1         # back_2


0x452B80         90 90 90 90 90 90       nop nop nop nop nop nop


loc_parser_check_prototype:

0x452B86         8D 4C 24 28             lea     ecx, [esp+0xB8-0x90]
0x452B8A         51                      push    ecx
0x452B8B         8D 4E 10                lea     ecx, [esi+0x10]
0x452B8E         E8 DD 77 2A 00          call    0x6FA370-0x452B8E-1         # zCPar_SymbolTable::GetSymbol(zSTRING const &)
0x452B93         85 C0                   test    eax, eax
0x452B95         0F 85 4B 0B 2A 00       jnz     0x6F36E6-0x452B95-2         # back_1
0x452B9B         68 DF 04 00 00          push    0x4DF
0x452BA0         E9 12 0B 2A 00          jmp     0x6F36B7-0x452BA0-1         # back_2


0x452BA5         90 90 90 90 90 90       nop nop nop nop nop nop


loc_detour_netMessage_failed:

0x452BAB   23C   C7 44 24 24 00 00 00 00 mov     [esp+0x23C-0x218], 0
0x452BB3   23C   8B 6C 24 24             mov     ebp, [esp+0x23C-0x218]
0x452BB7   23C   E9 C0 F9 FF FF          jmp     0x45273F-0x452D7A-1


0x452BBC         90 90 90 90 90 90       nop nop nop nop nop nop
0x452BC2         90 90 90 90 90 90       nop nop nop nop nop nop



########
# Data #
########


0x452BC8/*0x07*/ 52 45 50 45 41 54 00                                                                                       // "REPEAT"                               CHAR_REPEAT[6+1]           char
0x452BCF/*0x06*/ 57 48 49 4C 45 00                                                                                          // "WHILE"                                CHAR_WHILE[5+1]            char
0x452BD5/*0x0A*/ 4D 45 4D 5F 4C 41 42 45 4C 00                                                                              // "MEM_LABEL"                            CHAR_MEM_LABEL[9+1]        char
0x452BDF/*0x09*/ 4D 45 4D 5F 47 4F 54 4F 00                                                                                 // "MEM_GOTO"                             CHAR_MEM_GOTO[8+1]         char
0x452BE8/*0x0E*/ 5C 4E 49 4E 4A 41 5C 4D 55 53 49 43 5F 00                                                                  // "\NINJA\MUSIC_"                        NINJA_PATH_MUSIC[13+1]     char
0x452BF6/*0x0C*/ 5C 4E 49 4E 4A 41 5C 53 46 58 5F 00                                                                        // "\NINJA\SFX_"                          NINJA_PATH_SFX[11+1]       char
0x452C02/*0x0C*/ 5C 4E 49 4E 4A 41 5C 50 46 58 5F 00                                                                        // "\NINJA\PFX_"                          NINJA_PATH_PFX[11+1]       char
0x452C0E/*0x0C*/ 5C 4E 49 4E 4A 41 5C 56 46 58 5F 00                                                                        // "\NINJA\VFX_"                          NINJA_PATH_VFX[11+1]       char
0x452C1A/*0x10*/ 5C 4E 49 4E 4A 41 5C 43 4F 4E 54 45 4E 54 5F 00                                                            // "\NINJA\CONTENT_"                      NINJA_PATH_CONTENT[15+1]   char
0x452C2A/*0x0E*/ 5C 4E 49 4E 4A 41 5C 46 49 47 48 54 5F 00                                                                  // "\NINJA\FIGHT_"                        NINJA_PATH_FIGHT[13+1]     char
0x452C38/*0x0D*/ 5C 4E 49 4E 4A 41 5C 4D 45 4E 55 5F 00                                                                     // "\NINJA\MENU_"                         NINJA_PATH_MENU[12+1]      char
0x452C45/*0x0F*/ 5C 4E 49 4E 4A 41 5C 43 41 4D 45 52 41 5F 00                                                               // "\NINJA\CAMERA_"                       NINJA_PATH_CAMERA[14+1]    char
0x452C54/*0x12*/ 5C 4E 49 4E 4A 41 5C 41 4E 49 4D 41 54 49 4F 4E 5F 00                                                      // "\NINJA\ANIMATION_"                    NINJA_PATH_ANIMATION[17+1] char
0x452C66/*0x11*/ 44 41 54 41 5C 4E 49 4E 4A 41 5F 2A 2E 56 44 46 00                                                         // "DATA\NINJA_*.VDF"                     NINJA_PATH_VDF[16+1]       char
0x452C77/*0x23*/ 4A 3A 20 4D 44 53 3A 20 41 70 70 65 6E 64 69 6E 67 20 61 6E 69 6D 61 74 69 6F 6E 73 20 66 72 6F 6D 20 00   // "J: MDS: Appending animations from "   NINJA_LOAD_ANIM[34+1]      char


0x452C9A         90 90 90 90 90 90       nop nop nop nop nop nop

# # #


loc_skip:

0x4530B2   23C   8B 8C 24 40 02 00 00    mov     ecx, [esp+0x23C+4]          # Untouched



loc_detour_netMessage_failed_hook:

0x452726         81 04                   # 0x452BAB-0x452724-2               # loc_detour_netMessage_failed
