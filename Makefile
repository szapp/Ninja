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
RSCDIR			:=	rsc/
SRCDIR			:=	src/
INCDIR			:=	$(SRCDIR)inc/
FUNCDIR			:=	$(SRCDIR)func/
EXECDIR			:=	$(SRCDIR)exec/
DATADIR			:=	$(SRCDIR)data/

# File extensions
ASMEXT			:=	.asm
INCEXT			:=	.inc
PATCHEXT		:=	.patch

# Assemblers/builders
NASM			:=	nasm
WRITEPATCH		:=	$(call FixPath,./writePatch)$(SCRIPTEXT)
EXTRACTSYM		:=	$(call FixPath,./extractSymbols)$(SCRIPTEXT)

FLAGS			:=	-I$(SRCDIR)

# Targets
TARGETS_G1		:=	$(BUILDDIR)code_1C47577B$(PATCHEXT) $(BUILDDIR)code_CB86CAC3$(PATCHEXT)
TARGETS_G2		:=	$(BUILDDIR)code_EFD8A07B$(PATCHEXT)

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
					hook_init_posthero							\
					hook_linkerReplaceFunc						\
					hook_parserDeclareClass						\
					hook_parserDeclareFunc						\
					hook_parserDeclarePrototype					\
					hook_parserDeclareVar						\
					hook_parserDeclareVar_constInt				\
					hook_parserDeclareVar_constString			\
					hook_parserParseSource						\
					hook_parserParseFile						\
					hook_zCPar_Symbol__GetNext					\
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
					resolvePath									\
					debugMessage								\
					zCPar_Symbol__GetNext_fix					\
					armParser									\
					injectSrc									\
					injectMds									\
					injectOU									\
					initMenu									\
					initContent									\
					initPostHero								\
					conEvalFunc
EXEC_BASE		:=	createVdfArray								\
					deploy										\
					init										\
					parse

BINARIES_G1		:=	$(BIN_BASE:%=$(BINDIR)%_g1)
BINARIES_G2		:=	$(BIN_BASE:%=$(BINDIR)%_g2) $(BIN_BASE_G2:%=$(BINDIR)%_g2)
FUNC			:=	$(FUNC_BASE:%=$(FUNCDIR)%$(ASMEXT))
EXEC			:=	$(EXEC_BASE:%=$(EXECDIR)%$(ASMEXT))
DATA			:=	$(DATADIR)core$(ASMEXT)


# Phony rules
all : gothic1 gothic2

gothic1 : $(TARGETS_G1)

gothic2 : $(TARGETS_G2)

clean :
	$(RM) $(call FixPath,$(BUILDDIR)*)
	$(RM) $(call FixPath,$(BINDIR)*)
	$(RM) $(call FixPath,$(INCDIR)symbols_g*$(INCEXT))

remake: clean all

.PHONY: all clean remake gothic1 gothic2


# Build dependencies
$(TARGETS_G1) : $(BINARIES_G1)
	@$(call mkdir,$(BUILDDIR))
	$(WRITEPATCH) $(call FixPath,$@) 1 $(SRCDIR) $(call FixPath,$(RSCDIR)$(@F))

$(TARGETS_G2) : $(BINARIES_G2)
	@$(call mkdir,$(BUILDDIR))
	$(WRITEPATCH) $(call FixPath,$@) 2 $(SRCDIR) $(call FixPath,$(RSCDIR)$(@F))

$(BINDIR)core_g% : $(SRCDIR)core$(ASMEXT) $(FUNC) $(EXEC) $(DATA) $(INCDIR)macros$(INCEXT) $(INCDIR)engine$(INCEXT)
	@$(call mkdir,$(BINDIR))
	$(NASM) -DGOTHIC_BASE_VERSION=$* $(FLAGS) -o $@ $<

$(INCDIR)symbols_g%$(INCEXT) : $(SRCDIR)core$(ASMEXT) $(FUNC) $(EXEC) $(DATA)
	$(EXTRACTSYM) $@ $* $<

$(BINDIR)%_g1 : $(SRCDIR)%$(ASMEXT) $(INCDIR)symbols_g1$(INCEXT) $(INCDIR)engine$(INCEXT) $(INCDIR)macros$(INCEXT)
	@$(call mkdir,$(BINDIR))
	$(NASM) -DGOTHIC_BASE_VERSION=1 $(FLAGS) -o $@ $<

$(BINDIR)%_g2 : $(SRCDIR)%$(ASMEXT) $(INCDIR)symbols_g2$(INCEXT) $(INCDIR)engine$(INCEXT) $(INCDIR)macros$(INCEXT)
	@$(call mkdir,$(BINDIR))
	$(NASM) -DGOTHIC_BASE_VERSION=2 $(FLAGS) -o $@ $<
