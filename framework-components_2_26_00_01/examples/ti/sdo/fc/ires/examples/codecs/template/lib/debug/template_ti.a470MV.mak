#
#  Do not edit this file.  This file is generated from 
#  package.bld.  Any modifications to this file will be 
#  overwritten whenever makefiles are re-generated.
#
#  target compatibility key = gnu.targets.MVArm9{1,0,4.2,0
#
ifneq (clean,$(MAKECMDGOALS))
-include package/lib/lib/debug/template_ti/template_ti_ires.o470MV.dep
endif

package/lib/lib/debug/template_ti/template_ti_ires.o470MV: | .interfaces
package/lib/lib/debug/template_ti/template_ti_ires.o470MV: template_ti_ires.c lib/debug/template_ti.a470MV.mak
	@$(RM) $@.dep
	$(RM) $@
	@$(MSG) cl470MV $< ...
	$(gnu.targets.MVArm9.rootDir)/bin/arm_v5t_le-gcc -c -MD -MF $@.dep -x c  -fPIC -Wunused -Wall -fno-strict-aliasing   -Dfar=  -D_DEBUG_=1 -DDBC_ASSERTS=1 -DGT_ASSERT=0 -DGT_TRACE=0 -Dxdc_target_name__=MVArm9 -Dxdc_target_types__=gnu/targets/std.h -Dxdc_bld__profile_debug -Dxdc_bld__vers_1_0_4_2_0 -g  $(XDCINCS)  -o $@ $<
	-@$(FIXDEP) $@.dep $@.dep
	
package/lib/lib/debug/template_ti/template_ti_ires.o470MV:LD_LIBRARY_PATH=

package/lib/lib/debug/template_ti/template_ti_ires.s470MV: | .interfaces
package/lib/lib/debug/template_ti/template_ti_ires.s470MV: template_ti_ires.c lib/debug/template_ti.a470MV.mak
	@$(RM) $@.dep
	$(RM) $@
	@$(MSG) cl470MV -S $< ...
	$(gnu.targets.MVArm9.rootDir)/bin/arm_v5t_le-gcc -c -MD -MF $@.dep -x c -S -fPIC -Wunused -Wall -fno-strict-aliasing   -Dfar=  -D_DEBUG_=1 -DDBC_ASSERTS=1 -DGT_ASSERT=0 -DGT_TRACE=0 -Dxdc_target_name__=MVArm9 -Dxdc_target_types__=gnu/targets/std.h -Dxdc_bld__profile_debug -Dxdc_bld__vers_1_0_4_2_0 -g  $(XDCINCS)  -o $@ $<
	-@$(FIXDEP) $@.dep $@.dep
	
package/lib/lib/debug/template_ti/template_ti_ires.s470MV:LD_LIBRARY_PATH=

ifneq (clean,$(MAKECMDGOALS))
-include package/lib/lib/debug/template_ti/package/package_ti.sdo.fc.ires.examples.codecs.template.o470MV.dep
endif

package/lib/lib/debug/template_ti/package/package_ti.sdo.fc.ires.examples.codecs.template.o470MV: | .interfaces
package/lib/lib/debug/template_ti/package/package_ti.sdo.fc.ires.examples.codecs.template.o470MV: package/package_ti.sdo.fc.ires.examples.codecs.template.c lib/debug/template_ti.a470MV.mak
	@$(RM) $@.dep
	$(RM) $@
	@$(MSG) cl470MV $< ...
	$(gnu.targets.MVArm9.rootDir)/bin/arm_v5t_le-gcc -c -MD -MF $@.dep -x c  -fPIC -Wunused -Wall -fno-strict-aliasing   -Dfar=  -D_DEBUG_=1 -DDBC_ASSERTS=1 -DGT_ASSERT=0 -DGT_TRACE=0 -Dxdc_target_name__=MVArm9 -Dxdc_target_types__=gnu/targets/std.h -Dxdc_bld__profile_debug -Dxdc_bld__vers_1_0_4_2_0 -g  $(XDCINCS)  -o $@ $<
	-@$(FIXDEP) $@.dep $@.dep
	
package/lib/lib/debug/template_ti/package/package_ti.sdo.fc.ires.examples.codecs.template.o470MV:LD_LIBRARY_PATH=

package/lib/lib/debug/template_ti/package/package_ti.sdo.fc.ires.examples.codecs.template.s470MV: | .interfaces
package/lib/lib/debug/template_ti/package/package_ti.sdo.fc.ires.examples.codecs.template.s470MV: package/package_ti.sdo.fc.ires.examples.codecs.template.c lib/debug/template_ti.a470MV.mak
	@$(RM) $@.dep
	$(RM) $@
	@$(MSG) cl470MV -S $< ...
	$(gnu.targets.MVArm9.rootDir)/bin/arm_v5t_le-gcc -c -MD -MF $@.dep -x c -S -fPIC -Wunused -Wall -fno-strict-aliasing   -Dfar=  -D_DEBUG_=1 -DDBC_ASSERTS=1 -DGT_ASSERT=0 -DGT_TRACE=0 -Dxdc_target_name__=MVArm9 -Dxdc_target_types__=gnu/targets/std.h -Dxdc_bld__profile_debug -Dxdc_bld__vers_1_0_4_2_0 -g  $(XDCINCS)  -o $@ $<
	-@$(FIXDEP) $@.dep $@.dep
	
package/lib/lib/debug/template_ti/package/package_ti.sdo.fc.ires.examples.codecs.template.s470MV:LD_LIBRARY_PATH=

ifneq (clean,$(MAKECMDGOALS))
-include package/lib/lib/debug/template_ti/template_ti.o470MV.dep
endif

package/lib/lib/debug/template_ti/template_ti.o470MV: | .interfaces
package/lib/lib/debug/template_ti/template_ti.o470MV: template_ti.c lib/debug/template_ti.a470MV.mak
	@$(RM) $@.dep
	$(RM) $@
	@$(MSG) cl470MV $< ...
	$(gnu.targets.MVArm9.rootDir)/bin/arm_v5t_le-gcc -c -MD -MF $@.dep -x c  -fPIC -Wunused -Wall -fno-strict-aliasing   -Dfar=  -D_DEBUG_=1 -DDBC_ASSERTS=1 -DGT_ASSERT=0 -DGT_TRACE=0 -Dxdc_target_name__=MVArm9 -Dxdc_target_types__=gnu/targets/std.h -Dxdc_bld__profile_debug -Dxdc_bld__vers_1_0_4_2_0 -g  $(XDCINCS)  -o $@ $<
	-@$(FIXDEP) $@.dep $@.dep
	
package/lib/lib/debug/template_ti/template_ti.o470MV:LD_LIBRARY_PATH=

package/lib/lib/debug/template_ti/template_ti.s470MV: | .interfaces
package/lib/lib/debug/template_ti/template_ti.s470MV: template_ti.c lib/debug/template_ti.a470MV.mak
	@$(RM) $@.dep
	$(RM) $@
	@$(MSG) cl470MV -S $< ...
	$(gnu.targets.MVArm9.rootDir)/bin/arm_v5t_le-gcc -c -MD -MF $@.dep -x c -S -fPIC -Wunused -Wall -fno-strict-aliasing   -Dfar=  -D_DEBUG_=1 -DDBC_ASSERTS=1 -DGT_ASSERT=0 -DGT_TRACE=0 -Dxdc_target_name__=MVArm9 -Dxdc_target_types__=gnu/targets/std.h -Dxdc_bld__profile_debug -Dxdc_bld__vers_1_0_4_2_0 -g  $(XDCINCS)  -o $@ $<
	-@$(FIXDEP) $@.dep $@.dep
	
package/lib/lib/debug/template_ti/template_ti.s470MV:LD_LIBRARY_PATH=

clean,470MV ::
	-$(RM) package/lib/lib/debug/template_ti/template_ti_ires.o470MV
	-$(RM) package/lib/lib/debug/template_ti/package/package_ti.sdo.fc.ires.examples.codecs.template.o470MV
	-$(RM) package/lib/lib/debug/template_ti/template_ti.o470MV
	-$(RM) package/lib/lib/debug/template_ti/template_ti_ires.s470MV
	-$(RM) package/lib/lib/debug/template_ti/package/package_ti.sdo.fc.ires.examples.codecs.template.s470MV
	-$(RM) package/lib/lib/debug/template_ti/template_ti.s470MV

lib/debug/template_ti.a470MV: package/lib/lib/debug/template_ti/template_ti_ires.o470MV package/lib/lib/debug/template_ti/package/package_ti.sdo.fc.ires.examples.codecs.template.o470MV package/lib/lib/debug/template_ti/template_ti.o470MV lib/debug/template_ti.a470MV.mak

clean::
	-$(RM) lib/debug/template_ti.a470MV.mak
