#
#  Do not edit this file.  This file is generated from 
#  package.bld.  Any modifications to this file will be 
#  overwritten whenever makefiles are re-generated.
#
#  target compatibility key = microsoft.targets.arm.WinCE{1,0,14.01,60511
#
ifneq (clean,$(MAKECMDGOALS))
-include package/lib/lib/debug/vicp2codec1_ti/package/package_ti.sdo.fc.ires.examples.codecs.vicp2codec1.ov4TCE.dep
endif

package/lib/lib/debug/vicp2codec1_ti/package/package_ti.sdo.fc.ires.examples.codecs.vicp2codec1.ov4TCE: | .interfaces
package/lib/lib/debug/vicp2codec1_ti/package/package_ti.sdo.fc.ires.examples.codecs.vicp2codec1.ov4TCE: package/package_ti.sdo.fc.ires.examples.codecs.vicp2codec1.c lib/debug/vicp2codec1_ti.av4TCE.mak
	@$(RM) $@.dep
	$(RM) $@
	@$(MSG) clv4TCE $< ...
	/db/toolsrc/library/tools/bin86U/runw32 C:/WINCE600/OSDesigns/OSDesign1/OSDesign1/Wince600/TI_EVM_3530_ARMV4I/PBInitEnv.bat \& $(microsoft.targets.arm.WinCE.rootDir)/sdk/bin/i386/arm/cl.exe -nologo -c  -Gy -GF -D_CRT_SECURE_NO_DEPRECATE -D_USE_32BIT_TIME_T -DUNICODE  -D_UNICODE -DUNDER_CE=600 -D_WIN32_WCE=0x600 -DWIN32 -DSTRICT -DARM -DARMV4I  -D_ARM_ -DINTERNATIONAL -DINTLMSG_CODEPAGE=1252 -Zc:wchar_t- -Zc:forScope- -wd4867 -wd4430 -MT -U_MT -W3 /GR- -QRarch4T -DTHUMBSUPPORT -QRimplicit-import- -QRinterwork-return /GS  -D_DEBUG, -DDEBUG -DGT_ASSERT=0 -DGT_TRACE=0 -Dxdc_target_name__=WinCE -Dxdc_target_types__=microsoft/targets/arm/std.h -Dxdc_bld__profile_debug -Dxdc_bld__vers_1_0_14_01_60511 -Od -Z7 -IC:/WINCE600/cesysgen/sdk/inc $(XDCINCS) -IC:/WINCE600/PUBLIC/COMMON/SDK/INC /TC /Fo$@  $<
	$(RM) $@.dep
	$(MKDEP) -a $@.dep -p package/lib/lib/debug/vicp2codec1_ti/package/ -s ov4TCE $< -C   -Gy -GF -D_CRT_SECURE_NO_DEPRECATE -D_USE_32BIT_TIME_T -DUNICODE  -D_UNICODE -DUNDER_CE=600 -D_WIN32_WCE=0x600 -DWIN32 -DSTRICT -DARM -DARMV4I  -D_ARM_ -DINTERNATIONAL -DINTLMSG_CODEPAGE=1252 -Zc:wchar_t- -Zc:forScope- -wd4867 -wd4430 -MT -U_MT -W3 /GR- -QRarch4T -DTHUMBSUPPORT -QRimplicit-import- -QRinterwork-return /GS  -D_DEBUG, -DDEBUG -DGT_ASSERT=0 -DGT_TRACE=0 -Dxdc_target_name__=WinCE -Dxdc_target_types__=microsoft/targets/arm/std.h -Dxdc_bld__profile_debug -Dxdc_bld__vers_1_0_14_01_60511 -Od -Z7 -IC:/WINCE600/cesysgen/sdk/inc $(XDCINCS) -IC:/WINCE600/PUBLIC/COMMON/SDK/INC
	-@$(FIXDEP) $@.dep $@.dep
	
package/lib/lib/debug/vicp2codec1_ti/package/package_ti.sdo.fc.ires.examples.codecs.vicp2codec1.ov4TCE:INCLUDE=
package/lib/lib/debug/vicp2codec1_ti/package/package_ti.sdo.fc.ires.examples.codecs.vicp2codec1.ov4TCE:LIB=
package/lib/lib/debug/vicp2codec1_ti/package/package_ti.sdo.fc.ires.examples.codecs.vicp2codec1.ov4TCE: PATH:=.:$(microsoft.targets.arm.WinCE.rootDir)/sdk/bin/i386:$(microsoft.targets.arm.WinCE.rootDir)/sdk/bin/i386/arm:$(PATH)

package/lib/lib/debug/vicp2codec1_ti/package/package_ti.sdo.fc.ires.examples.codecs.vicp2codec1.sv4TCE: | .interfaces
package/lib/lib/debug/vicp2codec1_ti/package/package_ti.sdo.fc.ires.examples.codecs.vicp2codec1.sv4TCE: package/package_ti.sdo.fc.ires.examples.codecs.vicp2codec1.c lib/debug/vicp2codec1_ti.av4TCE.mak
	@$(RM) $@.dep
	$(RM) $@
	@$(MSG) clv4TCE -S $< ...
	/db/toolsrc/library/tools/bin86U/runw32 C:/WINCE600/OSDesigns/OSDesign1/OSDesign1/Wince600/TI_EVM_3530_ARMV4I/PBInitEnv.bat \& $(microsoft.targets.arm.WinCE.rootDir)/sdk/bin/i386/arm/cl.exe -nologo -c  -Gy -GF -D_CRT_SECURE_NO_DEPRECATE -D_USE_32BIT_TIME_T -DUNICODE  -D_UNICODE -DUNDER_CE=600 -D_WIN32_WCE=0x600 -DWIN32 -DSTRICT -DARM -DARMV4I  -D_ARM_ -DINTERNATIONAL -DINTLMSG_CODEPAGE=1252 -Zc:wchar_t- -Zc:forScope- -wd4867 -wd4430 -MT -U_MT -W3 /GR- -QRarch4T -DTHUMBSUPPORT -QRimplicit-import- -QRinterwork-return /GS  -D_DEBUG, -DDEBUG -DGT_ASSERT=0 -DGT_TRACE=0 -Dxdc_target_name__=WinCE -Dxdc_target_types__=microsoft/targets/arm/std.h -Dxdc_bld__profile_debug -Dxdc_bld__vers_1_0_14_01_60511 -Od -Z7  $(XDCINCS) -IC:/WINCE600/PUBLIC/COMMON/SDK/INC /TC /Fo$@ /Fa$@ $<
	$(RM) $@.dep
	$(MKDEP) -a $@.dep -p package/lib/lib/debug/vicp2codec1_ti/package/ -s ov4TCE $< -C   -Gy -GF -D_CRT_SECURE_NO_DEPRECATE -D_USE_32BIT_TIME_T -DUNICODE  -D_UNICODE -DUNDER_CE=600 -D_WIN32_WCE=0x600 -DWIN32 -DSTRICT -DARM -DARMV4I  -D_ARM_ -DINTERNATIONAL -DINTLMSG_CODEPAGE=1252 -Zc:wchar_t- -Zc:forScope- -wd4867 -wd4430 -MT -U_MT -W3 /GR- -QRarch4T -DTHUMBSUPPORT -QRimplicit-import- -QRinterwork-return /GS  -D_DEBUG, -DDEBUG -DGT_ASSERT=0 -DGT_TRACE=0 -Dxdc_target_name__=WinCE -Dxdc_target_types__=microsoft/targets/arm/std.h -Dxdc_bld__profile_debug -Dxdc_bld__vers_1_0_14_01_60511 -Od -Z7  $(XDCINCS) -IC:/WINCE600/PUBLIC/COMMON/SDK/INC
	-@$(FIXDEP) $@.dep $@.dep
	
package/lib/lib/debug/vicp2codec1_ti/package/package_ti.sdo.fc.ires.examples.codecs.vicp2codec1.sv4TCE:INCLUDE=
package/lib/lib/debug/vicp2codec1_ti/package/package_ti.sdo.fc.ires.examples.codecs.vicp2codec1.sv4TCE:LIB=
package/lib/lib/debug/vicp2codec1_ti/package/package_ti.sdo.fc.ires.examples.codecs.vicp2codec1.sv4TCE: PATH:=.:$(microsoft.targets.arm.WinCE.rootDir)/sdk/bin/i386:$(microsoft.targets.arm.WinCE.rootDir)/sdk/bin/i386/arm:$(PATH)

ifneq (clean,$(MAKECMDGOALS))
-include package/lib/lib/debug/vicp2codec1_ti/vicp2codec1_ti.ov4TCE.dep
endif

package/lib/lib/debug/vicp2codec1_ti/vicp2codec1_ti.ov4TCE: | .interfaces
package/lib/lib/debug/vicp2codec1_ti/vicp2codec1_ti.ov4TCE: vicp2codec1_ti.c lib/debug/vicp2codec1_ti.av4TCE.mak
	@$(RM) $@.dep
	$(RM) $@
	@$(MSG) clv4TCE $< ...
	/db/toolsrc/library/tools/bin86U/runw32 C:/WINCE600/OSDesigns/OSDesign1/OSDesign1/Wince600/TI_EVM_3530_ARMV4I/PBInitEnv.bat \& $(microsoft.targets.arm.WinCE.rootDir)/sdk/bin/i386/arm/cl.exe -nologo -c  -Gy -GF -D_CRT_SECURE_NO_DEPRECATE -D_USE_32BIT_TIME_T -DUNICODE  -D_UNICODE -DUNDER_CE=600 -D_WIN32_WCE=0x600 -DWIN32 -DSTRICT -DARM -DARMV4I  -D_ARM_ -DINTERNATIONAL -DINTLMSG_CODEPAGE=1252 -Zc:wchar_t- -Zc:forScope- -wd4867 -wd4430 -MT -U_MT -W3 /GR- -QRarch4T -DTHUMBSUPPORT -QRimplicit-import- -QRinterwork-return /GS  -D_DEBUG, -DDEBUG -DGT_ASSERT=0 -DGT_TRACE=0 -Dxdc_target_name__=WinCE -Dxdc_target_types__=microsoft/targets/arm/std.h -Dxdc_bld__profile_debug -Dxdc_bld__vers_1_0_14_01_60511 -Od -Z7 -IC:/WINCE600/cesysgen/sdk/inc $(XDCINCS) -IC:/WINCE600/PUBLIC/COMMON/SDK/INC /TC /Fo$@  $<
	$(RM) $@.dep
	$(MKDEP) -a $@.dep -p package/lib/lib/debug/vicp2codec1_ti/ -s ov4TCE $< -C   -Gy -GF -D_CRT_SECURE_NO_DEPRECATE -D_USE_32BIT_TIME_T -DUNICODE  -D_UNICODE -DUNDER_CE=600 -D_WIN32_WCE=0x600 -DWIN32 -DSTRICT -DARM -DARMV4I  -D_ARM_ -DINTERNATIONAL -DINTLMSG_CODEPAGE=1252 -Zc:wchar_t- -Zc:forScope- -wd4867 -wd4430 -MT -U_MT -W3 /GR- -QRarch4T -DTHUMBSUPPORT -QRimplicit-import- -QRinterwork-return /GS  -D_DEBUG, -DDEBUG -DGT_ASSERT=0 -DGT_TRACE=0 -Dxdc_target_name__=WinCE -Dxdc_target_types__=microsoft/targets/arm/std.h -Dxdc_bld__profile_debug -Dxdc_bld__vers_1_0_14_01_60511 -Od -Z7 -IC:/WINCE600/cesysgen/sdk/inc $(XDCINCS) -IC:/WINCE600/PUBLIC/COMMON/SDK/INC
	-@$(FIXDEP) $@.dep $@.dep
	
package/lib/lib/debug/vicp2codec1_ti/vicp2codec1_ti.ov4TCE:INCLUDE=
package/lib/lib/debug/vicp2codec1_ti/vicp2codec1_ti.ov4TCE:LIB=
package/lib/lib/debug/vicp2codec1_ti/vicp2codec1_ti.ov4TCE: PATH:=.:$(microsoft.targets.arm.WinCE.rootDir)/sdk/bin/i386:$(microsoft.targets.arm.WinCE.rootDir)/sdk/bin/i386/arm:$(PATH)

package/lib/lib/debug/vicp2codec1_ti/vicp2codec1_ti.sv4TCE: | .interfaces
package/lib/lib/debug/vicp2codec1_ti/vicp2codec1_ti.sv4TCE: vicp2codec1_ti.c lib/debug/vicp2codec1_ti.av4TCE.mak
	@$(RM) $@.dep
	$(RM) $@
	@$(MSG) clv4TCE -S $< ...
	/db/toolsrc/library/tools/bin86U/runw32 C:/WINCE600/OSDesigns/OSDesign1/OSDesign1/Wince600/TI_EVM_3530_ARMV4I/PBInitEnv.bat \& $(microsoft.targets.arm.WinCE.rootDir)/sdk/bin/i386/arm/cl.exe -nologo -c  -Gy -GF -D_CRT_SECURE_NO_DEPRECATE -D_USE_32BIT_TIME_T -DUNICODE  -D_UNICODE -DUNDER_CE=600 -D_WIN32_WCE=0x600 -DWIN32 -DSTRICT -DARM -DARMV4I  -D_ARM_ -DINTERNATIONAL -DINTLMSG_CODEPAGE=1252 -Zc:wchar_t- -Zc:forScope- -wd4867 -wd4430 -MT -U_MT -W3 /GR- -QRarch4T -DTHUMBSUPPORT -QRimplicit-import- -QRinterwork-return /GS  -D_DEBUG, -DDEBUG -DGT_ASSERT=0 -DGT_TRACE=0 -Dxdc_target_name__=WinCE -Dxdc_target_types__=microsoft/targets/arm/std.h -Dxdc_bld__profile_debug -Dxdc_bld__vers_1_0_14_01_60511 -Od -Z7  $(XDCINCS) -IC:/WINCE600/PUBLIC/COMMON/SDK/INC /TC /Fo$@ /Fa$@ $<
	$(RM) $@.dep
	$(MKDEP) -a $@.dep -p package/lib/lib/debug/vicp2codec1_ti/ -s ov4TCE $< -C   -Gy -GF -D_CRT_SECURE_NO_DEPRECATE -D_USE_32BIT_TIME_T -DUNICODE  -D_UNICODE -DUNDER_CE=600 -D_WIN32_WCE=0x600 -DWIN32 -DSTRICT -DARM -DARMV4I  -D_ARM_ -DINTERNATIONAL -DINTLMSG_CODEPAGE=1252 -Zc:wchar_t- -Zc:forScope- -wd4867 -wd4430 -MT -U_MT -W3 /GR- -QRarch4T -DTHUMBSUPPORT -QRimplicit-import- -QRinterwork-return /GS  -D_DEBUG, -DDEBUG -DGT_ASSERT=0 -DGT_TRACE=0 -Dxdc_target_name__=WinCE -Dxdc_target_types__=microsoft/targets/arm/std.h -Dxdc_bld__profile_debug -Dxdc_bld__vers_1_0_14_01_60511 -Od -Z7  $(XDCINCS) -IC:/WINCE600/PUBLIC/COMMON/SDK/INC
	-@$(FIXDEP) $@.dep $@.dep
	
package/lib/lib/debug/vicp2codec1_ti/vicp2codec1_ti.sv4TCE:INCLUDE=
package/lib/lib/debug/vicp2codec1_ti/vicp2codec1_ti.sv4TCE:LIB=
package/lib/lib/debug/vicp2codec1_ti/vicp2codec1_ti.sv4TCE: PATH:=.:$(microsoft.targets.arm.WinCE.rootDir)/sdk/bin/i386:$(microsoft.targets.arm.WinCE.rootDir)/sdk/bin/i386/arm:$(PATH)

ifneq (clean,$(MAKECMDGOALS))
-include package/lib/lib/debug/vicp2codec1_ti/vicp2codec1_ti_ires.ov4TCE.dep
endif

package/lib/lib/debug/vicp2codec1_ti/vicp2codec1_ti_ires.ov4TCE: | .interfaces
package/lib/lib/debug/vicp2codec1_ti/vicp2codec1_ti_ires.ov4TCE: vicp2codec1_ti_ires.c lib/debug/vicp2codec1_ti.av4TCE.mak
	@$(RM) $@.dep
	$(RM) $@
	@$(MSG) clv4TCE $< ...
	/db/toolsrc/library/tools/bin86U/runw32 C:/WINCE600/OSDesigns/OSDesign1/OSDesign1/Wince600/TI_EVM_3530_ARMV4I/PBInitEnv.bat \& $(microsoft.targets.arm.WinCE.rootDir)/sdk/bin/i386/arm/cl.exe -nologo -c  -Gy -GF -D_CRT_SECURE_NO_DEPRECATE -D_USE_32BIT_TIME_T -DUNICODE  -D_UNICODE -DUNDER_CE=600 -D_WIN32_WCE=0x600 -DWIN32 -DSTRICT -DARM -DARMV4I  -D_ARM_ -DINTERNATIONAL -DINTLMSG_CODEPAGE=1252 -Zc:wchar_t- -Zc:forScope- -wd4867 -wd4430 -MT -U_MT -W3 /GR- -QRarch4T -DTHUMBSUPPORT -QRimplicit-import- -QRinterwork-return /GS  -D_DEBUG, -DDEBUG -DGT_ASSERT=0 -DGT_TRACE=0 -Dxdc_target_name__=WinCE -Dxdc_target_types__=microsoft/targets/arm/std.h -Dxdc_bld__profile_debug -Dxdc_bld__vers_1_0_14_01_60511 -Od -Z7 -IC:/WINCE600/cesysgen/sdk/inc $(XDCINCS) -IC:/WINCE600/PUBLIC/COMMON/SDK/INC /TC /Fo$@  $<
	$(RM) $@.dep
	$(MKDEP) -a $@.dep -p package/lib/lib/debug/vicp2codec1_ti/ -s ov4TCE $< -C   -Gy -GF -D_CRT_SECURE_NO_DEPRECATE -D_USE_32BIT_TIME_T -DUNICODE  -D_UNICODE -DUNDER_CE=600 -D_WIN32_WCE=0x600 -DWIN32 -DSTRICT -DARM -DARMV4I  -D_ARM_ -DINTERNATIONAL -DINTLMSG_CODEPAGE=1252 -Zc:wchar_t- -Zc:forScope- -wd4867 -wd4430 -MT -U_MT -W3 /GR- -QRarch4T -DTHUMBSUPPORT -QRimplicit-import- -QRinterwork-return /GS  -D_DEBUG, -DDEBUG -DGT_ASSERT=0 -DGT_TRACE=0 -Dxdc_target_name__=WinCE -Dxdc_target_types__=microsoft/targets/arm/std.h -Dxdc_bld__profile_debug -Dxdc_bld__vers_1_0_14_01_60511 -Od -Z7 -IC:/WINCE600/cesysgen/sdk/inc $(XDCINCS) -IC:/WINCE600/PUBLIC/COMMON/SDK/INC
	-@$(FIXDEP) $@.dep $@.dep
	
package/lib/lib/debug/vicp2codec1_ti/vicp2codec1_ti_ires.ov4TCE:INCLUDE=
package/lib/lib/debug/vicp2codec1_ti/vicp2codec1_ti_ires.ov4TCE:LIB=
package/lib/lib/debug/vicp2codec1_ti/vicp2codec1_ti_ires.ov4TCE: PATH:=.:$(microsoft.targets.arm.WinCE.rootDir)/sdk/bin/i386:$(microsoft.targets.arm.WinCE.rootDir)/sdk/bin/i386/arm:$(PATH)

package/lib/lib/debug/vicp2codec1_ti/vicp2codec1_ti_ires.sv4TCE: | .interfaces
package/lib/lib/debug/vicp2codec1_ti/vicp2codec1_ti_ires.sv4TCE: vicp2codec1_ti_ires.c lib/debug/vicp2codec1_ti.av4TCE.mak
	@$(RM) $@.dep
	$(RM) $@
	@$(MSG) clv4TCE -S $< ...
	/db/toolsrc/library/tools/bin86U/runw32 C:/WINCE600/OSDesigns/OSDesign1/OSDesign1/Wince600/TI_EVM_3530_ARMV4I/PBInitEnv.bat \& $(microsoft.targets.arm.WinCE.rootDir)/sdk/bin/i386/arm/cl.exe -nologo -c  -Gy -GF -D_CRT_SECURE_NO_DEPRECATE -D_USE_32BIT_TIME_T -DUNICODE  -D_UNICODE -DUNDER_CE=600 -D_WIN32_WCE=0x600 -DWIN32 -DSTRICT -DARM -DARMV4I  -D_ARM_ -DINTERNATIONAL -DINTLMSG_CODEPAGE=1252 -Zc:wchar_t- -Zc:forScope- -wd4867 -wd4430 -MT -U_MT -W3 /GR- -QRarch4T -DTHUMBSUPPORT -QRimplicit-import- -QRinterwork-return /GS  -D_DEBUG, -DDEBUG -DGT_ASSERT=0 -DGT_TRACE=0 -Dxdc_target_name__=WinCE -Dxdc_target_types__=microsoft/targets/arm/std.h -Dxdc_bld__profile_debug -Dxdc_bld__vers_1_0_14_01_60511 -Od -Z7  $(XDCINCS) -IC:/WINCE600/PUBLIC/COMMON/SDK/INC /TC /Fo$@ /Fa$@ $<
	$(RM) $@.dep
	$(MKDEP) -a $@.dep -p package/lib/lib/debug/vicp2codec1_ti/ -s ov4TCE $< -C   -Gy -GF -D_CRT_SECURE_NO_DEPRECATE -D_USE_32BIT_TIME_T -DUNICODE  -D_UNICODE -DUNDER_CE=600 -D_WIN32_WCE=0x600 -DWIN32 -DSTRICT -DARM -DARMV4I  -D_ARM_ -DINTERNATIONAL -DINTLMSG_CODEPAGE=1252 -Zc:wchar_t- -Zc:forScope- -wd4867 -wd4430 -MT -U_MT -W3 /GR- -QRarch4T -DTHUMBSUPPORT -QRimplicit-import- -QRinterwork-return /GS  -D_DEBUG, -DDEBUG -DGT_ASSERT=0 -DGT_TRACE=0 -Dxdc_target_name__=WinCE -Dxdc_target_types__=microsoft/targets/arm/std.h -Dxdc_bld__profile_debug -Dxdc_bld__vers_1_0_14_01_60511 -Od -Z7  $(XDCINCS) -IC:/WINCE600/PUBLIC/COMMON/SDK/INC
	-@$(FIXDEP) $@.dep $@.dep
	
package/lib/lib/debug/vicp2codec1_ti/vicp2codec1_ti_ires.sv4TCE:INCLUDE=
package/lib/lib/debug/vicp2codec1_ti/vicp2codec1_ti_ires.sv4TCE:LIB=
package/lib/lib/debug/vicp2codec1_ti/vicp2codec1_ti_ires.sv4TCE: PATH:=.:$(microsoft.targets.arm.WinCE.rootDir)/sdk/bin/i386:$(microsoft.targets.arm.WinCE.rootDir)/sdk/bin/i386/arm:$(PATH)

clean,v4TCE ::
	-$(RM) package/lib/lib/debug/vicp2codec1_ti/package/package_ti.sdo.fc.ires.examples.codecs.vicp2codec1.ov4TCE
	-$(RM) package/lib/lib/debug/vicp2codec1_ti/vicp2codec1_ti.ov4TCE
	-$(RM) package/lib/lib/debug/vicp2codec1_ti/vicp2codec1_ti_ires.ov4TCE
	-$(RM) package/lib/lib/debug/vicp2codec1_ti/package/package_ti.sdo.fc.ires.examples.codecs.vicp2codec1.sv4TCE
	-$(RM) package/lib/lib/debug/vicp2codec1_ti/vicp2codec1_ti.sv4TCE
	-$(RM) package/lib/lib/debug/vicp2codec1_ti/vicp2codec1_ti_ires.sv4TCE

lib/debug/vicp2codec1_ti.av4TCE: package/lib/lib/debug/vicp2codec1_ti/package/package_ti.sdo.fc.ires.examples.codecs.vicp2codec1.ov4TCE package/lib/lib/debug/vicp2codec1_ti/vicp2codec1_ti.ov4TCE package/lib/lib/debug/vicp2codec1_ti/vicp2codec1_ti_ires.ov4TCE lib/debug/vicp2codec1_ti.av4TCE.mak

clean::
	-$(RM) lib/debug/vicp2codec1_ti.av4TCE.mak
