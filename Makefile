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

# Directories
BUILDDIR		:=	build/
BINDIR			:=	bin/
SRCDIR			:=	src/
INCDIR			:=	$(SRCDIR)inc/
FUNCDIR			:=	$(SRCDIR)func/
EXECDIR			:=	$(SRCDIR)exec/
DATADIR			:=	$(SRCDIR)data/
DLLDIR			:=	$(SRCDIR)dll/

# File extensions
ASMEXT			:=	.asm
INCEXT			:=	.inc
DLLEXT			:=	.dll
RCEXT			:=	.rc
RESEXT			:=	.res
DLLEXT			:=	.dll
OBJEXT			:=	.obj

# Assemblers/builders
NASM			:=	nasm
GOLINK			:=	golink
GORC			:=	gorc
GETBINLIST		:=	$(call FixPath,./getBinList)$(SCRIPTEXT)
EXTRACTSYM		:=	$(call FixPath,./extractSymbols)$(SCRIPTEXT)

FLAGS_C			:=	-I$(SRCDIR)
FLAGS_A			:=	-f win32 $(FLAGS_C)
FLAGS_L			:=	/dll /entry DllMain /largeaddressaware /nxcompat /dynamicbase /ni
FLAGS_RC		:=	/ni

# Meta data
META			:=	metadata

# TARGET
TARGET			:=	$(BUILDDIR)dciman32$(DLLEXT)
OBJ				:=	$(BINDIR)dciman32$(OBJEXT)
RC				:=	$(DLLDIR)resource$(RCEXT)
RSC				:=	$(DLLDIR)resource$(RESEXT)
SRCDLL			:=	$(DLLDIR)dciman32$(ASMEXT)
IKLG			:=	$(INCDIR)iklg.data

# System dependencies
SYSDEP			:=	User32.dll Kernel32.dll NtDll.dll

# Content
CONTENT			:=	$(INCDIR)injections$(INCEXT)

# Included files
INC				:=	$(INCDIR)stackops$(INCEXT) $(INCDIR)macros$(INCEXT) $(INCDIR)engine$(INCEXT)
INC_G1			:=	$(INC) $(INCDIR)engine_g1$(INCEXT)
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
					hook_unarchiveInfoMan						\
					hook_unarchiveVobs							\
					hook_setVobToTransient						\
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
					ow_data_redef_char							\
					ow_parserDeclareClass_showOverwrite			\
					ow_parserDeclareFunc_showOverwrite			\
					ow_parserDeclarePrototype_showOverwrite		\
					ow_parserDeclareVar_showOverwrite			\
					ow_version
BIN_BASE_G2		:=	skip_writeAniBinFile_ModelTag				\
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
BINARIES_G2		:=	$(BIN_BASE:%=$(BINDIR)%_g2) $(BIN_BASE_G2:%=$(BINDIR)%_g2)
FUNC			:=	$(FUNC_BASE:%=$(FUNCDIR)%$(ASMEXT))
EXEC			:=	$(EXEC_BASE:%=$(EXECDIR)%$(ASMEXT))
DATA			:=	$(DATA_BASE:%=$(DATADIR)%$(ASMEXT))


# Include meta data
include $(META)
export VERSION=$(VBASE).$(VMAJOR)

# Phony rules
all : $(TARGET)

clean :
	$(RM) $(call FixPath,$(BUILDDIR)*)
	$(RM) $(call FixPath,$(BINDIR)*)
	$(RM) $(call FixPath,$(CONTENT))
	$(RM) $(call FixPath,$(INCDIR)symbols_g*$(INCEXT))
	$(RM) $(call FixPath,$(RSC))
	$(RM) $(call FixPath,$(RC))

remake: clean all

.PHONY: all clean remake


# Build dependencies
$(TARGET) : $(OBJ) $(RSC)
	@$(call mkdir,$(BUILDDIR))
	golink $(FLAGS_L) /fo $@ $^ $(SYSDEP)

$(OBJ) : $(SRCDLL) $(CONTENT) $(IKLG)
	@$(call mkdir,$(BINDIR))
	$(NASM) $(FLAGS_A) -o $@ $<

$(RSC) : $(RC)
	gorc $(FLAGS_RC) /fo $@ /r $^

$(CONTENT) : $(BINARIES_G1) $(BINARIES_G2)
	$(GETBINLIST) $(call FixPath,$@) $(SRCDIR)

$(BINDIR)core_g% : $(SRCDIR)core$(ASMEXT) $(FUNC) $(EXEC) $(DATA) $(INC_G%) $(META)
	@$(call mkdir,$(BINDIR))
	$(NASM) -DGOTHIC_BASE_VERSION=$* $(FLAGS_C) -o $@ $<

$(INCDIR)symbols_g%$(INCEXT) : $(SRCDIR)core$(ASMEXT) $(FUNC) $(EXEC) $(DATA)
	$(EXTRACTSYM) $@ $* $<

$(BINDIR)%_g1 : $(SRCDIR)%$(ASMEXT) $(INCDIR)symbols_g1$(INCEXT) $(INC_G1) $(META)
	@$(call mkdir,$(BINDIR))
	$(NASM) -DGOTHIC_BASE_VERSION=1 $(FLAGS_C) -o $@ $<

$(BINDIR)%_g2 : $(SRCDIR)%$(ASMEXT) $(INCDIR)symbols_g2$(INCEXT) $(INC_G2) $(META)
	@$(call mkdir,$(BINDIR))
	$(NASM) -DGOTHIC_BASE_VERSION=2 $(FLAGS_C) -o $@ $<

$(RC) : $(META)
	@ECHO/>                                                                       "$(call FixPath,$@)"
	@ECHO 1 VERSIONINFO>>                                                         "$(call FixPath,$@)"
	@ECHO FILEVERSION $(VBASE),$(VMAJOR),0,^0>>                                   "$(call FixPath,$@)"
	@ECHO PRODUCTVERSION $(VBASE),$(VMAJOR),0,^0>>                                "$(call FixPath,$@)"
	@ECHO FILEOS 0x4>>                                                            "$(call FixPath,$@)"
	@ECHO FILETYPE 0x2>>                                                          "$(call FixPath,$@)"
	@ECHO {>>                                                                     "$(call FixPath,$@)"
	@ECHO BLOCK "StringFileInfo">>                                                "$(call FixPath,$@)"
	@ECHO {>>                                                                     "$(call FixPath,$@)"
	@ECHO     BLOCK "000004B0">>                                                  "$(call FixPath,$@)"
	@ECHO     {>>                                                                 "$(call FixPath,$@)"
	@ECHO         VALUE "CompanyName", "mud-freak (@szapp)">>                     "$(call FixPath,$@)"
	@ECHO         VALUE "FileDescription", "Ninja <$(NINJA_WEBSITE)>">>           "$(call FixPath,$@)"
	@ECHO         VALUE "FileVersion", "$(VBASE).$(VMAJOR)">>                     "$(call FixPath,$@)"
	@ECHO         VALUE "InternalName", "DCIMAN32">>                              "$(call FixPath,$@)"
	@ECHO         VALUE "LegalCopyright", "(C) $(RYEARS)  mud-freak (@szapp)">>   "$(call FixPath,$@)"
	@ECHO         VALUE "OriginalFilename", "DCIMAN32.DLL">>                      "$(call FixPath,$@)"
	@ECHO         VALUE "ProductName", "Ninja">>                                  "$(call FixPath,$@)"
	@ECHO         VALUE "ProductVersion", "$(VBASE).$(VMAJOR)">>                  "$(call FixPath,$@)"
	@ECHO     }>>                                                                 "$(call FixPath,$@)"
	@ECHO }>>                                                                     "$(call FixPath,$@)"
	@ECHO/>>                                                                      "$(call FixPath,$@)"
	@ECHO BLOCK "VarFileInfo">>                                                   "$(call FixPath,$@)"
	@ECHO {>>                                                                     "$(call FixPath,$@)"
	@ECHO     VALUE "Translation", 0x0000 0x04B^0>>                               "$(call FixPath,$@)"
	@ECHO }>>                                                                     "$(call FixPath,$@)"
	@ECHO }>>                                                                     "$(call FixPath,$@)"
