# Second location: functions continued and some executing code


# Jump from 0x4110AB to 0x41133D
# Gives about 653 "free" (unused) bytes

loc_start:

0x4110AB         E9 8D 02 00 00          jmp     loc_skip  # 0x41133D-0x4110AB-1


void __stdcall ninja_initAnims(char *)
#
# var1 -0x14 zString
# a1   +4    char *
#

0x4110B0   000   83 EC 14                sub     esp, 0x14
0x4110B3   014   50                      push    eax
0x4110B4   018   51                      push    ecx
0x4110B5   01C   56                      push    esi

0x4110B6   020   6A 04                   push    4                           # DIR_ANIMS
0x4110B8   024   8B 0D 88 D9 8C 00       mov     ecx, DWORD PTR ds:0x8CD988  # zCOption * zoptions
0x4110BE   024   E8 9D 41 05 00          call    0x465260-0x4110BE-1         # zCOption::GetDirString(zTOptionPaths)
0x4110C3   020   8B 40 08                mov     eax, [eax+8]
0x4110C6   020   50                      push    eax
0x4110C7   024   8D 4C 24 10             lea     ecx, [esp+0x24-0x14]
0x4110CB   024   E8 F0 FF FE FF          call    0x4010C0-0x4110CB-1         # zSTRING::zSTRING(char const *)

0x4110D0   020   FF 74 24 24             push    [esp+0x20+4]
0x4110D4   024   FF 15 E8 E1 82 00       call    ds:0x82E1E8                 # lstrlenA(LPCSTR)

0x4110DA   020   8B 4C 24 24             mov     ecx, [esp+0x20+4]
0x4110DE   020   83 E8 03                sub     eax, 3
0x4110E1   020   C6 04 08 00             mov     BYTE PTR [eax+ecx*1], 0
0x4110E5   020   48                      dec     eax
0x4110E6   020   C6 04 08 5F             mov     BYTE PTR [eax+ecx*1], 0x5F  # "_"
0x4110EA   020   83 C1 17                add     ecx, 0x17                   # Cut off "\\NINJA\\ANIMATION_NINJA_"
0x4110ED   020   51                      push    ecx                         # "[NAME]_"
0x4110EE   024   8D 4C 24 10             lea     ecx, [esp+0x24-0x14]
0x4110F2   024   E8 B9 96 26 00          call    0x67A7B0-0x4110F2-1         # zSTRING::operator+=(char const *)

0x4110F7   020   8D 45 0C                lea     eax, [ebp+0xC]
0x4110FA   020   8B 40 08                mov     eax, [eax+8]
0x4110FD   020   50                      push    eax                         # modelPrototype->name->ptr
0x4110FE   024   E8 AD 96 26 00          call    0x67A7B0-0x4110FE-1         # zSTRING::operator+=(char const *)
0x411103   020   68 E0 70 89 00          push    0x8970E0                    # offset str_mds "(dot)MDS"
0x411108   024   E8 A3 96 26 00          call    0x67A7B0-0x411108-1         # zSTRING::operator+=(char const *)

0x41110D   020   51                      push    ecx
0x41110E   024   8B 0D F0 8D 8D 00       mov     ecx, DWORD PTR ds:0x8D8DF0  # zCObjectFactory * zfactory
0x411114   024   8B 09                   mov     ecx, [ecx]
0x411116   024   FF 51 14                call    DWORD PTR [ecx+0x14]        # zCObjectFactory::CreateZFile(zSTRING const &)
0x411119   020   89 C6                   mov     esi, eax
0x41111B   020   8B 06                   mov     eax, [esi]
0x41111D   020   89 F1                   mov     ecx, esi
0x41111F   020   FF 90 94 00 00 00       call    DWORD PTR [eax+0x94]        # zFILE_VDFS::Exists(void)
0x411125   020   84 C0                   test    al, al
0x411127   020   0F 84 C0 00 00 00       jz      loc_anims_end

0x41112D   020   83 EC 14                sub     esp, 0x14
0x411130   034   89 E1                   mov     ecx, esp
0x411132   034   68 99 7B 45 00          push    0x457B99                    # offset NINJA_LOAD_ANIM
0x411137   034   E8 84 FF FE FF          call    0x4010C0-0x411137-1         # zSTRING::zSTRING(char const *)
0x41113C   034   FF 74 24 28             push    [esp+0x34-0x14+8]
0x411140   038   E8 6B 96 26 00          call    0x67A7B0-0x411140-1         # zSTRING::operator+=(char const *)
0x411145   034   51                      push    ecx
0x411146   038   E8 C5 C8 03 00          call    0x44DA10-0x411146-1         # zERROR::Message(zSTRING const &)
0x41114B   034   89 E1                   mov     ecx, esp
0x41114D   034   E8 0E 00 FF FF          call    0x401160-0x41114D-1         # zSTRING::~zSTRING(void)
0x411152   034   83 C4 14                add     esp, 0x14

0x411155   020   6A 00                   push    0
0x411157   020   8B 06                   mov     eax, [esi]
0x411159   024   89 F1                   mov     ecx, esi
0x41115B   024   FF 90 8C 00 00 00       call    DWORD PTR [eax+0x8C]        # zFILE_VDFS::Open(bool)

0x411161   020   FF 35 CC 8B 8D 00       push    DWORD PTR ds:0x8D8BCC       # Back up zFILE *cur_mds_file
0x411167   024   89 35 CC 8B 8D 00       mov     DWORD PTR ds:0x8D8BCC, esi

0x41116D   024   83 EC 0C                sub     esp, 0xC                    # Create fake zCFileBIN
0x411170   030   C7 04 24 FF FF FF FF    mov     DWORD PTR [esp], 0xFFFFFFFF

loc_mds_loop_start:

0x411177   030   8B 06                   mov     eax, [esi]
0x411179   030   89 F1                   mov     ecx, esi
0x41117B   030   FF 90 B0 00 00 00       call    DWORD PTR [eax+0xB0]        # zFILE_VDFS::Eof(void)
0x411181   030   84 C0                   test    al, al
0x411183   030   75 55                   jnz     short loc_anims_eof

0x411185   030   8B 06                   mov     eax, [esi]
0x411187   030   89 F1                   mov     ecx, esi
0x411189   030   68 C0 8A 8D 00          push    0x8D8AC0                    # zString *stru_008D8AC0
0x41118E   034   FF 90 C4 00 00 00       call    DWORD PTR [eax+0xC4]        # zFILE_VDFS::Read(zSTRING &)
0x411194   030   B9 C0 8A 8D 00          mov     ecx, 0x8D8AC0               # zString *stru_008D8AC0
0x411199   030   E8 62 99 05 00          call    0x46AB00-0x411199-1         # zSTRING::Upper(void)
0x41119E   030   6A 01                   push    1
0x4111A0   034   68 64 2C 89 00          push    0x892C64                    # offset char_doubleFSlash "//"
0x4111A5   038   6A 00                   push    0
0x4111A7   03C   B9 C0 8A 8D 00          mov     ecx, 0x8D8AC0               # zString *stru_008D8AC0
0x4111AC   03C   E8 6F B7 05 00          call    0x46C920-0x4111AC-1         # zSTRING::Search(int,char const *,uint)
0x4111B1   030   83 F8 FF                cmp     eax, 0xFFFFFFFF
0x4111B4   030   75 C1                   jnz     short loc_mds_loop_start
0x4111B6   030   6A 01                   push    1
0x4111B8   034   68 CC 44 8A 00          push    0X8A44CC                    # offset strModel "MODEL"
0x4111BD   038   6A 00                   push    0
0x4111BF   03C   B9 C0 8A 8D 00          mov     ecx, 0x8D8AC0               # zString *stru_008D8AC0
0x4111C4   03C   E8 57 B7 05 00          call    0x46C920-0x4111C4-1         # zSTRING::Search(int,char const *,uint)
0x4111C9   030   83 F8 FF                cmp     eax, 0xFFFFFFFF
0x4111CC   030   74 A9                   jz      short loc_mds_loop_start
0x4111CE   030   89 E1                   mov     ecx, esp                    # zCFileBIN *
0x4111D0   030   51                      push    ecx
0x4111D1   034   89 E9                   mov     ecx, ebp
0x4111D3   030   E8 E8 C2 18 00          call    0x59D4C0-0x4111D3-1         # zCModelPrototype::ReadModel(zCFileBIN &)
0x4111D8   030   75 9D                   jnz     short loc_mds_loop_start

loc_anims_eof:

0x4111DA   030   83 C4 0C                add     esp, 0xC

0x4111DD   024   58                      pop     eax
0x4111DE   020   A3 CC 8B 8D 00          mov     DWORD PTR ds:0x8D8BCC, eax  # Restore zFILE *cur_mds_file

0x4111E3   020   8B 06                   mov     eax, [esi]
0x4111E5   024   89 F1                   mov     ecx, esi
0x4111E7   024   FF 90 98 00 00 00       call    DWORD PTR [eax+0x98]        # zFILE_VDFS::Close(void)

loc_anims_end:

0x4111ED   020   8B 06                   mov     eax, [esi]
0x4111EF   020   6A 01                   push    1
0x4111F1   024   89 F1                   mov     ecx, esi
0x4111F3   024   FF 10                   call    DWORD PTR [eax]             # zFILE_VDFS::scalar_deleting_destructor(uint)

0x4111F5   020   8D 4C 24 0C             lea     ecx, [esp+0x20-0x14]
0x4111F9   020   E8 62 FF FE FF          call    0x401160-0x4111F9-1         # zSTRING::~zSTRING(void)

0x4111FE   020   5E                      pop     esi
0x4111FF   01C   59                      pop     ecx
0x411200   018   58                      pop     eax
0x411201   014   83 C4 14                add     esp, 0x14
0x411204   000   C2 04 00                ret     4


0x411207         90 90 90 90 90 90       nop nop nop nop nop nop


# # #


loc_skip:

0x41133D         F6 C7 08                test    bh, 8                       # Untouched
