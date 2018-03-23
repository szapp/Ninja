# Second location: functions continued and some executing code


# Jump from 0x410BAB to 0x410DD5
# Gives about 549 "free" (unused) bytes

loc_start:

0x410BAB         E9 25 02 00 00          jmp     loc_skip  # 0x410DD5-0x410BAB-1


# void __stdcall ninja_initAnims(char *)
#
# var1 -0x14 zString
# a1   +4    char *
#

0x410BB0   000   83 EC 14                sub     esp, 0x14
0x410BB3   014   50                      push    eax
0x410BB4   018   51                      push    ecx
0x410BB5   01C   56                      push    esi

0x410BB6   020   6A 04                   push    4                           # DIR_ANIMS
0x410BB8   024   8B 0D 94 96 86 00       mov     ecx, DWORD PTR ds:0x869694  # zCOption * zoptions
0x410BBE   024   E8 3D F0 04 00          call    0x45FC00-0x410BBE-1         # zCOption::GetDirString(zTOptionPaths)
0x410BC3   020   8B 40 08                mov     eax, [eax+8]
0x410BC6   020   50                      push    eax
0x410BC7   024   8D 4C 24 10             lea     ecx, [esp+0x24-0x14]
0x410BCB   024   E8 D0 07 FF FF          call    0x4013A0-0x410BCB-1         # zSTRING::zSTRING(char const *)

0x410BD0   020   FF 74 24 24             push    [esp+0x20+4]
0x410BD4   024   FF 15 74 02 7D 00       call    ds:0x7D0274                 # lstrlenA(LPCSTR)

0x410BDA   020   8B 4C 24 24             mov     ecx, [esp+0x20+4]
0x410BDE   020   83 E8 03                sub     eax, 3
0x410BE1   020   C6 04 08 00             mov     BYTE PTR [eax+ecx*1], 0
0x410BE5   020   48                      dec     eax
0x410BE6   020   C6 04 08 5F             mov     BYTE PTR [eax+ecx*1], 0x5F  # "_"
0x410BEA   020   83 C1 17                add     ecx, 0x17                   # Cut off "\\NINJA\\ANIMATION_NINJA_"
0x410BED   020   51                      push    ecx                         # "[NAME]_"
0x410BEE   024   8D 4C 24 10             lea     ecx, [esp+0x24-0x14]
0x410BF2   024   E8 D9 42 23 00          call    0x644ED0-0x410BF2-1         # zSTRING::operator+=(char const *)

0x410BF7   020   8D 45 0C                lea     eax, [ebp+0xC]
0x410BFA   020   8B 40 08                mov     eax, [eax+8]
0x410BFD   020   50                      push    eax                         # modelPrototype->name->ptr
0x410BFE   024   E8 CD 42 23 00          call    0x644ED0-0x410BFE-1         # zSTRING::operator+=(char const *)
0x410C03   020   68 34 35 83 00          push    0x833534                    # offset str_mds "(dot)MDS"
0x410C08   024   E8 C3 42 23 00          call    0x644ED0-0x410C08-1         # zSTRING::operator+=(char const *)

0x410C0D   020   51                      push    ecx
0x410C0E   024   8B 0D 88 3F 87 00       mov     ecx, DWORD PTR ds:0x873F88  # zCObjectFactory * zfactory
0x410C14   024   8B 09                   mov     ecx, [ecx]
0x410C16   024   FF 51 14                call    DWORD PTR [ecx+0x14]        # zCObjectFactory::CreateZFile(zSTRING const &)
0x410C19   020   89 C6                   mov     esi, eax
0x410C1B   020   8B 06                   mov     eax, [esi]
0x410C1D   020   89 F1                   mov     ecx, esi
0x410C1F   020   FF 90 94 00 00 00       call    DWORD PTR [eax+0x94]        # zFILE_VDFS::Exists(void)
0x410C25   020   84 C0                   test    al, al
0x410C27   020   0F 84 C0 00 00 00       jz      loc_anims_end

0x410C2D   020   83 EC 14                sub     esp, 0x14
0x410C30   034   89 E1                   mov     ecx, esp
0x410C32   034   68 77 2C 45 00          push    0x452C77                    # offset NINJA_LOAD_ANIM
0x410C37   034   E8 64 07 FF FF          call    0x4013A0-0x410C37-1         # zSTRING::zSTRING(char const *)
0x410C3C   034   FF 74 24 28             push    [esp+0x34-0x14+8]
0x410C40   038   E8 8B 42 23 00          call    0x644ED0-0x410C40-1         # zSTRING::operator+=(char const *)
0x410C45   034   51                      push    ecx
0x410C46   038   E8 A5 86 03 00          call    0x4492F0-0x410C46-1         # zERROR::Message(zSTRING const &)
0x410C4B   034   89 E1                   mov     ecx, esp
0x410C4D   034   E8 0E 06 FF FF          call    0x401260-0x410C4D-1         # zSTRING::~zSTRING(void)
0x410C52   034   83 C4 14                add     esp, 0x14

0x410C55   020   6A 00                   push    0
0x410C57   020   8B 06                   mov     eax, [esi]
0x410C59   024   89 F1                   mov     ecx, esi
0x410C5B   024   FF 90 8C 00 00 00       call    DWORD PTR [eax+0x8C]        # zFILE_VDFS::Open(bool)

0x410C61   020   FF 35 6C 3D 87 00       push    DWORD PTR ds:0x873D6C       # Back up zFILE *cur_mds_file
0x410C67   024   89 35 6C 3D 87 00       mov     DWORD PTR ds:0x873D6C, esi

0x410C6D   024   83 EC 0C                sub     esp, 0xC                    # Create fake zCFileBIN
0x410C70   030   C7 04 24 FF FF FF FF    mov     DWORD PTR [esp], 0xFFFFFFFF

loc_mds_loop_start:

0x410C77   030   8B 06                   mov     eax, [esi]
0x410C79   030   89 F1                   mov     ecx, esi
0x410C7B   030   FF 90 B0 00 00 00       call    DWORD PTR [eax+0xB0]        # zFILE_VDFS::Eof(void)
0x410C81   030   84 C0                   test    al, al
0x410C83   030   75 55                   jnz     short loc_anims_eof

0x410C85   030   8B 06                   mov     eax, [esi]
0x410C87   030   89 F1                   mov     ecx, esi
0x410C89   030   68 60 3C 87 00          push    0x873C60                    # zString *stru_00873C60
0x410C8E   034   FF 90 C4 00 00 00       call    DWORD PTR [eax+0xC4]        # zFILE_VDFS::Read(zSTRING &)
0x410C94   030   B9 60 3C 87 00          mov     ecx, 0x873C60               # zString *stru_00873C60
0x410C99   030   E8 F2 46 05 00          call    0x465390-0x410C99-1         # zSTRING::Upper(void)
0x410C9E   030   6A 01                   push    1
0x410CA0   034   68 AC ED 82 00          push    0x82EDAC                    # offset char_doubleFSlash "//"
0x410CA5   038   6A 00                   push    0
0x410CA7   03C   B9 60 3C 87 00          mov     ecx, 0x873C60               # zString *stru_00873C60
0x410CAC   03C   E8 9F 6A 05 00          call    0x467750-0x410CAC-1         # zSTRING::Search(int,char const *,uint)
0x410CB1   030   83 F8 FF                cmp     eax, 0xFFFFFFFF
0x410CB4   030   75 C1                   jnz     short loc_mds_loop_start
0x410CB6   030   6A 01                   push    1
0x410CB8   034   68 08 09 84 00          push    0x840908                    # offset strModel "MODEL"
0x410CBD   038   6A 00                   push    0
0x410CBF   03C   B9 60 3C 87 00          mov     ecx, 0x873C60               # zString *stru_00873C60
0x410CC4   03C   E8 87 6A 05 00          call    0x467750-0x410CC4-1         # zSTRING::Search(int,char const *,uint)
0x410CC9   030   83 F8 FF                cmp     eax, 0xFFFFFFFF
0x410CCC   030   74 A9                   jz      short loc_mds_loop_start
0x410CCE   030   89 E1                   mov     ecx, esp                    # zCFileBIN * ignored in Gothic 1
0x410CD0   030   90                      nop
0x410CD1   030   89 E9                   mov     ecx, ebp
0x410CD3   030   E8 38 D7 16 00          call    0x57E410-0x410CD3-1         # zCModelPrototype::ReadModel(void)
0x410CD8   030   75 9D                   jnz     short loc_mds_loop_start

loc_anims_eof:

0x410CDA   030   83 C4 0C                add     esp, 0xC

0x410CDD   024   58                      pop     eax
0x410CDE   020   A3 6C 3D 87 00          mov     DWORD PTR ds:0x873D6C, eax  # Restore zFILE *cur_mds_file

0x410CE3   020   8B 06                   mov     eax, [esi]
0x410CE5   024   89 F1                   mov     ecx, esi
0x410CE7   024   FF 90 98 00 00 00       call    DWORD PTR [eax+0x98]        # zFILE_VDFS::Close(void)

loc_anims_end:

0x410CED   020   8B 06                   mov     eax, [esi]
0x410CEF   020   6A 01                   push    1
0x410CF1   024   89 F1                   mov     ecx, esi
0x410CF3   024   FF 10                   call    DWORD PTR [eax]             # zFILE_VDFS::scalar_deleting_destructor(uint)

0x410CF5   020   8D 4C 24 0C             lea     ecx, [esp+0x20-0x14]
0x410CF9   020   E8 62 05 FF FF          call    0x401260-0x410CF9-1         # zSTRING::~zSTRING(void)

0x410CFE   020   5E                      pop     esi
0x410CFF   01C   59                      pop     ecx
0x410D00   018   58                      pop     eax
0x410D01   014   83 C4 14                add     esp, 0x14
0x410D04   000   C2 04 00                ret     4


0x410D07         90 90 90 90 90 90       nop nop nop nop nop nop


# # #


loc_skip:

0x410DD5         F6 C7 08                test    bh, 8                       # Untouched
