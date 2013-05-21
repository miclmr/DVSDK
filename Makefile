include Rules.make

DEFAULT_LINUXKERNEL_CONFIG=davinci_dm365_defconfig
DEFAULT_UBOOT_CONFIG=davinci_dm365evm_config
MATRIX_PLATFORM=dm365

KERNEL_VERSION= $(shell cat $(LINUXKERNEL_INSTALL_DIR)/include/config/kernel.release)

.PHONY:	all clean components help cmem cmem_clean cmem_install dmai dmai_clean dmai_install dm365mm dm365mm_clean dm365mm_install linux linux_clean linux_install psp_examples psp_example_clean psp_example_install irq irq_clean irq_install edma edma_clean edma_install install demos demos_clean demos_install u-boot u-boot_clean u-boot_install dvtb_install matrix matrix_clean matrix_install gstreamer_ti gstreamer_ti_install loadmodule_install

#==============================================================================
# Default build target
#==============================================================================
default: all

#==============================================================================
# Build target build necessary components to enable all other build targets.
#==============================================================================
components: linux cmem dm365mm irq edma ceexamples dmai

#==============================================================================
# Clean up the targets built by 'make all'.
#==============================================================================
clean:	linux_clean cmem_clean dm365mm_clean irq_clean edma_clean dmai_clean psp_examples_clean ceexamples_clean demos_clean u-boot_clean matrix_clean dvtb_clean

#==============================================================================
# Build everything rebuildable.
#==============================================================================
all: components psp_examples ceexamples demos u-boot matrix gstreamer_ti dvtb

#==============================================================================
# Install everything
#==============================================================================
install: linux_install cmem_install dm365mm_install dmai_install psp_examples_install ceexamples_install irq_install edma_install demos_install u-boot_install matrix_install gstreamer_ti_install loadmodule_install dvtb_install

#==============================================================================
# A help message target.
#==============================================================================
help:
	@echo
	@echo "Available build targets are:"
	@echo
	@echo "  components                 : Rebuild all base components (See Note below)"
	@echo
	@echo "  all                        : Builds all components and applications/examples"
	@echo "  clean                      : Remove files generated by the 'all' target"
	@echo
	@echo "  install                    : Install all the targets in "
	@echo "                               $(EXEC_DIR)"
	@echo
	@echo "  demos                      : Build the DVSDK demos for $(PLATFORM)"
	@echo "  demos_clean                : Remove generated DVSDK demo files."
	@echo "  demos_install              : Install DVSDK demos"
	@echo
	@echo "  dvtb                       : Build DVTB for $(PLATFORM)"
	@echo "  dvtb_clean                 : Remove generated DVTB files"
	@echo "  dvtb_install               : Install dvtb"
	@echo
	@echo "  cmem                       : Build the CMEM kernel module"
	@echo "  cmem_clean                 : Remove generated cmem files."
	@echo "  cmem_install               : Install cmemk module"
	@echo
	@echo "  irq                        : Build the irq kernel module"
	@echo "  irq_clean                  : Remove generated irq files."
	@echo "  irq_install                : Install irqk module"
	@echo
	@echo "  edma                       : Build the edma kernel module"
	@echo "  edma_clean                 : Remove generated edma files."
	@echo "  edma_install               : Install edmak module"
	@echo
	@echo "  dm365mm                    : Build the dm365mm kernel module"
	@echo "  dm365mm_clean              : Remove generated dm365mm files"
	@echo "  dm365mm_install            : Install dm365mm module"
	@echo
	@echo "  dmai                       : Build DMAI"
	@echo "  dmai_clean                 : Remove generated DMAI files."
	@echo "  dmai_install               : Install dmai app"
	@echo
	@echo "  ceexamples                 : Build CE codecs, extensions, servers and apps"
	@echo "  ceexamples_clean           : Remove generated CE example files."
	@echo
	@echo "  linux                      : Build Linux kernel uImage and module"
	@echo "  linux_config               : Launch Linux kernel menuconfig"
	@echo "  linux_clean                : Remove generated Linux kernel files"
	@echo "  linux_install              : Install kernel binary and modules"
	@echo
	@echo "  u-boot                     : Build the u-boot boot loader"
	@echo "  u-boot_clean               : Remove generated u-boot files"
	@echo "  u-boot_install             : Install the u-boot image"
	@echo
	@echo "  psp_examples               : Build Linux examples"
	@echo "  psp_examples_clean         : Remove all generated PSP examples"
	@echo "  psp_examples_install       : Install psp examples"
	@echo
	@echo "  matrix                     : Build matrix application launcher"
	@echo "  matrix_clean               : Remove all matrix files"
	@echo "  matrix_install             : Install matrix"
	@echo
	@echo "  gstreamer_ti               : Build gstreamer-ti plugins"
	@echo "  gstreamer_ti_install       : Install gstreamer-ti plugins"
	@echo
	@echo "==============================================================================="
	@echo "NOTE: The 'make components' target must be issued once upon installation for"
	@echo "      all other targets to build properly.  A 'make clean' target should be"
	@echo "      issued before this target"
	@echo

#==============================================================================
# Build the dvsdk demos for the configured platform. Also, an explicit cleanup
# target is defined.
#==============================================================================
demos:
	. $(DVSDK_INSTALL_DIR)/linux-devkit/environment-setup ; cd $(DEMO_INSTALL_DIR)/qtInterface ; qmake ; $(MAKE) PLATFORM=$(PLATFORM)
	$(MAKE) -C $(DEMO_INSTALL_DIR) $(PLATFORM) DVSDK_INSTALL_DIR=$(DVSDK_INSTALL_DIR) XDC_INSTALL_DIR=$(XDC_INSTALL_DIR) CE_INSTALL_DIR=$(CE_INSTALL_DIR) FC_INSTALL_DIR=$(FC_INSTALL_DIR) CMEM_INSTALL_DIR=$(CMEM_INSTALL_DIR) CODEC_INSTALL_DIR=$(CODEC_INSTALL_DIR) XDAIS_INSTALL_DIR=$(XDAIS_INSTALL_DIR) LINK_INSTALL_DIR=$(LINK_INSTALL_DIR) DMAI_INSTALL_DIR=$(DMAI_INSTALL_DIR) MVTOOL_DIR=$(MVTOOL_DIR) CC=$(CSTOOL_PREFIX)gcc AR=$(CSTOOL_PREFIX)ar CROSS_COMPILE=$(MVTOOL_PREFIX) LINUXLIBS_INSTALL_DIR=$(LINUXLIBS_INSTALL_DIR) PLATFORM=$(PLATFORM)

demos_clean:
	. $(DVSDK_INSTALL_DIR)/linux-devkit/environment-setup ; cd $(DEMO_INSTALL_DIR)/qtInterface ; qmake ; $(MAKE) PLATFORM=$(PLATFORM) clean
	$(MAKE) -C $(DEMO_INSTALL_DIR) clean DVSDK_INSTALL_DIR=$(DVSDK_INSTALL_DIR) XDC_INSTALL_DIR=$(XDC_INSTALL_DIR) CE_INSTALL_DIR=$(CE_INSTALL_DIR) FC_INSTALL_DIR=$(FC_INSTALL_DIR) CMEM_INSTALL_DIR=$(CMEM_INSTALL_DIR) CODEC_INSTALL_DIR=$(CODEC_INSTALL_DIR) XDAIS_INSTALL_DIR=$(XDAIS_INSTALL_DIR) LINK_INSTALL_DIR=$(LINK_INSTALL_DIR) DMAI_INSTALL_DIR=$(DMAI_INSTALL_DIR) MVTOOL_DIR=$(MVTOOL_DIR) CC=$(CSTOOL_PREFIX)gcc CROSS_COMPILE=$(MVTOOL_PREFIX) LINUXLIBS_INSTALL_DIR=$(LINUXLIBS_INSTALL_DIR) PLATFORM=$(PLATFORM)

demos_install:
	install -d $(EXEC_DIR)//usr/share/ti/dvsdk-demos
	. $(DVSDK_INSTALL_DIR)/linux-devkit/environment-setup ; cd $(DEMO_INSTALL_DIR)/qtInterface ; qmake ; $(MAKE) PLATFORM=$(PLATFORM) EXEC_DIR=$(EXEC_DIR)/usr/share/ti/dvsdk-demos install
	$(MAKE) -C $(DEMO_INSTALL_DIR) install DVSDK_INSTALL_DIR=$(DVSDK_INSTALL_DIR) XDC_INSTALL_DIR=$(XDC_INSTALL_DIR) CE_INSTALL_DIR=$(CE_INSTALL_DIR) FC_INSTALL_DIR=$(FC_INSTALL_DIR) CMEM_INSTALL_DIR=$(CMEM_INSTALL_DIR) CODEC_INSTALL_DIR=$(CODEC_INSTALL_DIR) XDAIS_INSTALL_DIR=$(XDAIS_INSTALL_DIR) LINK_INSTALL_DIR=$(LINK_INSTALL_DIR) DMAI_INSTALL_DIR=$(DMAI_INSTALL_DIR) MVTOOL_DIR=$(MVTOOL_DIR) CC=$(CSTOOL_PREFIX)gcc CROSS_COMPILE=$(MVTOOL_PREFIX) LINUXLIBS_INSTALL_DIR=$(LINUXLIBS_INSTALL_DIR) EXEC_DIR=$(EXEC_DIR)/usr/share/ti/dvsdk-demos PLATFORM=$(PLATFORM)

#==============================================================================
# Build the Digital Video Test Bench for the configured platform. Also, an
# explicit cleanup target is defined.
#==============================================================================
dvtb:
	$(MAKE) -C $(DVTB_INSTALL_DIR) $(PLATFORM) CODECS=TSPA
	@echo
	@echo "dvtb can be found under $(DVTB_INSTALL_DIR)/packages/ti/sdo/dvtb/$(PLATFORM)/bin"

dvtb_clean:
	$(MAKE) -C $(DVTB_INSTALL_DIR) clean

dvtb_install:
	install -d $(EXEC_DIR)/usr/share/ti/dvtb/scripts
	install $(DVTB_INSTALL_DIR)/packages/ti/sdo/dvtb/$(PLATFORM)/bin/* $(EXEC_DIR)/usr/share/ti/dvtb
	install $(DVTB_INSTALL_DIR)/packages/ti/sdo/dvtb/scripts/$(PLATFORM)/* $(EXEC_DIR)/usr/share/ti/dvtb/scripts

#==============================================================================
# Build the Linux kernel. Also, an explicit cleanup target is defined.
#==============================================================================
linux:
	@if ! test -e $(LINUXKERNEL_INSTALL_DIR)/.config; then $(MAKE) -C $(LINUXKERNEL_INSTALL_DIR) ARCH=arm CROSS_COMPILE=$(CSTOOL_PREFIX) $(DEFAULT_LINUXKERNEL_CONFIG) ; fi
	$(MAKE) -C $(LINUXKERNEL_INSTALL_DIR) ARCH=arm CROSS_COMPILE=$(CSTOOL_PREFIX) uImage
	$(MAKE) -C $(LINUXKERNEL_INSTALL_DIR) ARCH=arm CROSS_COMPILE=$(CSTOOL_PREFIX) modules

linux_config:
	@if ! test -e $(LINUXKERNEL_INSTALL_DIR)/.config; then $(MAKE) -C $(LINUXKERNEL_INSTALL_DIR) ARCH=arm CROSS_COMPILE=$(CSTOOL_PREFIX) $(DEFAULT_LINUXKERNEL_CONFIG) ; fi
	$(MAKE) -C $(LINUXKERNEL_INSTALL_DIR) ARCH=arm CROSS_COMPILE=$(CSTOOL_PREFIX) menuconfig
	@echo
	@echo "NOTE: **** Kernel configuration is saved and will be used during 'make linux' execution."
	@echo
	
linux_clean:
	$(MAKE) -C $(LINUXKERNEL_INSTALL_DIR) mrproper
	$(MAKE) -C $(LINUXKERNEL_INSTALL_DIR) ARCH=arm CROSS_COMPILE=$(CSTOOL_PREFIX) clean

linux_install:
	install -d $(EXEC_DIR)/boot
	install  $(LINUXKERNEL_INSTALL_DIR)/arch/arm/boot/uImage $(EXEC_DIR)/boot
	install  $(LINUXKERNEL_INSTALL_DIR)/vmlinux $(EXEC_DIR)/boot
	install  $(LINUXKERNEL_INSTALL_DIR)/System.map $(EXEC_DIR)/boot
	$(MAKE) -C $(LINUXKERNEL_INSTALL_DIR) ARCH=arm CROSS_COMPILE=$(CSTOOL_PREFIX) INSTALL_MOD_PATH=$(EXEC_DIR)/ modules_install

#==============================================================================
# Build u-boot. Also, an explicit cleanup target is defined.
#==============================================================================
u-boot:
	$(MAKE) -C $(PSP_INSTALL_DIR)/u-boot-* CROSS_COMPILE=$(CSTOOL_PREFIX) $(DEFAULT_UBOOT_CONFIG)
	$(MAKE) -C $(PSP_INSTALL_DIR)/u-boot-* CROSS_COMPILE=$(CSTOOL_PREFIX)

u-boot_clean: 
	$(MAKE) -C $(PSP_INSTALL_DIR)/u-boot-* CROSS_COMPILE=$(CSTOOL_PREFIX) distclean

u-boot_install:
	install -d $(EXEC_DIR)/boot
	install $(PSP_INSTALL_DIR)/u-boot-*/u-boot.bin $(EXEC_DIR)/boot
	install $(PSP_INSTALL_DIR)/u-boot-*/u-boot.map $(EXEC_DIR)/boot

#==============================================================================
# Build the PSP Linux examples. Also, an explicit cleanup target is defined.
#==============================================================================
psp_examples:
	$(MAKE) -C $(PSP_INSTALL_DIR)/linux-driver-examples-* KERNEL_DIR=$(LINUXKERNEL_INSTALL_DIR) CROSS_COMPILE=$(CSTOOL_PREFIX) PLATFORM=$(PLATFORM) LINUXLIBS_DIR=$(LINUXLIBS_INSTALL_DIR)

psp_examples_clean:
	$(MAKE) -C $(PSP_INSTALL_DIR)/linux-driver-examples-* KERNEL_DIR=$(LINUXKERNEL_INSTALL_DIR) CROSS_COMPILE=$(CSTOOL_PREFIX) PLATFORM=$(PLATFORM) LINUXLIBS_DIR=$(LINUXLIBS_INSTALL_DIR) clean

psp_examples_install:
	$(MAKE) -C $(PSP_INSTALL_DIR)/linux-driver-examples-* KERNEL_DIR=$(LINUXKERNEL_INSTALL_DIR) CROSS_COMPILE=$(CSTOOL_PREFIX) PLATFORM=$(PLATFORM) LINUXLIBS_DIR=$(LINUXLIBS_INSTALL_DIR) FINAL_DEST=$(EXEC_DIR)/usr/share/ti/linux-driver-examples  install
	
#==============================================================================
# Build the CMEM kernel module for the configured platform, and make sure the
# kernel_binaries directory is kept in sync. Also, an explicit cleanup target
# is defined.
#==============================================================================
cmem:
	$(MAKE) -C $(CMEM_INSTALL_DIR)/packages/ti/sdo/linuxutils/cmem/src/interface ../../lib/cmem.a470MV
	$(MAKE) -C $(CMEM_INSTALL_DIR)/packages/ti/sdo/linuxutils/cmem/src/module

cmem_clean:
	$(MAKE) -C $(CMEM_INSTALL_DIR)/packages/ti/sdo/linuxutils/cmem/src/module clean
	$(MAKE) -C $(CMEM_INSTALL_DIR)/packages/ti/sdo/linuxutils/cmem/src/interface clean

cmem_install:
	install -d $(EXEC_DIR)/lib/modules/$(KERNEL_VERSION)/kernel/drivers/dsp
	install $(CMEM_INSTALL_DIR)/packages/ti/sdo/linuxutils/cmem/src/module/cmemk.ko $(EXEC_DIR)/lib/modules/$(KERNEL_VERSION)/kernel/drivers/dsp

#==============================================================================
# Build the irq kernel module for the configured platform, and make sure the
# kernel_binaries directory is kept in sync. Also, an explicit cleanup target
# is defined.
#==============================================================================
irq:
	$(MAKE) -C $(CMEM_INSTALL_DIR)/packages/ti/sdo/linuxutils/irq/src/module

irq_clean:
	$(MAKE) -C $(CMEM_INSTALL_DIR)/packages/ti/sdo/linuxutils/cmem/src/module clean

irq_install:
	install -d $(EXEC_DIR)/lib/modules/$(KERNEL_VERSION)/kernel/drivers/dsp
	install $(CMEM_INSTALL_DIR)/packages/ti/sdo/linuxutils/irq/src/module/irqk.ko $(EXEC_DIR)/lib/modules/$(KERNEL_VERSION)/kernel/drivers/dsp

#==============================================================================
# Build the edma kernel module for the configured platform, and make sure the
# kernel_binaries directory is kept in sync. Also, an explicit cleanup target
# is defined.
#==============================================================================
edma:
	$(MAKE) -C $(CMEM_INSTALL_DIR)/packages/ti/sdo/linuxutils/edma/src/interface ../../lib/edma.a470MV
	$(MAKE) -C $(CMEM_INSTALL_DIR)/packages/ti/sdo/linuxutils/edma/src/module

edma_clean:
	$(MAKE) -C $(CMEM_INSTALL_DIR)/packages/ti/sdo/linuxutils/edma/src/module clean
	$(MAKE) -C $(CMEM_INSTALL_DIR)/packages/ti/sdo/linuxutils/edma/src/interface clean

edma_install:
	install -d $(EXEC_DIR)/lib/modules/$(KERNEL_VERSION)/kernel/drivers/dsp
	install $(CMEM_INSTALL_DIR)/packages/ti/sdo/linuxutils/edma/src/module/edmak.ko $(EXEC_DIR)/lib/modules/$(KERNEL_VERSION)/kernel/drivers/dsp

#==============================================================================
# Build the dm355mm kernel module (if the configured platform is dm355). Also,
# an explicit cleanup target is defined.
#==============================================================================
dm365mm:
	$(MAKE) -C $(DM365MM_MODULE_INSTALL_DIR)/module LINUXKERNEL_INSTALL_DIR=$(LINUXKERNEL_INSTALL_DIR)  MVTOOL_PREFIX=$(CSTOOL_PREFIX)
	$(MAKE) -C $(DM365MM_MODULE_INSTALL_DIR)/interface LINUXKERNEL_INSTALL_DIR=$(LINUXKERNEL_INSTALL_DIR)  MVTOOL_PREFIX=$(CSTOOL_PREFIX)

dm365mm_clean:
	$(MAKE) -C $(DM365MM_MODULE_INSTALL_DIR)/module LINUXKERNEL_INSTALL_DIR=$(LINUXKERNEL_INSTALL_DIR)  MVTOOL_PREFIX=$(CSTOOL_PREFIX) clean
	$(MAKE) -C $(DM365MM_MODULE_INSTALL_DIR)/interface LINUXKERNEL_INSTALL_DIR=$(LINUXKERNEL_INSTALL_DIR)  MVTOOL_PREFIX=$(CSTOOL_PREFIX) clean

dm365mm_install:
	install -d $(EXEC_DIR)/lib/modules/$(KERNEL_VERSION)/kernel/drivers/dsp
	install $(DM365MM_MODULE_INSTALL_DIR)/module/dm365mmap.ko  $(EXEC_DIR)/lib/modules/$(KERNEL_VERSION)/kernel/drivers/dsp

#==============================================================================
# Build the Davinci Multimedia Application Interface for the configured
# platform. Also, an explicit cleanup target is defined.
#==============================================================================
dmai:
	$(MAKE) -C $(DMAI_INSTALL_DIR) PLATFORM=$(PLATFORM)_al \
	CE_INSTALL_DIR_$(PLATFORM)_al=$(CE_INSTALL_DIR) \
	CODEC_INSTALL_DIR_$(PLATFORM)_al=$(CODEC_INSTALL_DIR) \
	CMEM_INSTALL_DIR_$(PLATFORM)_al=$(CMEM_INSTALL_DIR) \
	FC_INSTALL_DIR_$(PLATFORM)_al=$(FC_INSTALL_DIR) \
	XDAIS_INSTALL_DIR_$(PLATFORM)_al=$(XDAIS_INSTALL_DIR) \
	LINUXLIBS_INSTALL_DIR_$(PLATFORM)_al=$(LINUXLIBS_INSTALL_DIR) \
	LINUXKERNEL_INSTALL_DIR_$(PLATFORM)_al=$(LINUXKERNEL_INSTALL_DIR) \
	CROSS_COMPILE_$(PLATFORM)_al=$(CSTOOL_PREFIX) \
	XDC_INSTALL_DIR_$(PLATFORM)_al=$(XDC_INSTALL_DIR) \
	VERBOSE=false \
	all

	
dmai_clean:
	$(MAKE) -C $(DMAI_INSTALL_DIR) PLATFORM=$(PLATFORM)_al \
	XDC_INSTALL_DIR_$(PLATFORM)_al=$(XDC_INSTALL_DIR) \
	clean

dmai_install:
	$(MAKE) -C $(DMAI_INSTALL_DIR) PLATFORM=$(PLATFORM)_al \
	EXEC_DIR_$(PLATFORM)_al=$(EXEC_DIR)/usr/share/ti/ti-dmai-apps \
	install

###############################################################################
# Build codec engine examples
###############################################################################
ceexamples_apps:
	make -C $(CE_INSTALL_DIR)/examples/ti/sdo/ce/examples/apps \
	DEVICES="DM365" \
	GPPOS=LINUX_GCC \
	PROGRAMS=APP_LOCAL \
	CE_INSTALL_DIR=$(CE_INSTALL_DIR) \
	XDC_INSTALL_DIR=$(XDC_INSTALL_DIR) \
	XDAIS_INSTALL_DIR=$(XDAIS_INSTALL_DIR) \
	FC_INSTALL_DIR=$(FC_INSTALL_DIR) \
	CMEM_INSTALL_DIR=$(CMEM_INSTALL_DIR) \
	CGTOOLS_V5T=$(CSTOOL_DIR) \
	all 

ceexamples_apps_clean:
	make -C $(CE_INSTALL_DIR)/examples/ti/sdo/ce/examples/apps \
	DEVICES="DM365" \
	GPPOS=LINUX_GCC \
	PROGRAMS=APP_LOCAL \
	CE_INSTALL_DIR=$(CE_INSTALL_DIR) \
	XDC_INSTALL_DIR=$(XDC_INSTALL_DIR) \
	XDAIS_INSTALL_DIR=$(XDAIS_INSTALL_DIR) \
	FC_INSTALL_DIR=$(FC_INSTALL_DIR) \
	CMEM_INSTALL_DIR=$(CMEM_INSTALL_DIR) \
	CGTOOLS_V5T=$(CSTOOL_DIR) \
	clean 

ceexamples_apps_install:
	@echo 
	@echo "**** Don't have working install target ****"
	@echo "Copy the required application binaries and data files from $(CE_INSTALL_DIR)/examples/ti/sdo/ce/examples/apps to target filesystem. "
	@echo 

ceexamples_extensions:
	make -C $(CE_INSTALL_DIR)/examples/ti/sdo/ce/examples/extensions \
	DEVICES="DM365" \
	GPPOS=LINUX_GCC \
	PROGRAMS=APP_LOCAL \
	CE_INSTALL_DIR=$(CE_INSTALL_DIR) \
	XDC_INSTALL_DIR=$(XDC_INSTALL_DIR) \
	XDAIS_INSTALL_DIR=$(XDAIS_INSTALL_DIR) \
	FC_INSTALL_DIR=$(FC_INSTALL_DIR) \
	CMEM_INSTALL_DIR=$(CMEM_INSTALL_DIR) \
	CGTOOLS_V5T=$(CSTOOL_DIR) \
	all 

ceexamples_extensions_clean:
	make -C $(CE_INSTALL_DIR)/examples/ti/sdo/ce/examples/apps \
	DEVICES="DM365" \
	GPPOS=LINUX_GCC \
	PROGRAMS=APP_LOCAL \
	CE_INSTALL_DIR=$(CE_INSTALL_DIR) \
	XDC_INSTALL_DIR=$(XDC_INSTALL_DIR) \
	XDAIS_INSTALL_DIR=$(XDAIS_INSTALL_DIR) \
	FC_INSTALL_DIR=$(FC_INSTALL_DIR) \
	CMEM_INSTALL_DIR=$(CMEM_INSTALL_DIR) \
	CGTOOLS_V5T=$(CSTOOL_DIR) \
	clean 

ceexamples_extensions_install:
	@echo 
	@echo "**** Don't have working install target ****"
	@echo "Copy the required application binaries and data files from $(CE_INSTALL_DIR)/examples/ti/sdo/ce/examples/extensions to target filesystem. "
	@echo 


ceexamples_servers:
	make -C $(CE_INSTALL_DIR)/examples/ti/sdo/ce/examples/servers \
	DEVICES="DM365" \
	GPPOS=LINUX_GCC \
	PROGRAMS=APP_LOCAL \
	CE_INSTALL_DIR=$(CE_INSTALL_DIR) \
	XDC_INSTALL_DIR=$(XDC_INSTALL_DIR) \
	XDAIS_INSTALL_DIR=$(XDAIS_INSTALL_DIR) \
	FC_INSTALL_DIR=$(FC_INSTALL_DIR) \
	CMEM_INSTALL_DIR=$(CMEM_INSTALL_DIR) \
	CGTOOLS_V5T=$(CSTOOL_DIR) \
	all 

ceexamples_servers_clean:
	make -C $(CE_INSTALL_DIR)/examples/ti/sdo/ce/examples/servers \
	DEVICES="DM365" \
	GPPOS=LINUX_GCC \
	PROGRAMS=APP_LOCAL \
	CE_INSTALL_DIR=$(CE_INSTALL_DIR) \
	XDC_INSTALL_DIR=$(XDC_INSTALL_DIR) \
	XDAIS_INSTALL_DIR=$(XDAIS_INSTALL_DIR) \
	FC_INSTALL_DIR=$(FC_INSTALL_DIR) \
	CMEM_INSTALL_DIR=$(CMEM_INSTALL_DIR) \
	CGTOOLS_V5T=$(CSTOOL_DIR) \
	clean 

ceexamples_servers_install:
	@echo 
	@echo "**** Don't have working install target ****"
	@echo "Copy the required application binaries and data files from $(CE_INSTALL_DIR)/examples/ti/sdo/ce/examples/servers to target filesystem. "
	@echo 


ceexamples_codecs:
	make -C $(CE_INSTALL_DIR)/examples/ti/sdo/ce/examples/codecs \
	DEVICES="DM365" \
	GPPOS=LINUX_GCC \
	PROGRAMS=APP_LOCAL \
	CE_INSTALL_DIR=$(CE_INSTALL_DIR) \
	XDC_INSTALL_DIR=$(XDC_INSTALL_DIR) \
	XDAIS_INSTALL_DIR=$(XDAIS_INSTALL_DIR) \
	FC_INSTALL_DIR=$(FC_INSTALL_DIR) \
	CMEM_INSTALL_DIR=$(CMEM_INSTALL_DIR) \
	CGTOOLS_V5T=$(CSTOOL_DIR) \
	all 

ceexamples_codecs_clean:
	make -C $(CE_INSTALL_DIR)/examples/ti/sdo/ce/examples/codecs \
	DEVICES="DM365" \
	GPPOS=LINUX_GCC \
	PROGRAMS=APP_LOCAL \
	CE_INSTALL_DIR=$(CE_INSTALL_DIR) \
	XDC_INSTALL_DIR=$(XDC_INSTALL_DIR) \
	XDAIS_INSTALL_DIR=$(XDAIS_INSTALL_DIR) \
	FC_INSTALL_DIR=$(FC_INSTALL_DIR) \
	CMEM_INSTALL_DIR=$(CMEM_INSTALL_DIR) \
	CGTOOLS_V5T=$(CSTOOL_DIR) \
	clean 

ceexamples_codecs_install:
	@echo 
	@echo "**** Don't have working install target ****"
	@echo "Copy the required application binaries and data files from $(CE_INSTALL_DIR)/examples/ti/sdo/ce/examples/codecs to target filesystem. "
	@echo 

ceexamples: ceexamples_codecs ceexamples_extensions ceexamples_servers ceexamples_apps
 
ceexamples_clean: ceexamples_codecs_clean ceexamples_extensions_clean ceexamples_servers_clean ceexamples_apps_clean

ceexamples_install: ceexamples_codecs_install ceexamples_extensions_install ceexamples_servers_install ceexamples_apps_install

################################################################################
# Build Martix GUI Appication Launcher
################################################################################
matrix:
	. $(DVSDK_INSTALL_DIR)/linux-devkit/environment-setup ; cd $(DVSDK_INSTALL_DIR)/example-applications/matrix-gui-* ; qmake QMAKE_CXXFLAGS_RELEASE+=-DPlatform_$(MATRIX_PLATFORM); $(MAKE) PLATFORM=$(MATRIX_PLATFORM)
	chmod 755 $(DVSDK_INSTALL_DIR)/example-applications/matrix-gui-*/$(MATRIX_PLATFORM)/bin/*

matrix_clean:
	. $(DVSDK_INSTALL_DIR)/linux-devkit/environment-setup; cd $(DVSDK_INSTALL_DIR)/example-applications/matrix-gui-* ; qmake ; $(MAKE) distclean

matrix_install:
	install -d $(EXEC_DIR)/etc/init.d
	install -m 0755 $(DVSDK_INSTALL_DIR)/example-applications/matrix-gui-*/$(MATRIX_PLATFORM)/etc/init $(EXEC_DIR)/etc/init.d/matrix-gui-e

	install -d $(EXEC_DIR)/usr/bin
	cp -ar $(DVSDK_INSTALL_DIR)/example-applications/matrix-gui-*/$(MATRIX_PLATFORM)/bin/* \
	$(EXEC_DIR)/usr/bin/
	install -m 0755 $(DVSDK_INSTALL_DIR)/example-applications/matrix-gui-*/matrix_gui $(EXEC_DIR)/usr/bin/matrix_guiE

	install -d $(EXEC_DIR)/usr/share/matrix
	cp -ar $(DVSDK_INSTALL_DIR)/example-applications/matrix-gui-*/$(MATRIX_PLATFORM)/html \
	$(EXEC_DIR)/usr/share/matrix/

	install -d $(EXEC_DIR)/usr/share/matrix
	cp -ar $(DVSDK_INSTALL_DIR)/example-applications/matrix-gui-*/images/ \
	$(EXEC_DIR)/usr/share/matrix/

################################################################################
# Build Martix GUI Appication Launcher
################################################################################
gstreamer_ti:
	. $(DVSDK_INSTALL_DIR)/linux-devkit/environment-setup ; cd $(DVSDK_INSTALL_DIR)/gstreamer-ti_svn* ;$(MAKE) -f Makefile.external DVSDK_PATH=$(DVSDK_INSTALL_DIR) $(PLATFORM)

gstreamer_ti_install:
	install -d $(EXEC_DIR)/usr/lib/gstreamer-0.10
	cp $(DVSDK_INSTALL_DIR)/gstreamer-ti_svn*/src/.libs/*.so $(EXEC_DIR)/usr/lib/gstreamer-0.10

loadmodule_install:
	install -d $(EXEC_DIR)/etc/init.d/
	install -d $(EXEC_DIR)/etc/rc3.d/
	install -m 0755 $(DVSDK_INSTALL_DIR)/etc/init.d/loadmodule-rc $(EXEC_DIR)/etc/init.d/
	cd $(EXEC_DIR)/etc && rm -rf rc3.d/S99loadmodule-rc && ln -s ../init.d/loadmodule-rc rc3.d/S99loadmodule-rc
