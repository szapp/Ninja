# First location: functions


# Jump from 0x408A1D to 0x408E67
# Gives about 1091 "free" (unused) bytes

loc_start:

0x408A1D         E9 45 04 00 00          jmp     loc_skip


# void __stdcall ninja_findVdfSrc(char *,void (__stdcall *)(char *))
#
#   fullname -0x23C   char[MAX_PATH+28]   0x120
#   filedata -0x11C   finddata_t          0x118
#   findhndl -4       HANDLE
#   arg1     +4       char *
#   arg2     +8       void (__stdcall *)(char *)
#

0x408A22   000   81 EC 3C 02 00 00       sub     esp, 0x23C
0x408A28   23C   50                      push    eax
0x408A29   240   51                      push    ecx
0x408A2A   244   56                      push    esi
0x408A2B   248   57                      push    edi

0x408A2C   24C   8D B4 24 30 01 00 00    lea     esi, [esp+0x24C-0x11C]      # finddata_t
0x408A33   24C   56                      push    esi
0x408A34   250   68 88 7B 45 00          push    0x457B88                    # offset NINJA_PATH_VDF "\\DATA\\NINJA_*(dot)VDF"
0x408A39   254   E8 C8 9A 3C 00          call    0x7D2506-0x408A39-1         # _findfirst(const char *,finddata_t *)
0x408A3E   254   83 C4 08                add     esp, 8
0x408A41   24C   83 F8 FF                cmp     eax, 0xFFFFFFFF             # INVALID_HANDLE_VALUE
0x408A44   24C   0F 84 B0 00 00 00       jz      loc_fvs_end
0x408A4A   24C   89 84 24 48 02 00 00    mov     [esp+0x24C-4], eax          # HANDLE

loc_fvs_fileLoopStart:

0x408A51   24C   8D B4 24 44 01 00 00    lea     esi, [esp+0x24C-0x11C+0x14] # finddata_t->name
0x408A58   24C   31 FF                   xor     edi, edi

loc_fvs_toUpper:

0x408A5A   24C   8A 04 3E                mov     al, BYTE PTR [esi+edi*1]
0x408A5D   24C   84 C0                   test    al, al
0x408A5F   24C   74 11                   jz      short loc_fvs_setExt

0x408A61   24C   47                      inc     edi

0x408A62   24C   3C 61                   cmp     al, 0x61
0x408A64   24C   7C F4                   jl      short loc_fvs_toUpper
0x408A66   24C   3C 7A                   cmp     al, 0x7A
0x408A68   24C   7F F0                   jg      short loc_fvs_toUpper
0x408A6A   24C   2C 20                   sub     al, 0x20
0x408A6C   24C   88 44 3E FF             mov     BYTE PTR [esi+edi-1], al
0x408A70   24C   EB E8                   jmp     short loc_fvs_toUpper

loc_fvs_setExt:

0x408A72   24C   4F                      dec     edi
0x408A73   24C   C6 04 3E 43             mov     BYTE PTR [esi+edi*1], 0x43  # "C"
0x408A77   24C   4F                      dec     edi
0x408A78   24C   C6 04 3E 52             mov     BYTE PTR [esi+edi*1], 0x52  # "R"
0x408A7C   24C   4F                      dec     edi
0x408A7D   24C   C6 04 3E 53             mov     BYTE PTR [esi+edi*1], 0x53  # "S"

0x408A81   24C   FF B4 24 50 02 00 00    push    [esp+0x24C+4]               # arg1, eg "\\NINJA\\CONTENT_", or "\\NINJA\\MENU_", etc
0x408A88   250   8D 74 24 14             lea     esi, [esp+0x250-0x23C]      # fullname
0x408A8C   250   56                      push    esi
0x408A8D   254   FF 15 E4 E1 82 00       call    ds:0x82E1E4                 # lstrcpyA(LPTSTR,LPTSTR)
0x408A93   24C   8D B4 24 44 01 00 00    lea     esi, [esp+0x24C-0x11C+0x14] # finddata_t->name
0x408A9A   24C   56                      push    esi
0x408A9B   250   50                      push    eax
0x408A9C   254   FF 15 E0 E1 82 00       call    ds:0x82E1E0                 # lstrcatA(LPTSTR,LPTSTR)
0x408AA2   24C   89 C6                   mov     esi, eax

0x408AA4   24C   E8 37 2D 04 00          call    0x44B7E0-0x408AA4-1         # zFILE_VDFS::LockCriticalSection(void)
0x408AA9   24C   6A 07                   push    7                           # VDF_VIRTUAL | VDF_PHYSICAL | VDF_PHYSICALFIRST
0x408AAB   250   56                      push    esi                         # arg1 + finddata_t->name + ext
0x408AAC   254   FF 15 6C E6 82 00       call    ds:0x82E66C                 # vdf_fexists(const char*,long)
0x408AB2   254   83 C4 08                add     esp, 8
0x408AB5   24C   50                      push    eax
0x408AB6   250   E8 45 2D 04 00          call    0x44B800-0x408AB6-1         # zFILE_VDFS::UnlockCriticalSection(void)
0x408ABB   250   58                      pop     eax
0x408ABC   24C   85 C0                   test    eax, eax
0x408ABE   24C   74 0C                   jz      short loc_fvs_nextfile

0x408AC0   24C   8D 74 24 10             lea     esi, [esp+0x24C-0x23C]      # fullname
0x408AC4   24C   56                      push    esi
0x408AC5   250   FF 94 24 58 02 00 00    call    DWORD PTR [esp+0x250+8]     # arg2(char *)

loc_fvs_nextfile:

0x408ACC   24C   8D B4 24 30 01 00 00    lea     esi, [esp+0x24C-0x11C]      # finddata_t
0x408AD3   24C   56                      push    esi
0x408AD4   250   FF B4 24 4C 02 00 00    push    [esp+0x250-4]               # HANDLE
0x408ADB   254   E8 F3 9A 3C 00          call    0x7D25D3-0x408ADB-1         # _findnext(int,_finddata_t *)
0x408AE0   254   83 C4 08                add     esp, 8
0x408AE3   24C   85 C0                   test    eax, eax
0x408AE5   24C   0F 84 66 FF FF FF       jz      loc_fvs_fileLoopStart

0x408AEB   24C   FF B4 24 48 02 00 00    push    [esp+0x24C-4]               # HANDLE
0x408AF2   250   E8 A4 9B 3C 00          call    0x7D269B-0x408AF2-1         # _findclose(int)
0x408AF7   250   83 C4 04                add     esp, 4

loc_fvs_end:

0x408AFA   24C   5F                      pop     edi
0x408AFB   248   5E                      pop     esi
0x408AFC   244   59                      pop     ecx
0x408AFD   240   58                      pop     eax
0x408AFE   23C   81 C4 3C 02 00 00       add     esp, 0x23C
0x408B04   000   C2 08 00                ret     8


0x408B07         90 90 90 90 90 90       nop nop nop nop nop nop             # 6
0x408B0D         90 90 90 90 90 90       nop nop nop nop nop nop             # 12
0x408B13         90 90 90 90 90 90       nop nop nop nop nop nop             # 18
0x408B19         90 90 90 90 90 90       nop nop nop nop nop nop             # 24
0x408B1F         90 90 90 90 90 90       nop nop nop nop nop nop             # 30
0x408B25         90 90 90 90 90 90       nop nop nop nop nop nop             # 36
0x408B2B         90 90 90 90 90 90       nop nop nop nop nop nop             # 42
0x408B31         90 90 90 90 90 90       nop nop nop nop nop nop             # 48
0x408B37         90 90 90 90 90 90       nop nop nop nop nop nop             # 54
0x408B3D         90 90 90 90 90 90       nop nop nop nop nop nop             # 60
0x408B43         90 90 90 90 90 90       nop nop nop nop nop nop             # 66
0x408B49         90 90 90 90 90 90       nop nop nop nop nop nop             # 72
0x408B4F         90 90 90 90 90 90       nop nop nop nop nop nop             # 78
0x408B55         90 90 90 90 90 90       nop nop nop nop nop nop             # 84


# void __stdcall ninja_initContent(char *)
#
# var1   -0x14 (zString)
#   a1   +4
#

0x408B5B   000   83 EC 14                sub     esp, 0x14
0x408B5E   014   50                      push    eax
0x408B5F   018   51                      push    ecx

0x408B60   01C   FF 74 24 20             push    [esp+0x1C+4]
0x408B64   020   FF 15 E8 E1 82 00       call    ds:0x82E1E8                 # lstrlenA(LPCSTR)

0x408B6A   01C   8B 4C 24 20             mov     ecx, [esp+0x1C+4]
0x408B6E   01C   40                      inc     eax                         # This works, because buffer is big enough
0x408B6F   01C   C6 04 08 00             mov     BYTE PTR [eax+ecx*1], 0     # NUL
0x408B73   01C   48                      dec     eax
0x408B74   01C   C6 04 08 54             mov     BYTE PTR [eax+ecx*1], 0x54  # "T"
0x408B78   01C   48                      dec     eax
0x408B79   01C   C6 04 08 49             mov     BYTE PTR [eax+ecx*1], 0x49  # "I"
0x408B7D   01C   48                      dec     eax
0x408B7E   01C   C6 04 08 4E             mov     BYTE PTR [eax+ecx*1], 0x4E  # "N"
0x408B82   01C   48                      dec     eax
0x408B83   01C   C6 04 08 49             mov     BYTE PTR [eax+ecx*1], 0x49  # "I"
0x408B87   01C   48                      dec     eax
0x408B88   01C   C6 04 08 5F             mov     BYTE PTR [eax+ecx*1], 0x5F  # "_"
0x408B8C   01C   83 C1 0F                add     ecx, 0xF                    # Cut off "\\NINJA\\CONTENT_"
0x408B8F   01C   51                      push    ecx
0x408B90   020   8D 4C 24 0C             lea     ecx, [esp+0x20-0x14]
0x408B94   020   E8 27 85 FF FF          call    0x4010C0-0x408B94-1         # zSTRING::zSTRING(char const *)

0x408B99   01C   51                      push    ecx
0x408B9A   020   B9 C0 40 AB 00          mov     ecx, 0xAB40C0               # offset zCParser parser
0x408B9F   020   E8 2C 9E 38 00          call    0x7929D0-0x408B9F-1         # zCParser::CallFunc(zSTRING const &)

0x408BA4   01C   8D 4C 24 08             lea     ecx, [esp+0x1C-0x14]
0x408BA8   01C   E8 B3 85 FF FF          call    0x401160-0x408BA8-1         # zSTRING::~zSTRING(void)

0x408BAD   01C   59                      pop     ecx
0x408BAE   018   58                      pop     eax
0x408BAF   014   83 C4 14                add     esp, 0x14
0x408BB2   000   C2 04 00                ret     4


0x408BB5         90 90 90 90 90 90       nop nop nop nop nop nop


# void __stdcall ninja_initMenu(char *)
#
# var1   -0x14 (zString)
#   a1   +4
#

0x408BBB   000   83 EC 14                sub     esp, 0x14
0x408BBE   014   50                      push    eax
0x408BBF   018   51                      push    ecx
0x408BC0   01C   56                      push    esi

0x408BC1   020   FF 74 24 24             push    [esp+0x20+4]
0x408BC5   024   FF 15 E8 E1 82 00       call    ds:0x82E1E8                 # lstrlenA(LPCSTR)

0x408BCB   020   8B 4C 24 24             mov     ecx, [esp+0x20+4]
0x408BCF   01C   40                      inc     eax                         # This works, because buffer is big enough
0x408BD0   020   C6 04 08 00             mov     BYTE PTR [eax+ecx*1], 0     # NUL
0x408BD4   020   48                      dec     eax
0x408BD5   020   C6 04 08 55             mov     BYTE PTR [eax+ecx*1], 0x55  # "U"
0x408BD9   020   48                      dec     eax
0x408BDA   020   C6 04 08 4E             mov     BYTE PTR [eax+ecx*1], 0x4E  # "N"
0x408BDE   020   48                      dec     eax
0x408BDF   020   C6 04 08 45             mov     BYTE PTR [eax+ecx*1], 0x45  # "E"
0x408BE3   020   48                      dec     eax
0x408BE4   020   C6 04 08 4D             mov     BYTE PTR [eax+ecx*1], 0x4D  # "M"
0x408BE8   01C   48                      dec     eax
0x408BE9   01C   C6 04 08 5F             mov     BYTE PTR [eax+ecx*1], 0x5F  # "_"
0x408BED   01C   83 C1 0F                add     ecx, 0xF                    # Cut off "\\NINJA\\CONTENT_"
0x408BF0   020   51                      push    ecx
0x408BF1   024   8D 4C 24 10             lea     ecx, [esp+0x24-0x14]
0x408BF5   024   E8 C6 84 FF FF          call    0x4010C0-0x408BF5-1         # zSTRING::zSTRING(char const *)

0x408BFA   020   89 EE                   mov     esi, ebp                    # zCMenu *
0x408BFC   020   51                      push    ecx
0x408BFD   024   B9 C0 40 AB 00          mov     ecx, 0xAB40C0               # offset zCParser parser
0x408C02   024   E8 C9 9D 38 00          call    0x7929D0-0x408C02-1         # zCParser::CallFunc(zSTRING const &)

0x408C07   020   8D 4C 24 0C             lea     ecx, [esp+0x20-0x14]
0x408C0B   020   E8 50 85 FF FF          call    0x401160-0x408C0B-1         # zSTRING::~zSTRING(void)

0x408C10   020   5E                      pop     esi
0x408C11   01C   59                      pop     ecx
0x408C12   018   58                      pop     eax
0x408C13   014   83 C4 14                add     esp, 0x14
0x408C16   000   C2 04 00                ret     4


0x408C19         90 90 90 90 90 90       nop nop nop nop nop nop


# void __stdcall ninja_mergeSrc(char *)
#
# var1   -0x14 zString
#   a1   +4
#

0x408C1F   000   83 EC 14                sub     esp, 0x14
0x408C22   014   50                      push    eax
0x408C23   018   51                      push    ecx

0x408C32   01C   FF 74 24 20             push    [esp+0x1C+4]
0x408C28   020   90                      nop
0x408C29   020   8D 4C 24 0C             lea     ecx, [esp+0x20-0x14]
0x408C2D   020   E8 8E 84 FF FF          call    0x4010C0-0x408C2D-1         # zSTRING::zSTRING(char const *)

0x408C32   01C   90 90 90 90             nop nop nop nop
0x408C36   020   90 90 90 90 90          nop nop nop nop nop

0x408C3B   01C   51                      push    ecx
0x408C3C   020   A1 8C 62 AB 00          mov     eax, ds:0xAB628C            # zCParser * zCParser::cur_parser

0x408C41   020   89 C1                   mov     ecx, eax
0x408C43   020   E8 08 8A 38 00          call    0x791650-0x408C43-1         # zCParser::MergeFile(zSTRING &)

0x408C48   01C   8D 4C 24 08             lea     ecx, [esp+0x1C-0x14]
0x408C4C   01C   E8 0F 85 FF FF          call    0x401160-0x408C4C-1         # zSTRING::~zSTRING(void)

0x408C51   01C   59                      pop     ecx
0x408C52   018   58                      pop     eax
0x408C53   014   83 C4 14                add     esp, 0x14
0x408C56   000   C2 04 00                ret     4


0x408C59         90 90 90 90 90 90       nop nop nop nop nop nop


# void __stdcall ninja_inject(zCParser *,char *,void (__stdcall *)(char *))
#
#   a1   +4
#   a2   +8
#   a3   +0xC
#

0x408C5F   000   60                      pusha

0x408C60   020   A1 8C 62 AB 00          mov     eax, ds:0xAB628C            # zCParser * zCParser::cur_parser
0x408C65   020   50                      push    eax
0x408C66   024   A1 28 64 AB 00          mov     eax, ds:0xAB6428            # zCPar_SymbolTable * zCPar_SymbolTable::cur_table
0x408C6B   024   50                      push    eax

0x408C6C   028   8B 74 24 2C             mov     esi, [esp+0x28+4]
0x408C70   028   89 35 8C 62 AB 00       mov     DWORD PTR ds:0xAB628C, esi  # zCParser * zCParser::cur_parser
0x408C76   028   83 C6 10                add     esi, 0x10
0x408C79   028   89 35 28 64 AB 00       mov     DWORD PTR ds:0xAB6428, esi  # zCPar_SymbolTable * zCPar_SymbolTable::cur_table

0x408C7F   028   81 C6 80 20 00 00       add     esi, 0x2080
0x408C85   028   8B 06                   mov     eax, [esi]
0x408C87   028   50                      push    eax                         # Backup parser->datsave

0x408C88   02C   A1 84 62 AB 00          mov     eax, ds:0xAB6284            # int zCParser::enableParsing
0x408C8D   02C   50                      push    eax

0x408C8E   030   31 C0                   xor     eax, eax
0x408C90   030   89 06                   mov     [esi], eax                  # parser->datsave = 0
0x408C92   030   89 86 A4 DF FF FF       mov     [esi-0x205C], eax           # parser->lastsym = 0

0x408C98   030   40                      inc     eax
0x408C99   030   A3 84 62 AB 00          mov     DWORD PTR ds:0xAB6284, eax  # int zCParser::enableParsing

0x408C9E   030   FF 74 24 3C             push    [esp+0x30+0xC]
0x408CA2   034   FF 74 24 3C             push    [esp+0x34+8]
0x408CA6   038   E8 77 FD FF FF          call    0x408A22-0x408CA6-1         # ninja_findVdfSrc(char *,void (__stdcall *)(char *))

0x408CAB   030   58                      pop     eax
0x408CAC   02C   A3 84 62 AB 00          mov     DWORD PTR ds:0xAB6284, eax  # int zCParser::enableParsing

0x408CB1   02C   58                      pop     eax
0x408CB2   028   8B 74 24 2C             mov     esi, [esp+0x28+4]
0x408CB6   028   89 86 90 20 00 00       mov     DWORD PTR [esi+0x2090], eax # restore parser->datsave

0x408CBC   028   5E                      pop     esi
0x408CBD   024   89 35 28 64 AB 00       mov     DWORD PTR ds:0xAB6428, esi  # zCPar_SymbolTable * zCPar_SymbolTable::cur_table
0x408CC3   024   5E                      pop     esi
0x408CC4   020   89 35 8C 62 AB 00       mov     DWORD PTR ds:0xAB628C, esi  # zCParser * zCParser::cur_parser

0x408CCA   020   61                      popa
0x408CCB   000   C2 0C 00                ret     0xC


0x408CCE         90 90                   nop nop


# void __stdcall ninja_parseMsgOverwrite(zString *)
#
#   a1    +4
#

0x408CD0   000   8B 44 24 04             mov     eax, DWORD PTR [esp+4]
0x408CD4   000   31 C9                   xor     ecx, ecx
0x408CD6   000   51                      push    ecx
0x408CD7   004   51                      push    ecx
0x408CD8   008   51                      push    ecx
0x408CD9   00C   51                      push    ecx
0x408CDA   010   6A 06                   push    6
0x408CDC   014   50                      push    eax
0x408CDD   018   51                      push    ecx
0x408CDE   01C   6A 01                   push    1
0x408CE0   020   B9 D0 DC 8C 00          mov     ecx, 0x8CDCD0               # offset zERROR zerr
0x408CE5   020   E8 E6 3B 04 00          call    0x44C8D0-0x408CE5-1         # zERROR::Report(zERROR_TYPE,int,zSTRING const &,signed char,uint,int,char *,char *)
0x408CEA   000   C2 04 00                ret     4


0x408CED         90 90 90 90 90 90       nop nop nop nop nop nop


# zCPar_Symbol * __thiscall zCPar_Symbol::GetNext(void) [FIXED]
#

loc_func_symbNext:

0x408CF3         60                      pusha
0x408CF4         51                      push    ecx
0x408CF5         8B 35 28 64 AB 00       mov     esi, ds:0xAB6428            # zCPar_SymbolTable * zCPar_SymbolTable::cur_table
0x408CFB         90 90 90                nop nop nop
0x408CFE         89 F1                   mov     ecx, esi
0x408D00         E8 6B AD 39 00          call    0x7A3A70-0x408D00-1         # zCPar_SymbolTable::GetIndex(zCPar_Symbol *)
0x408D05         40                      inc     eax
0x408D06         85 C0                   test    eax, eax
0x408D08         74 08                   jz      short loc_symbInv
0x408D0A         89 F1                   mov     ecx, esi
0x408D0C         50                      push    eax
0x408D0D         E8 CE B1 39 00          call    0x7A3EE0-0x408D0D-1         # zCPar_SymbolTable::GetSymbol(int)

loc_symbInv:

0x408D12         89 44 24 1C             mov     [esp+0x1C], eax
0x408D16         61                      popa
0x408D17         C3                      ret


0x408D18         90 90 90 90 90 90       nop nop nop nop nop nop


# # #


loc_skip:

0x408E67   188   8B 44 24 18             mov     eax, [esp+0x188-0x170]      # Untouched
