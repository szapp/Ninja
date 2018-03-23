# Third location: executing code continued and data


# Parsers in order:
# - Music:               zCParser * zCMusicSys_DirectMusic::musicParser     0x8D2140
# - SFX:                 zCParser * zCSndSys_MSS::sfxParser                 0x8D2A64
# - PFX:                 zCParser * zCParticleFX::s_pfxParser               0x8D9234
# - VFX:                 zCParser * oCVisualFX::fxParser                    0x8CE6EC
# - Content:             zCParser parser                                    0xAB40C0 (offset)
# - FightAI:             [temporary parser]                                 ebx
# - Menu:                zCParser * zCMenu::menuParser                      0x8D1E68
# Later: on game init
# - Camera:              zCParser * zCAICamera::cameraParser                0x8CEAC8



# Jump from 0x457791 to 0x4580AE
# Gives about 2327 "free" (unused) bytes


loc_start:

0x457791         90                      nop
0x457792         E9 17 09 00 00          jmp     loc_skip                    # 0x4580AE-0x457792-1


loc_deploy_music_ninja:

0x457797         60                      pusha
0x457798         68 1F 8C 40 00          push    0x408C1F                    # offset ninja_mergeSrc(char *)
0x45779D         68 0A 7B 45 00          push    0x457B0A                    # offset NINJA_PATH_MUSIC
0x4577A2         A1 40 21 8D 00          mov     eax, ds:0x8D2140            # zCParser * zCMusicSys_DirectMusic::musicParser
0x4577A7         50                      push    eax
0x4577A8         E8 B2 14 FB FF          call    0x408C5F-0x4577A8-1         # ninja_inject(zCParser *,char *,void (__stdcall *)(char *))
0x4577AD         61                      popa
0x4577AE         8D 54 24 13             lea     edx, [esp+0x0C8-0xB5]
0x4577B2         52                      push    edx
0x4577B3         E9 A9 FE 08 00          jmp     0x4E7661-0x4577B3-1         # back


0x4577B8         90 90 90 90 90 90       nop nop nop nop nop nop


loc_deploy_sfx_ninja:

0x4577BE         60                      pusha
0x4577BF         68 1F 8C 40 00          push    0x408C1F                    # offset ninja_mergeSrc(char *)
0x4577C4         68 18 7B 45 00          push    0x457B18                    # offset NINJA_PATH_SFX
0x4577C9         A1 64 2A 8D 00          mov     eax, ds:0x8D2A64            # zCParser * zCSndSys_MSS::sfxParser
0x4577CE         50                      push    eax
0x4577CF         E8 8B 14 FB FF          call    0x408C5F-0x4577CF-1         # ninja_inject(zCParser *,char *,void (__stdcall *)(char *))
0x4577D4         61                      popa
0x4577D5         8D 44 24 12             lea     eax, [esp+0x308-0x2F6]
0x4577D9         50                      push    eax
0x4577DA         E9 B1 36 09 00          jmp     0x4EAE90-0x4577DA-1         # back


0x4577DF         90 90 90 90 90 90       nop nop nop nop nop nop


loc_deploy_pfx_ninja:

0x4577E5         60                      pusha
0x4577E6         68 1F 8C 40 00          push    0x408C1F                    # offset ninja_mergeSrc(char *)
0x4577EB         68 24 7B 45 00          push    0x457B24                    # offset NINJA_PATH_PFX
0x4577F0         A1 34 92 8D 00          mov     eax, ds:0x8D9234            # zCParser * zCParticleFX::s_pfxParser
0x4577F5         50                      push    eax
0x4577F6         E8 64 14 FB FF          call    0x408C5F-0x4577F6-1         # ninja_inject(zCParser *,char *,void (__stdcall *)(char *))
0x4577FB         61                      popa
0x4577FC         8D 44 24 13             lea     eax, [esp+0x0C8-0xB5]
0x457800         50                      push    eax
0x457801         E9 BB 4F 15 00          jmp     0x5AC7C1-0x457801-1         # back


0x457806         90 90 90 90 90 90       nop nop nop nop nop nop


loc_deploy_vfx_ninja:

0x45780C         60                      pusha
0x45780D         68 1F 8C 40 00          push    0x408C1F                    # offset ninja_mergeSrc(char *)
0x457812         68 30 7B 45 00          push    0x457B30                    # offset NINJA_PATH_VFX
0x457817         A1 EC E6 8C 00          mov     eax, ds:0x8CE6EC            # zCParser * oCVisualFX::fxParser
0x45781C         50                      push    eax
0x45781D         E8 3D 14 FB FF          call    0x408C5F-0x45781D-1         # ninja_inject(zCParser *,char *,void (__stdcall *)(char *))
0x457822         61                      popa
0x457823         8D 44 24 1B             lea     eax, [esp+0x250-0x235]
0x457827         50                      push    eax
0x457828         E9 C7 3E 03 00          jmp     0x48B6F4-0x457828-1         # back


0x45782D         90 90 90 90 90 90       nop nop nop nop nop nop


loc_deploy_content_ninja:

0x457833         60                      pusha
0x457834         68 1F 8C 40 00          push    0x408C1F                    # offset ninja_mergeSrc(char *)
0x457839         68 3C 7B 45 00          push    0x457B3C                    # offset NINJA_PATH_CONTENT
0x45783E         68 C0 40 AB 00          push    0xAB40C0                    # offset zCParser parser
0x457843         E8 17 14 FB FF          call    0x408C5F-0x457843-1         # ninja_inject(zCParser *,char *,void (__stdcall *)(char *))
0x457848         61                      popa
0x457849         6A 01                   push    1
0x45784B         8D 4C 24 68             lea     ecx, [esp+0x84-0x1C]
0x45784F         E9 52 9A 26 00          jmp     0x6C12A6-0x45784F-1         # back


0x457854         90 90 90 90 90 90       nop nop nop nop nop nop


loc_deploy_fightai_ninja:

0x45785A         60                      pusha
0x45785B         68 1F 8C 40 00          push    0x408C1F                    # offset ninja_mergeSrc(char *)
0x457860         68 4C 7B 45 00          push    0x457B4C                    # offset NINJA_PATH_FIGHT
0x457865         53                      push    ebx
0x457866         E8 F4 13 FB FF          call    0x408C5F-0x457866-1         # ninja_inject(zCParser *,char *,void (__stdcall *)(char *))
0x45786B         61                      popa
0x45786C         8D 44 24 13             lea     eax, [esp+0x64-0x51]
0x457870         50                      push    eax
0x457871         E9 B5 4D 22 00          jmp     0x67C62B-0x457871-1         # back


0x457876         90 90 90 90 90 90       nop nop nop nop nop nop


loc_deploy_menu_ninja:

0x45787C         60                      pusha
0x45787D         68 1F 8C 40 00          push    0x408C1F                    # offset ninja_mergeSrc(char *)
0x457882         68 5A 7B 45 00          push    0x457B5A                    # offset NINJA_PATH_MENU
0x457887         A1 68 1E 8D 00          mov     eax, ds:0x8D1E68            # eax, zCParser * zCMenu::menuParser
0x45788C         50                      push    eax
0x45788D         E8 CD 13 FB FF          call    0x408C5F-0x45788D-1         # ninja_inject(zCParser *,char *,void (__stdcall *)(char *))
0x457892         61                      popa
0x457893         A1 3C B0 99 00          mov     eax, ds:0x99B03C            # zCSoundSystem * zsound
0x457898         E9 FE 28 08 00          jmp     0x4DA19B-0x457898-1         # back


0x45789D         90 90 90 90 90 90       nop nop nop nop nop nop


loc_deploy_camera_ninja:

0x4578A3         60                      pusha
0x4578A4         68 1F 8C 40 00          push    0x408C1F                    # offset ninja_mergeSrc(char *)
0x4578A9         68 67 7B 45 00          push    0x457B67                    # offset NINJA_PATH_CAMERA
0x4578AE         A1 C8 EA 8C 00          mov     eax, ds:0x8CEAC8            # zCParser * zCAICamera::cameraParser
0x4578B3         50                      push    eax
0x4578B4         E8 A6 13 FB FF          call    0x408C5F-0x4578B4-1         # ninja_inject(zCParser *,char *,void (__stdcall *)(char *))
0x4578B9         61                      popa
0x4578BA         8D 54 24 13             lea     edx, [esp+0x0B8-0xA5]
0x4578BE         52                      push    edx
0x4578BF         E9 95 8C 04 00          jmp     0x4A0559-0x4578BF-1         # back


0x4578C4         90 90 90 90 90 90       nop nop nop nop nop nop


loc_init_menu:

0x4578CA         60                      pusha
0x4578CB         68 BB 8B 40 00          push    0x408BBB                    # offset ninja_initMenu(char *)
0x4578D0         68 3C 7B 45 00          push    0x457B3C                    # offset NINJA_PATH_CONTENT
0x4578D5         68 C0 40 AB 00          push    0xAB40C0                    # offset zCParser parser
0x4578DA         E8 80 13 FB FF          call    0x408C5F-0x4578DA-1         # ninja_inject(zCParser *,char *,void (__stdcall *)(char *))
0x4578DF         61                      popa
0x4578E0         5D                      pop     ebp
0x4578E1         8B 4C 24 1C             mov     ecx, [esp+0x28-0xC]
0x4578E5         E9 1A 3C 08 00          jmp     0x4DB504-0x4578E5-1         # back


0x4578EA         90 90 90 90 90 90       nop nop nop nop nop nop


loc_init_content:

0x4578F0         60                      pusha
0x4578F1         68 5B 8B 40 00          push    0x408B5B                    # offset ninja_initContent(char *)
0x4578F6         68 3C 7B 45 00          push    0x457B3C                    # offset NINJA_PATH_CONTENT
0x4578FB         68 C0 40 AB 00          push    0xAB40C0                    # offset zCParser parser
0x457900         E8 5A 13 FB FF          call    0x408C5F-0x457900-1         # ninja_inject(zCParser *,char *,void (__stdcall *)(char *))
0x457905         61                      popa
0x457906         83 C4 08                add     esp, 8
0x457909         85 C0                   test    eax, eax
0x45790B         E9 B8 A7 26 00          jmp     0x6C20C8-0x45790B-1         # back


0x457910         90 90 90 90 90 90       nop nop nop nop nop nop


loc_init_anims:

0x457916         60                      pusha
0x457917         8B 6C 24 44             mov     ebp, [esp+0x4BC-0x478]      # zCModelPrototype *
0x45791B         68 B0 10 41 00          push    0x4110B0                    # offset ninja_initAnims(char *)
0x457920         68 76 7B 45 00          push    0x457B76                    # offset NINJA_PATH_ANIMATION
0x457925         E8 F8 10 FB FF          call    0x408A22-0x457925-1         # ninja_findVdfSrc(char *,void (__stdcall *)(char *))
0x45792A         61                      popa
0x45792B         8B 84 24 BC 00 00 00    mov     eax, [esp+0x49C-0x3E0]
0x457932         E9 9D E8 13 00          jmp     0x5961D4-0x457932-1         # back

0x457937         90 90 90 90 90          nop nop nop nop nop


loc_parser_check_func:

0x45793C         8D 4C 24 28             lea     ecx, [esp+0xA4-0x7C]
0x457940         51                      push    ecx
0x457941         8D 4E 10                lea     ecx, [esi+0x10]
0x457944         E8 F7 C4 34 00          call    0x7A3E40-0x457944-1         # zCPar_SymbolTable::GetSymbol(zSTRING const &)
0x457949         85 C0                   test    eax, eax
0x45794B         89 C5                   mov     ebp, eax
0x45794D         0F 85 7E 68 34 00       jnz     0x79E1D1-0x45794D-2         # back_1

0x457953         6A 3C                   push    0x3C
0x457955         E8 F6 E5 10 00          call    0x565F50-0x457955-1         # operator new(uint)
0x45795A         E9 56 68 34 00          jmp     0x79E1B5-0x45795A-1         # back_2


0x45795F         90 90 90 90 90 90       nop nop nop nop nop nop
0x457965         90                      nop


loc_linker_replace_func:

0x457966   0E4   51                      push    ecx                         # symbol
0x457967   0E8   50                      push    eax                         # Calculated stack position
0x457968   0EC   8B 41 18                mov     eax, [ecx+0x18]             # symbol->content
0x45796B   0EC   85 C0                   test    eax, eax
0x45796D   0EC   74 66                   jz      short loc_rf_back

0x45796F   0EC   50                      push    eax                         # symbol->content
0x457970   0F0   55                      push    ebp                         # parser
0x457971   0F4   8B 69 08                mov     ebp, [ecx+8]                # symbol->name->ptr

0x457974   0F4   68 EA 7A 45 00          push    0x457AEA                    # offset CHAR_REPEAT
0x457979   0F8   55                      push    ebp
0x45797A   0FC   FF 15 74 E1 82 00       call    ds:0x82E174                 # lstrcmpiA(LPCSTR,LPCSTR)
0x457980   0F4   85 C0                   test    eax, eax
0x457982   0F4   74 5F                   jz      short loc_no_rf_back
0x457984   0F4   68 F1 7A 45 00          push    0x457AF1                    # offset CHAR_WHILE
0x457989   0F8   55                      push    ebp
0x45798A   0FC   FF 15 74 E1 82 00       call    ds:0x82E174                 # lstrcmpiA(LPCSTR,LPCSTR)
0x457990   0F4   85 C0                   test    eax, eax
0x457992   0F4   74 4F                   jz      short loc_no_rf_back
0x457994   0F4   68 F7 7A 45 00          push    0x457AF7                    # offset CHAR_MEM_LABEL
0x457999   0F8   55                      push    ebp
0x45799A   0FC   FF 15 74 E1 82 00       call    ds:0x82E174                 # lstrcmpiA(LPCSTR,LPCSTR)
0x4579A0   0F4   85 C0                   test    eax, eax
0x4579A2   0F4   74 3F                   jz      short loc_no_rf_back
0x4579A4   0F4   68 01 7B 45 00          push    0x457B01                    # offset CHAR_MEM_GOTO
0x4579A9   0F8   55                      push    ebp
0x4579AA   0FC   FF 15 74 E1 82 00       call    ds:0x82E174                 # lstrcmpiA(LPCSTR,LPCSTR)
0x4579B0   0F4   85 C0                   test    eax, eax
0x4579B2   0F4   74 2F                   jz      short loc_no_rf_back

0x4579B4   0F4   8B 2C 24                mov     ebp, [esp+0xF4-0xF4]        # parser
0x4579B7   0F0   8B 4D 48                mov     ecx, [ebp+0x48]             # parser->stackPos
0x4579BA   0F4   8B 44 24 04             mov     eax, [esp+0xF4-0xF0]        # symbol->content
0x4579BE   0F4   80 3C 08 3C             cmp     BYTE PTR [eax+ecx*1], 0x3C  # zPAR_TOK_RET
0x4579C2   0F4   74 1F                   jz      short loc_no_rf_back

0x4579C4   0F4   5D                      pop     ebp                         # parser
0x4579C5   0F0   8B 4D 48                mov     ecx, [ebp+0x48]             # parser->stackPos
0x4579C8   0F0   58                      pop     eax                         # symbol->content
0x4579C9   0EC   01 C8                   add     eax, ecx
0x4579CB   0EC   59                      pop     ecx                         # Calculated stack position
0x4579CC   0E8   C6 00 4B                mov     BYTE PTR [eax], 0x4B        # zPAR_TOK_JUMP
0x4579CF   0E8   89 48 01                mov     [eax+1], ecx
0x4579D2   0E8   83 EC 04                sub     esp, 4

loc_rf_back:

0x4579D5   0EC   83 C4 04                add     esp, 4
0x4579D8   0E8   59                      pop     ecx
0x4579D9   0E4   E8 42 A4 34 00          call    0x7A1E20-0x4579D9-1         # zCPar_Symbol::SetStackPos(int,int)
0x4579DE   0DC   E9 E9 9B 33 00          jmp     0x7915CC-0x4579DE-1         # back

loc_no_rf_back:

0x4579E3   0F4   83 C4 18                add     esp, 0x18
0x4579E6   0DC   E9 E1 9B 33 00          jmp     0x7915CC-0x4579E6-1         # back



loc_parser_check_var:

0x4579EB   3EC   8B 86 D4 20 00 00       mov     eax, DWORD PTR [esi+0x20D4] # parser->in_func->name
0x4579F1   3EC   85 C0                   test    eax, eax
0x4579F3   3EC   75 1A                   jnz     loc_sub_var
0x4579F5   3EC   8B 86 D8 20 00 00       mov     eax, DWORD PTR [esi+0x20D8] # parser->in_class->name
0x4579FB   3EC   85 C0                   test    eax, eax
0x4579FD   3EC   75 10                   jnz     loc_sub_var
0x4579FF   3EC   8D 4C 24 30             lea     ecx, [esp+0x3EC-0x3BC]      # Variable name
0x457A03   3EC   51                      push    ecx
0x457A04   3F0   89 F1                   mov     ecx, esi
0x457A06   3F0   E8 C5 BE 33 00          call    0x7938D0-0x457A06-1         # zCParser::GetSymbol(zSTRING const &)
0x457A0B   3EC   89 C5                   mov     ebp, eax
0x457A0D   3EC   EB 3E                   jmp     loc_check_sym

loc_sub_var:

0x457A0F   3EC   83 EC 14                sub     esp, 0x14
0x457A12   400   68 E4 F1 88 00          push    0x88F1E4                    # offset str__0 "(dot)"
0x457A17   404   50                      push    eax                         # Prefix (function or class name)
0x457A18   408   8D 44 24 08             lea     eax, [esp+0x408-0x400]      # New string
0x457A1C   408   90                      nop
0x457A1D   408   90                      nop
0x457A1E   408   90                      nop
0x457A1F   408   50                      push    eax
0x457A20   40C   E8 5B CE FA FF          call    0x404880-0x457A20-1         # operator+(zSTRING const &,char const *)
0x457A25   40C   83 C4 0C                add     esp, 0xC
0x457A28   400   8B 4C 24 4C             mov     ecx, DWORD PTR [esp+0x400-0x3B4] # Variable name
0x457A2C   400   51                      push    ecx
0x457A2D   404   89 C1                   mov     ecx, eax
0x457A2F   404   E8 7C 2D 22 00          call    0x67A7B0-0x457A2F-1         # zSTRING::operator+=(char const *)
0x457A34   400   51                      push    ecx                         # Prefix.variableName
0x457A35   404   89 F1                   mov     ecx, esi
0x457A37   404   E8 94 BE 33 00          call    0x7938D0-0x457A37-1         # zCParser::GetSymbol(zSTRING const &)
0x457A3C   400   89 C5                   mov     ebp, eax
0x457A3E   400   8D 0C 24                lea     ecx, [esp+0x400-0x400]      # New string
0x457A41   400   90                      nop
0x457A42   400   90                      nop
0x457A43   400   90                      nop
0x457A44   400   90                      nop
0x457A45   400   E8 16 97 FA FF          call    0x401160-0x457A45-1         # zSTRING::~zSTRING(void)
0x457A4A   400   83 C4 14                add     esp, 0x14

loc_check_sym:

0x457A4D   3EC   85 ED                   test    ebp, ebp
0x457A4F   3EC   0F 85 87 39 34 00       jnz     0x79B3DC-0x457A4F-2         # back_2
0x457A55   3EC   6A 3C                   push    0x3C
0x457A57   3F0   E8 F4 E4 10 00          call    0x565F50-0x457A53-1         # operator new(uint)
0x457A5C   3F0   E9 5B 39 34 00          jmp     0x79B3BC-0x457A58-1         # back_1

0x457A61         90 90 90 90 90 90       nop nop nop nop nop nop
0x457A67         90 90 90 90 90 90       nop nop nop nop nop nop
0x457A6D         90 90 90 90 90 90       nop nop nop nop nop nop
0x457A73         90 90 90 90 90 90       nop nop nop nop nop nop
0x457A79         90 90 90 90 90 90       nop nop nop nop nop nop
0x457A7F         90 90 90 90 90 90       nop nop nop nop nop nop


loc_parser_check_class:

0x457A85         59                      pop     ecx
0x457A86         8D 4C 24 18             lea     ecx, [esp+0x4C-0x34]
0x457A8A         51                      push    ecx
0x457A8B         8D 4E 10                lea     ecx, [esi+0x10]
0x457A8E         E8 AD C3 34 00          call    0x7A3E40-0x457A8E-1         # zCPar_SymbolTable::GetSymbol(zSTRING const &)
0x457A93         85 C0                   test    eax, eax
0x457A95         0F 85 B7 49 34 00       jnz     0x79C452-0x457A95-2         # back_1

0x457A9B         6A 3C                   push    0x3C
0x457A9D         E8 AE E4 10 00          call    0x565F50-0x457A9D-1         # operator new(uint)
0x457AA2         E9 90 49 34 00          jmp     0x79C437-0x457AA2-1         # back_2


0x457AA7         90 90 90 90 90          nop nop nop nop nop


loc_parser_check_prototype:

0x457AAC         8D 4C 24 28             lea     ecx, [esp+0xB8-0x90]
0x457AB0         51                      push    ecx
0x457AB1         8D 4E 10                lea     ecx, [esi+0x10]
0x457AB4         E8 87 C3 34 00          call    0x7A3E40-0x457AB4-1         # zCPar_SymbolTable::GetSymbol(zSTRING const &)
0x457AB9         85 C0                   test    eax, eax
0x457ABB         0F 85 D6 54 34 00       jnz     0x79CF97-0x457ABB-2         # back_1

0x457AC1         6A 3C                   push    0x3C
0x457AC3         E8 88 E4 10 00          call    0x565F50-0x457AC3-1         # operator new(uint)
0x457AC8         E9 AC 54 34 00          jmp     0x79CF79-0x457AC8-1         # back_2


0x457ACD         90 90 90 90 90 90       nop nop nop nop nop nop


loc_detour_netMessage_failed:

0x457AD3   2D8   89 5C 24 24             mov     [esp+0x2D8-0x2B4], ebx
0x457AD7   2D8   8B F3                   mov     esi, ebx
0x457AD9   2D8   E9 DB FA FF FF          jmp     0x4575B9-0x457AD9-1


0x457ADE         90 90 90 90 90 90       nop nop nop nop nop nop
0x457AE4         90 90 90 90 90 90       nop nop nop nop nop nop



########
# Data #
########


0x457AEA/*0x07*/ 52 45 50 45 41 54 00                                                                                       // "REPEAT"                               CHAR_REPEAT[6+1]           char
0x457AF1/*0x06*/ 57 48 49 4C 45 00                                                                                          // "WHILE"                                CHAR_WHILE[5+1]            char
0x457AF7/*0x0A*/ 4D 45 4D 5F 4C 41 42 45 4C 00                                                                              // "MEM_LABEL"                            CHAR_MEM_LABEL[9+1]        char
0x457B01/*0x09*/ 4D 45 4D 5F 47 4F 54 4F 00                                                                                 // "MEM_GOTO"                             CHAR_MEM_GOTO[8+1]         char
0x457B0A/*0x0E*/ 5C 4E 49 4E 4A 41 5C 4D 55 53 49 43 5F 00                                                                  // "\NINJA\MUSIC_"                        NINJA_PATH_MUSIC[13+1]     char
0x457B18/*0x0C*/ 5C 4E 49 4E 4A 41 5C 53 46 58 5F 00                                                                        // "\NINJA\SFX_"                          NINJA_PATH_SFX[11+1]       char
0x457B24/*0x0C*/ 5C 4E 49 4E 4A 41 5C 50 46 58 5F 00                                                                        // "\NINJA\PFX_"                          NINJA_PATH_PFX[11+1]       char
0x457B30/*0x0C*/ 5C 4E 49 4E 4A 41 5C 56 46 58 5F 00                                                                        // "\NINJA\VFX_"                          NINJA_PATH_VFX[11+1]       char
0x457B3C/*0x10*/ 5C 4E 49 4E 4A 41 5C 43 4F 4E 54 45 4E 54 5F 00                                                            // "\NINJA\CONTENT_"                      NINJA_PATH_CONTENT[15+1]   char
0x457B4C/*0x0E*/ 5C 4E 49 4E 4A 41 5C 46 49 47 48 54 5F 00                                                                  // "\NINJA\FIGHT_"                        NINJA_PATH_FIGHT[13+1]     char
0x457B5A/*0x0D*/ 5C 4E 49 4E 4A 41 5C 4D 45 4E 55 5F 00                                                                     // "\NINJA\MENU_"                         NINJA_PATH_MENU[12+1]      char
0x457B67/*0x0F*/ 5C 4E 49 4E 4A 41 5C 43 41 4D 45 52 41 5F 00                                                               // "\NINJA\CAMERA_"                       NINJA_PATH_CAMERA[14+1]    char
0x457B76/*0x12*/ 5C 4E 49 4E 4A 41 5C 41 4E 49 4D 41 54 49 4F 4E 5F 00                                                      // "\NINJA\ANIMATION_"                    NINJA_PATH_ANIMATION[17+1] char
0x457B88/*0x11*/ 44 41 54 41 5C 4E 49 4E 4A 41 5F 2A 2E 56 44 46 00                                                         // "DATA\NINJA_*.VDF"                     NINJA_PATH_VDF[16+1]       char
0x457B99/*0x23*/ 4A 3A 20 4D 44 53 3A 20 41 70 70 65 6E 64 69 6E 67 20 61 6E 69 6D 61 74 69 6F 6E 73 20 66 72 6F 6D 20 00   // "J: MDS: Appending animations from "   NINJA_LOAD_ANIM[34+1]      char


0x457BBC         90 90 90 90 90 90       nop nop nop nop nop nop



# # #


loc_skip:

0x4580AE   2D8   8B 8C 24 DC 02 00 00    mov     ecx, [esp+0x2D8+4]          # Untouched



loc_detour_netMessage_failed_hook:

0x45759E         31 05                   # 0x457AD3-0x45759C-2               # loc_detour_netMessage_failed
