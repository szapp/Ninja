# First location: functions


# Jump from 0x4087A9 to 0x408BCA
# Gives about 1050 "free" (unused) bytes

loc_start:

0x4087A9         E9 1C 04 00 00          jmp     loc_skip


# void __stdcall ninja_findVdfSrc(char *,void (__stdcall *)(char *))
#
#   fullname -0x23C   char[MAX_PATH+28]   0x120
#   filedata -0x11C   finddata_t          0x118
#   findhndl -4       HANDLE
#   arg1     +4       char *
#   arg2     +8       void (__stdcall *)(char *)
#

0x4087AE   000   81 EC 3C 02 00 00       sub     esp, 0x23C
0x4087B4   23C   50                      push    eax
0x4087B5   240   51                      push    ecx
0x4087B6   244   56                      push    esi
0x4087B7   248   57                      push    edi

0x4087B8   24C   8D B4 24 30 01 00 00    lea     esi, [esp+0x24C-0x11C]      # finddata_t
0x4087BF   24C   56                      push    esi
0x4087C0   250   68 66 2C 45 00          push    0x452C66                    # offset NINJA_PATH_VDF "\\DATA\\NINJA_*(dot)VDF"
0x4087C5   254   E8 9E 03 37 00          call    0x778B68-0x4087C5-1         # _findfirst(const char *,finddata_t *)
0x4087CA   254   83 C4 08                add     esp, 8
0x4087CD   24C   83 F8 FF                cmp     eax, 0xFFFFFFFF             # INVALID_HANDLE_VALUE
0x4087D0   24C   0F 84 B0 00 00 00       jz      loc_fvs_end
0x4087D6   24C   89 84 24 48 02 00 00    mov     [esp+0x24C-4], eax          # HANDLE

loc_fvs_fileLoopStart:

0x4087DD   24C   8D B4 24 44 01 00 00    lea     esi, [esp+0x24C-0x11C+0x14] # finddata_t->name
0x4087E4   24C   31 FF                   xor     edi, edi

loc_fvs_toUpper:

0x4087E6   24C   8A 04 3E                mov     al, BYTE PTR [esi+edi*1]
0x4087E9   24C   84 C0                   test    al, al
0x4087EB   24C   74 11                   jz      short loc_fvs_setExt

0x4087ED   24C   47                      inc     edi

0x4087EE   24C   3C 61                   cmp     al, 0x61
0x4087F0   24C   7C F4                   jl      short loc_fvs_toUpper
0x4087F2   24C   3C 7A                   cmp     al, 0x7A
0x4087F4   24C   7F F0                   jg      short loc_fvs_toUpper
0x4087F6   24C   2C 20                   sub     al, 0x20
0x4087F8   24C   88 44 3E FF             mov     BYTE PTR [esi+edi-1], al
0x4087FC   24C   EB E8                   jmp     short loc_fvs_toUpper

loc_fvs_setExt:

0x4087FE   24C   4F                      dec     edi
0x4087FF   24C   C6 04 3E 43             mov     BYTE PTR [esi+edi*1], 0x43  # "C"
0x408803   24C   4F                      dec     edi
0x408804   24C   C6 04 3E 52             mov     BYTE PTR [esi+edi*1], 0x52  # "R"
0x408808   24C   4F                      dec     edi
0x408809   24C   C6 04 3E 53             mov     BYTE PTR [esi+edi*1], 0x53  # "S"

0x40880D   24C   FF B4 24 50 02 00 00    push    [esp+0x24C+4]               # arg1, eg "\\NINJA\\CONTENT_", or "\\NINJA\\MENU_", etc
0x408814   250   8D 74 24 14             lea     esi, [esp+0x250-0x23C]      # fullname
0x408818   250   56                      push    esi
0x408819   254   FF 15 88 02 7D 00       call    ds:0x7D0288                 # lstrcpyA(LPTSTR,LPTSTR)
0x40881F   24C   8D B4 24 44 01 00 00    lea     esi, [esp+0x24C-0x11C+0x14] # finddata_t->name
0x408826   24C   56                      push    esi
0x408827   250   50                      push    eax
0x408828   254   FF 15 D8 02 7D 00       call    ds:0x7D02D8                 # lstrcatA(LPTSTR,LPTSTR)
0x40882E   24C   89 C6                   mov     esi, eax

0x408830   24C   E8 8B E9 03 00          call    0x4471C0-0x408830-1         # zFILE_VDFS::LockCriticalSection(void)
0x408835   24C   6A 07                   push    7                           # VDF_VIRTUAL | VDF_PHYSICAL | VDF_PHYSICALFIRST
0x408837   250   56                      push    esi                         # arg1 + finddata_t->name + ext
0x408838   254   FF 15 D0 04 7D 00       call    ds:0x7D04D0                 # vdf_fexists(const char*,long)
0x40883E   254   83 C4 08                add     esp, 8
0x408841   24C   50                      push    eax
0x408842   250   E8 99 E9 03 00          call    0x4471E0-0x408842-1         # zFILE_VDFS::UnlockCriticalSection(void)
0x408847   250   58                      pop     eax
0x408848   24C   85 C0                   test    eax, eax
0x40884A   24C   74 0C                   jz      short loc_fvs_nextfile

0x40884C   24C   8D 74 24 10             lea     esi, [esp+0x24C-0x23C]      # fullname
0x408850   24C   56                      push    esi
0x408851   250   FF 94 24 58 02 00 00    call    DWORD PTR [esp+0x250+8]     # arg2(char *)

loc_fvs_nextfile:

0x408858   24C   8D B4 24 30 01 00 00    lea     esi, [esp+0x24C-0x11C]      # finddata_t
0x40885F   24C   56                      push    esi
0x408860   250   FF B4 24 4C 02 00 00    push    [esp+0x250-4]               # HANDLE
0x408867   254   E8 C9 03 37 00          call    0x778C35-0x408867-1         # _findnext(int,_finddata_t *)
0x40886C   254   83 C4 08                add     esp, 8
0x40886F   24C   85 C0                   test    eax, eax
0x408871   24C   0F 84 66 FF FF FF       jz      loc_fvs_fileLoopStart

0x408877   24C   FF B4 24 48 02 00 00    push    [esp+0x24C-4]               # HANDLE
0x40887E   250   E8 7A 04 37 00          call    0x778CFD-0x40887E-1         # _findclose(int)
0x408883   250   83 C4 04                add     esp, 4

loc_fvs_end:

0x408886   24C   5F                      pop     edi
0x408887   248   5E                      pop     esi
0x408888   244   59                      pop     ecx
0x408889   240   58                      pop     eax
0x40888A   23C   81 C4 3C 02 00 00       add     esp, 0x23C
0x408890   000   C2 08 00                ret     8


0x408893         90 90 90 90 90 90       nop nop nop nop nop nop             # 6
0x408899         90 90 90 90 90 90       nop nop nop nop nop nop             # 12
0x40889F         90 90 90 90 90 90       nop nop nop nop nop nop             # 18
0x4088A5         90 90 90 90 90 90       nop nop nop nop nop nop             # 24
0x4088AB         90 90 90 90 90 90       nop nop nop nop nop nop             # 30
0x4088B1         90 90 90 90 90 90       nop nop nop nop nop nop             # 36
0x4088B7         90 90 90 90 90 90       nop nop nop nop nop nop             # 42
0x4088BD         90 90 90 90 90 90       nop nop nop nop nop nop             # 48
0x4088C3         90 90 90 90 90 90       nop nop nop nop nop nop             # 54
0x4088C9         90 90 90 90 90 90       nop nop nop nop nop nop             # 60
0x4088CF         90 90 90 90 90 90       nop nop nop nop nop nop             # 66
0x4088D5         90 90 90 90 90 90       nop nop nop nop nop nop             # 72
0x4088DB         90 90 90 90 90 90       nop nop nop nop nop nop             # 78
0x4088E1         90 90 90 90 90 90       nop nop nop nop nop nop             # 84


# void __stdcall ninja_initContent(char *)
#
# var1   -0x14 (zString)
#   a1   +4
#

0x4088E7   000   83 EC 14                sub     esp, 0x14
0x4088EA   014   50                      push    eax
0x4088EB   018   51                      push    ecx

0x4088EC   01C   FF 74 24 20             push    [esp+0x1C+4]
0x4088F0   020   FF 15 74 02 7D 00       call    ds:0x7D0274                 # lstrlenA(LPCSTR)

0x4088F6   01C   8B 4C 24 20             mov     ecx, [esp+0x1C+4]
0x4088FA   01C   40                      inc     eax                         # This works, because buffer is big enough
0x4088FB   01C   C6 04 08 00             mov     BYTE PTR [eax+ecx*1], 0     # NUL
0x4088FF   01C   48                      dec     eax
0x408900   01C   C6 04 08 54             mov     BYTE PTR [eax+ecx*1], 0x54  # "T"
0x408904   01C   48                      dec     eax
0x408905   01C   C6 04 08 49             mov     BYTE PTR [eax+ecx*1], 0x49  # "I"
0x408909   01C   48                      dec     eax
0x40890A   01C   C6 04 08 4E             mov     BYTE PTR [eax+ecx*1], 0x4E  # "N"
0x40890E   01C   48                      dec     eax
0x40890F   01C   C6 04 08 49             mov     BYTE PTR [eax+ecx*1], 0x49  # "I"
0x408913   01C   48                      dec     eax
0x408914   01C   C6 04 08 5F             mov     BYTE PTR [eax+ecx*1], 0x5F  # "_"
0x408918   01C   83 C1 0F                add     ecx, 0xF                    # Cut off "\\NINJA\\CONTENT_"
0x40891B   01C   51                      push    ecx
0x40891C   020   8D 4C 24 0C             lea     ecx, [esp+0x20-0x14]
0x408920   020   E8 7B 8A FF FF          call    0x4013A0-0x408920-1         # zSTRING::zSTRING(char const *)

0x408925   01C   51                      push    ecx
0x408926   020   B9 08 CE 8D 00          mov     ecx, 0x8DCE08               # offset zCParser parser
0x40892B   020   E8 40 0D 2E 00          call    0x6E9670-0x40892B-1         # zCParser::CallFunc(zSTRING const &)

0x408930   01C   8D 4C 24 08             lea     ecx, [esp+0x1C-0x14]
0x408934   01C   E8 27 89 FF FF          call    0x401260-0x408934-1         # zSTRING::~zSTRING(void)

0x408939   01C   59                      pop     ecx
0x40893A   018   58                      pop     eax
0x40893B   014   83 C4 14                add     esp, 0x14
0x40893E   000   C2 04 00                ret     4


0x408941         90 90 90 90 90 90       nop nop nop nop nop nop


# void __stdcall ninja_initMenu(char *)
#
# var1   -0x14 (zString)
#   a1   +4
#

0x408947   000   83 EC 14                sub     esp, 0x14
0x40894A   014   50                      push    eax
0x40894B   018   51                      push    ecx
0x40894C   01C   56                      push    esi

0x40894D   020   FF 74 24 24             push    [esp+0x20+4]
0x408951   024   FF 15 74 02 7D 00       call    ds:0x7D0274                 # lstrlenA(LPCSTR)

0x408957   020   8B 4C 24 24             mov     ecx, [esp+0x20+4]
0x40895B   01C   40                      inc     eax                         # This works, because buffer is big enough
0x40895C   020   C6 04 08 00             mov     BYTE PTR [eax+ecx*1], 0     # NUL
0x408960   020   48                      dec     eax
0x408961   020   C6 04 08 55             mov     BYTE PTR [eax+ecx*1], 0x55  # "U"
0x408965   020   48                      dec     eax
0x408966   020   C6 04 08 4E             mov     BYTE PTR [eax+ecx*1], 0x4E  # "N"
0x40896A   020   48                      dec     eax
0x40896B   020   C6 04 08 45             mov     BYTE PTR [eax+ecx*1], 0x45  # "E"
0x40896F   020   48                      dec     eax
0x408970   020   C6 04 08 4D             mov     BYTE PTR [eax+ecx*1], 0x4D  # "M"
0x408974   01C   48                      dec     eax
0x408975   01C   C6 04 08 5F             mov     BYTE PTR [eax+ecx*1], 0x5F  # "_"
0x408979   01C   83 C1 0F                add     ecx, 0xF                    # Cut off "\\NINJA\\CONTENT_"
0x40897C   020   51                      push    ecx
0x40897D   024   8D 4C 24 10             lea     ecx, [esp+0x24-0x14]
0x408981   024   E8 1A 8A FF FF          call    0x4013A0-0x408981-1         # zSTRING::zSTRING(char const *)

0x408986   020   89 EE                   mov     esi, ebp                    # zCMenu *
0x408988   020   51                      push    ecx
0x408989   024   B9 08 CE 8D 00          mov     ecx, 0x8DCE08               # offset zCParser parser
0x40898E   024   E8 DD 0C 2E 00          call    0x6E9670-0x40898E-1         # zCParser::CallFunc(zSTRING const &)

0x408993   020   8D 4C 24 0C             lea     ecx, [esp+0x20-0x14]
0x408997   020   E8 C4 88 FF FF          call    0x401260-0x408997-1         # zSTRING::~zSTRING(void)

0x40899C   020   5E                      pop     esi
0x40899D   01C   59                      pop     ecx
0x40899E   018   58                      pop     eax
0x40899F   014   83 C4 14                add     esp, 0x14
0x4089A2   000   C2 04 00                ret     4


0x4089A5         90 90 90 90 90 90       nop nop nop nop nop nop


# void __stdcall ninja_mergeSrc(char *)
#
# var1   -0x14 zString
#   a1   +4
#

0x4089AB   000   83 EC 14                sub     esp, 0x14
0x4089AE   014   50                      push    eax
0x4089AF   018   51                      push    ecx

0x4089B0   01C   FF 74 24 20             push    [esp+0x1C+4]
0x4089B4   020   90                      nop
0x4089B5   020   8D 4C 24 0C             lea     ecx, [esp+0x20-0x14]
0x4089B9   020   E8 E2 89 FF FF          call    0x4013A0-0x4089B9-1         # zSTRING::zSTRING(char const *)

0x4089BE   01C   90 90 90 90             nop nop nop nop
0x4089C2   020   90 90 90 90 90          nop nop nop nop nop

0x4089C7   01C   51                      push    ecx
0x4089C8   020   A1 D4 DF 8D 00          mov     eax, ds:0x8DDFD4            # zCParser * zCParser::cur_parser

0x4089CD   020   89 C1                   mov     ecx, eax
0x4089CF   020   E8 1C F9 2D 00          call    0x6E82F0-0x4089CF-1         # zCParser::MergeFile(zSTRING &)

0x4089D4   01C   8D 4C 24 08             lea     ecx, [esp+0x1C-0x14]
0x4089D8   01C   E8 83 88 FF FF          call    0x401260-0x4089D8-1         # zSTRING::~zSTRING(void)

0x4089DD   01C   59                      pop     ecx
0x4089DE   018   58                      pop     eax
0x4089DF   014   83 C4 14                add     esp, 0x14
0x4089E2   000   C2 04 00                ret     4


0x4089E5         90 90 90 90 90 90       nop nop nop nop nop nop


# void __stdcall ninja_inject(zCParser *,char *,void (__stdcall *)(char *))
#
#   a1   +4
#   a2   +8
#   a3   +0xC
#

0x4089EB   000   60                      pusha

0x4089EC   020   A1 D4 DF 8D 00          mov     eax, ds:0x8DDFD4            # zCParser * zCParser::cur_parser
0x4089F1   020   50                      push    eax
0x4089F2   024   A1 74 E1 8D 00          mov     eax, ds:0x8DE174            # zCPar_SymbolTable * zCPar_SymbolTable::cur_table
0x4089F7   024   50                      push    eax

0x4089F8   028   8B 74 24 2C             mov     esi, [esp+0x28+4]
0x4089FC   028   89 35 D4 DF 8D 00       mov     DWORD PTR ds:0x8DDFD4, esi  # zCParser * zCParser::cur_parser
0x408A02   028   83 C6 10                add     esi, 0x10
0x408A05   028   89 35 74 E1 8D 00       mov     DWORD PTR ds:0x8DE174, esi  # zCPar_SymbolTable * zCPar_SymbolTable::cur_table

0x408A0B   028   81 C6 80 10 00 00       add     esi, 0x1080
0x408A11   028   8B 06                   mov     eax, [esi]
0x408A13   028   50                      push    eax                         # Backup parser->datsave

0x408A14   02C   A1 CC DF 8D 00          mov     eax, ds:0x8DDFCC            # int zCParser::enableParsing
0x408A19   02C   50                      push    eax

0x408A1A   030   31 C0                   xor     eax, eax
0x408A1C   030   89 06                   mov     [esi], eax                  # parser->datsave = 0
0x408A1E   030   89 86 A4 EF FF FF       mov     [esi-0x105C], eax           # parser->lastsym = 0

0x408A24   030   40                      inc     eax
0x408A25   030   A3 CC DF 8D 00          mov     DWORD PTR ds:0x8DDFCC, eax  # int zCParser::enableParsing

0x408A2A   030   FF 74 24 3C             push    [esp+0x30+0xC]
0x408A2E   034   FF 74 24 3C             push    [esp+0x34+8]
0x408A32   038   E8 77 FD FF FF          call    0x4087AE-0x408A32-1         # ninja_findVdfSrc(char *,void (__stdcall *)(char *))

0x408A37   030   58                      pop     eax
0x408A38   02C   A3 CC DF 8D 00          mov     DWORD PTR ds:0x8DDFCC, eax  # int zCParser::enableParsing

0x408A3D   02C   58                      pop     eax
0x408A3E   028   8B 74 24 2C             mov     esi, [esp+0x28+4]
0x408A42   028   89 86 90 10 00 00       mov     DWORD PTR [esi+0x1090], eax # restore parser->datsave

0x408A48   028   5E                      pop     esi
0x408A49   024   89 35 74 E1 8D 00       mov     DWORD PTR ds:0x8DE174, esi  # zCPar_SymbolTable * zCPar_SymbolTable::cur_table
0x408A4F   024   5E                      pop     esi
0x408A50   020   89 35 D4 DF 8D 00       mov     DWORD PTR ds:0x8DDFD4, esi  # zCParser * zCParser::cur_parser

0x408A56   020   61                      popa
0x408A57   000   C2 0C 00                ret     0xC


0x408A5A         90 90                   nop nop


# void __stdcall ninja_parseMsgOverwrite(zString *)
#
#   a1    +4
#

0x408A5C   000   8B 44 24 04             mov     eax, DWORD PTR [esp+4]
0x408A60   000   31 C9                   xor     ecx, ecx
0x408A62   000   51                      push    ecx
0x408A63   004   51                      push    ecx
0x408A64   008   51                      push    ecx
0x408A65   00C   51                      push    ecx
0x408A66   010   6A 06                   push    6
0x408A68   014   50                      push    eax
0x408A69   018   51                      push    ecx
0x408A6A   01C   6A 01                   push    1
0x408A6C   020   B9 D8 99 86 00          mov     ecx, 0x8699D8               # offset zERROR zerr
0x408A71   020   E8 DA F7 03 00          call    0x448250-0x408A71-1         # zERROR::Report(zERROR_TYPE,int,zSTRING const &,signed char,uint,int,char *,char *)
0x408A76   000   C2 04 00                ret     4


0x408A79         90 90 90 90 90 90       nop nop nop nop nop nop


# zCPar_Symbol * __thiscall zCPar_Symbol::GetNext(void) [FIXED]
#

loc_func_symbNext:

0x408A7F         60                      pusha
0x408A80         51                      push    ecx
0x408A81         8B 35 74 E1 8D 00       mov     esi, ds:0x8DE174            # zCPar_SymbolTable * zCPar_SymbolTable::cur_table
0x408A87         90 90 90                nop nop nop
0x408A8A         89 F1                   mov     ecx, esi
0x408A8C         E8 0F 15 2F 00          call    0x6F9FA0-0x408A8C-1         # zCPar_SymbolTable::GetIndex(zCPar_Symbol *)
0x408A91         40                      inc     eax
0x408A92         85 C0                   test    eax, eax
0x408A94         74 08                   jz      short loc_symbInv
0x408A96         89 F1                   mov     ecx, esi
0x408A98         50                      push    eax
0x408A99         E8 72 19 2F 00          call    0x6FA410-0x408A99-1         # zCPar_SymbolTable::GetSymbol(int)

loc_symbInv:

0x408A9E         89 44 24 1C             mov     [esp+0x1C], eax
0x408AA2         61                      popa
0x408AA3         C3                      ret


0x408AA4         90 90 90 90 90 90       nop nop nop nop nop nop


# # #


loc_skip:

0x408BCA   154   8B 44 24 18             mov     eax, [esp+0x154-0x13C]      # Untouched
