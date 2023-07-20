# Platform specific definitions
ifdef OS
	RM 			:=	del /Q
	FixPath		 =	$(subst /,\,$1)
	mkdir		 =	mkdir $(subst /,\,$(1)) > nul 2>&1 || (exit 0)
	SCRIPTEXT	:=	.bat
else ifeq ($(shell uname), Linux)
	RM			:=	rm -f
	FixPath		 =	$1
	mkdir		 =	mkdir -p $(1)
	SCRIPTEXT	:=	.sh
endif

# Meta data
META			:=	metadata

# Include meta data
include $(META)
export VERSION=$(VBASE).$(VMAJOR).$(VMINOR)

# Directories
BUILDDIR		:=	build/
SETUPDIR		:=	setup/
BINDIR			:=	bin/
SRCDIR			:=	src/
INCDIR			:=	$(SRCDIR)inc/
FUNCDIR			:=	$(SRCDIR)func/
EXECDIR			:=	$(SRCDIR)exec/
DATADIR			:=	$(SRCDIR)data/
DLLDIR			:=	$(SRCDIR)dll/

# File extensions
EXEEXT			:=	.exe
ASMEXT			:=	.asm
INCEXT			:=	.inc
DLLEXT			:=	.dll
RCEXT			:=	.rc
RESEXT			:=	.res
DLLEXT			:=	.dll
OBJEXT			:=	.obj
NSIEXT			:=	.nsi

# Assemblers/builders
NSIS			:=	makensis
NASM			:=	nasm
GOLINK			:=	golink
GORC			:=	gorc
GETBINLIST		:=	$(call FixPath,./getBinList)$(SCRIPTEXT)
EXTRACTSYM		:=	$(call FixPath,./extractSymbols)$(SCRIPTEXT)
VERIFYSIZE		:=	$(call FixPath,./verifySize)$(SCRIPTEXT)

FLAGS_C			:=	-I$(SRCDIR)
FLAGS_A			:=	-f win32 $(FLAGS_C)
FLAGS_L			:=	/dll /entry DllMain /largeaddressaware /nxcompat /dynamicbase /ni
FLAGS_RC		:=	/ni

# TARGET
TARGET			:=	$(BUILDDIR)Ninja$(DLLEXT)
OBJ				:=	$(BINDIR)Ninja$(OBJEXT)
RC				:=	$(DLLDIR)resource$(RCEXT)
RSC				:=	$(DLLDIR)resource$(RESEXT)
SRCDLL			:=	$(DLLDIR)Ninja$(ASMEXT)
IKLG			:=	$(INCDIR)iklg.data

# WRAPPER
WRAPPER			:=	$(BUILDDIR)BugslayerUtil$(DLLEXT)
WRAPPER_OBJ		:=	$(BINDIR)BugslayerUtil$(OBJEXT)
WRAPPER_SRC		:=	$(DLLDIR)BugslayerUtil$(ASMEXT)

# SETUP
SETUP			:=	$(BUILDDIR)Ninja-$(VERSION)$(EXEEXT)
SETUPSCR		:=	$(SETUPDIR)Ninja$(NSIEXT)

# System dependencies
SYSDEP			:=	User32$(DLLEXT) Kernel32$(DLLEXT) NtDll$(DLLEXT)
WRAPPER_SYSDEP	:=	Kernel32$(DLLEXT)

# Content
CONTENT			:=	$(INCDIR)injections$(INCEXT)

# Included files
INC				:=	$(INCDIR)stackops$(INCEXT) $(INCDIR)macros$(INCEXT) $(INCDIR)engine$(INCEXT)
INC_G1			:=	$(INC) $(INCDIR)engine_g1$(INCEXT)
INC_G112		:=	$(INC) $(INCDIR)engine_g112$(INCEXT)
INC_G2			:=	$(INC) $(INCDIR)engine_g2$(INCEXT)

# Intermediate files
BIN_BASE		:=	core										\
					hook_createVdfArray							\
					hook_deploy_ani_ninja						\
					hook_deploy_camera_ninja					\
					hook_deploy_content_ninja					\
					hook_deploy_fightai_ninja					\
					hook_deploy_menu_ninja						\
					hook_deploy_music_ninja						\
					hook_deploy_ou_ninja						\
					hook_deploy_pfx_ninja						\
					hook_deploy_sfx_ninja						\
					hook_deploy_vfx_ninja						\
					hook_init_menu								\
					hook_init_content							\
					hook_linkerReplaceFunc						\
					hook_parserDeclareClass						\
					hook_parserDeclareFunc						\
					hook_parserDeclarePrototype					\
					hook_parserDeclareVar						\
					hook_parserDeclareVar_constInt				\
					hook_parserDeclareVar_constString			\
					hook_parserParseSource						\
					hook_zCPar_Symbol__GetNext					\
					hook_zCParser__LoadGlobalVars				\
					hook_unarchiveInfoMan						\
					hook_unarchiveVobs							\
					hook_unarchiveNpcs							\
					hook_setVobToTransient						\
					hook_archiveWorldCountLogicalNpc			\
					hook_archiveWorldWriteLogicalNpc			\
					hook_oCSpawnManager__Archive				\
					hook_npcReference							\
					hook_fastexit								\
					hook_CGameManager_destructor				\
					hook_libExit								\
					hook_Hlp_GetNpc								\
					hook_Hlp_IsValidNpc							\
					hook_Hlp_IsValidItem						\
					ow_ani										\
					ow_aniAlias									\
					ow_aniBatch									\
					ow_aniBlend									\
					ow_aniComb									\
					ow_aniDisable								\
					ow_aniSync									\
					ow_parserDeclareClass_showOverwrite			\
					ow_parserDeclareFunc_showOverwrite			\
					ow_parserDeclarePrototype_showOverwrite		\
					ow_parserDeclareVar_showOverwrite			\
					ow_reopenFileWarning						\
					ow_playerInfoName1							\
					ow_playerInfoName2							\
					ow_playerInfoName3							\
					ow_playerInfoName4							\
					ow_playerInfoName5
BIN_BASE_G112	:=	core										\
					hook_createVdfArray							\
					hook_deploy_ani_ninja						\
					hook_deploy_camera_ninja					\
					hook_deploy_content_ninja					\
					hook_deploy_fightai_ninja					\
					hook_deploy_menu_ninja						\
					hook_deploy_music_ninja						\
					hook_deploy_ou_ninja						\
					hook_deploy_pfx_ninja						\
					hook_deploy_sfx_ninja						\
					hook_deploy_vfx_ninja						\
					hook_init_menu								\
					hook_init_content							\
					hook_zCPar_Symbol__GetNext
BIN_BASE_G2		:=	ow_zCParser__LoadGlobalVars					\
					skip_writeAniBinFile_ModelTag				\
					skip_writeAniBinFile_ReadMeshAndTree		\
					skip_writeAniBinFile_RegisterMesh			\
					skip_writeAniBinFile_ani					\
					skip_writeAniBinFile_aniAlias				\
					skip_writeAniBinFile_aniBlend				\
					skip_writeAniBinFile_aniComb				\
					skip_writeAniBinFile_aniDisable				\
					skip_writeAniBinFile_aniSync				\
					skip_writeAniBinFile_other					\
					skip_zCFileBIN__BinWriteFloat				\
					skip_zCFileBIN__BinWriteInt					\
					skip_zCFileBIN__BinWriteString
FUNC_BASE		:=	freeVdfArray								\
					dispatch									\
					parseVersionString							\
					scriptPathInvalid							\
					debugMessage								\
					zCPar_Symbol__GetNext_fix					\
					createSymbol								\
					armParser									\
					allowRedefine								\
					injectSrc									\
					injectMds									\
					injectOU									\
					initMenu									\
					initContent									\
					conEvalFunc
EXEC_BASE		:=	createVdfArray								\
					deploy										\
					init										\
					parse										\
					misc
DATA_BASE		:=	symbols										\
					console										\
					io											\
					messages

BINARIES_G1		:=	$(BIN_BASE:%=$(BINDIR)%_g1)
BINARIES_G112	:=	$(BIN_BASE_G112:%=$(BINDIR)%_g112)
BINARIES_G2		:=	$(BIN_BASE:%=$(BINDIR)%_g2) $(BIN_BASE_G2:%=$(BINDIR)%_g2)
FUNC			:=	$(FUNC_BASE:%=$(FUNCDIR)%$(ASMEXT))
EXEC			:=	$(EXEC_BASE:%=$(EXECDIR)%$(ASMEXT))
DATA			:=	$(DATA_BASE:%=$(DATADIR)%$(ASMEXT))


# Phony rules
all : $(SETUP)

clean :
	$(RM) $(call FixPath,$(BUILDDIR)*)
	$(RM) $(call FixPath,$(BINDIR)*)
	$(RM) $(call FixPath,$(CONTENT))
	$(RM) $(call FixPath,$(INCDIR)symbols_g*$(INCEXT))
	$(RM) $(call FixPath,$(RSC))
	$(RM) $(call FixPath,$(RC))

cleanDLL :
	$(RM) $(call FixPath,$(TARGET))
	$(RM) $(call FixPath,$(WRAPPER))
	$(RM) $(call FixPath,$(RC))

remake : clean all

relink : cleanDLL all

.PHONY : all clean remake relink


# Build dependencies
$(SETUP) : $(WRAPPER) $(TARGET) LICENSE $(SETUPSCR)
	$(NSIS) /X"SetCompressor /FINAL lzma" $(SETUPSCR)

$(WRAPPER) : $(WRAPPER_OBJ) $(TARGET)
	@$(call mkdir,$(BUILDDIR))
	golink $(FLAGS_L) /fo $(call FixPath,$@) $^ $(WRAPPER_SYSDEP)

$(TARGET) : $(OBJ) $(RSC)
	@$(call mkdir,$(BUILDDIR))
	golink $(FLAGS_L) /fo $(call FixPath,$@) $^ $(SYSDEP)

$(WRAPPER_OBJ) : $(WRAPPER_SRC)
	@$(call mkdir,$(BINDIR))
	$(NASM) $(FLAGS_A) -o $@ $<

$(OBJ) : $(SRCDLL) $(CONTENT) $(IKLG)
	@$(call mkdir,$(BINDIR))
	$(NASM) $(FLAGS_A) -o $@ $<

$(RSC) : $(RC)
	gorc $(FLAGS_RC) /fo $@ /r $^

$(CONTENT) : $(BINARIES_G1) $(BINARIES_G112) $(BINARIES_G2)
	$(GETBINLIST) $(call FixPath,$@) $(SRCDIR)

$(BINDIR)core_g% : $(SRCDIR)core$(ASMEXT) $(FUNC) $(EXEC) $(DATA) $(INC_G%) $(META)
	@$(call mkdir,$(BINDIR))
	$(NASM) -DGOTHIC_BASE_VERSION=$* $(FLAGS_C) -o $@ $<
	$(VERIFYSIZE) $@ $*

$(INCDIR)symbols_g%$(INCEXT) : $(SRCDIR)core$(ASMEXT) $(FUNC) $(EXEC) $(DATA)
	$(EXTRACTSYM) $@ $* $<

$(BINDIR)%_g1 : $(SRCDIR)%$(ASMEXT) $(INCDIR)symbols_g1$(INCEXT) $(INC_G1) $(META)
	@$(call mkdir,$(BINDIR))
	$(NASM) -DGOTHIC_BASE_VERSION=1 $(FLAGS_C) -o $@ $<

$(BINDIR)%_g112 : $(SRCDIR)%$(ASMEXT) $(INCDIR)symbols_g112$(INCEXT) $(INC_G112) $(META)
	@$(call mkdir,$(BINDIR))
	$(NASM) -DGOTHIC_BASE_VERSION=112 $(FLAGS_C) -o $@ $<

$(BINDIR)%_g2 : $(SRCDIR)%$(ASMEXT) $(INCDIR)symbols_g2$(INCEXT) $(INC_G2) $(META)
	@$(call mkdir,$(BINDIR))
	$(NASM) -DGOTHIC_BASE_VERSION=2 $(FLAGS_C) -o $@ $<

$(RC) : $(META)
	@ECHO/>                                                                       "$(call FixPath,$@)"
	@ECHO 1 VERSIONINFO>>                                                         "$(call FixPath,$@)"
	@ECHO FILEVERSION $(VBASE),$(VMAJOR),$(VMINOR),^0>>                           "$(call FixPath,$@)"
	@ECHO PRODUCTVERSION $(VBASE),$(VMAJOR),$(VMINOR),^0>>                        "$(call FixPath,$@)"
	@ECHO FILEOS 0x4>>                                                            "$(call FixPath,$@)"
	@ECHO FILETYPE 0x2>>                                                          "$(call FixPath,$@)"
	@ECHO {>>                                                                     "$(call FixPath,$@)"
	@ECHO BLOCK "StringFileInfo">>                                                "$(call FixPath,$@)"
	@ECHO {>>                                                                     "$(call FixPath,$@)"
	@ECHO     BLOCK "000004B0">>                                                  "$(call FixPath,$@)"
	@ECHO     {>>                                                                 "$(call FixPath,$@)"
	@ECHO         VALUE "FileDescription", "Ninja <$(NINJA_WEBSITE)>">>           "$(call FixPath,$@)"
	@ECHO         VALUE "FileVersion", "$(VBASE).$(VMAJOR).$(VMINOR)">>           "$(call FixPath,$@)"
	@ECHO         VALUE "InternalName", "Ninja">>                                 "$(call FixPath,$@)"
	@ECHO         VALUE "LegalCopyright", "Copyright © $(RYEARS) szapp">>         "$(call FixPath,$@)"
	@ECHO         VALUE "OriginalFilename", "Ninja.dll">>                         "$(call FixPath,$@)"
	@ECHO         VALUE "ProductName", "Ninja">>                                  "$(call FixPath,$@)"
	@ECHO         VALUE "ProductVersion", "$(VBASE).$(VMAJOR).$(VMINOR)">>        "$(call FixPath,$@)"
	@ECHO     }>>                                                                 "$(call FixPath,$@)"
	@ECHO }>>                                                                     "$(call FixPath,$@)"
	@ECHO/>>                                                                      "$(call FixPath,$@)"
	@ECHO BLOCK "VarFileInfo">>                                                   "$(call FixPath,$@)"
	@ECHO {>>                                                                     "$(call FixPath,$@)"
	@ECHO     VALUE "Translation", 0x0000 0x04B^0>>                               "$(call FixPath,$@)"
	@ECHO }>>                                                                     "$(call FixPath,$@)"
	@ECHO }>>                                                                     "$(call FixPath,$@)"
