#
#  Do not edit this file.  This file is generated from 
#  package.bld.  Any modifications to this file will be 
#  overwritten whenever makefiles are re-generated.
#
#  target compatibility key = gnu.targets.UCArm9{1,0,4.2,1
#
ifneq (clean,$(MAKECMDGOALS))
-include package/lib/lib/release/vicp2codec1_ti/package/package_ti.sdo.fc.ires.examples.codecs.vicp2codec1.o470uC.dep
endif

package/lib/lib/release/vicp2codec1_ti/package/package_ti.sdo.fc.ires.examples.codecs.vicp2codec1.o470uC: | .interfaces
package/lib/lib/release/vicp2codec1_ti/package/package_ti.sdo.fc.ires.examples.codecs.vicp2codec1.o470uC: package/package_ti.sdo.fc.ires.examples.codecs.vicp2codec1.c lib/release/vicp2codec1_ti.a470uC.mak
	@$(RM) $@.dep
	$(RM) $@
	@$(MSG) cl470uC $< ...
	$(gnu.targets.UCArm9.rootDir)//bin/arm-linux-gcc -c -MD -MF $@.dep -x c  -Wunused -D_REENTRANT   -Dfar=   -DDBC_ASSERTS=0 -DGT_ASSERT=0 -DGT_TRACE=0 -Dxdc_target_name__=UCArm9 -Dxdc_target_types__=gnu/targets/std.h -Dxdc_bld__profile_release -Dxdc_bld__vers_1_0_4_2_1 -O2  $(XDCINCS)  -o $@ $<
	-@$(FIXDEP) $@.dep $@.dep
	
package/lib/lib/release/vicp2codec1_ti/package/package_ti.sdo.fc.ires.examples.codecs.vicp2codec1.o470uC:LD_LIBRARY_PATH=

package/lib/lib/release/vicp2codec1_ti/package/package_ti.sdo.fc.ires.examples.codecs.vicp2codec1.s470uC: | .interfaces
package/lib/lib/release/vicp2codec1_ti/package/package_ti.sdo.fc.ires.examples.codecs.vicp2codec1.s470uC: package/package_ti.sdo.fc.ires.examples.codecs.vicp2codec1.c lib/release/vicp2codec1_ti.a470uC.mak
	@$(RM) $@.dep
	$(RM) $@
	@$(MSG) cl470uC -S $< ...
	$(gnu.targets.UCArm9.rootDir)//bin/arm-linux-gcc -c -MD -MF $@.dep -x c -S -Wunused -D_REENTRANT   -Dfar=   -DDBC_ASSERTS=0 -DGT_ASSERT=0 -DGT_TRACE=0 -Dxdc_target_name__=UCArm9 -Dxdc_target_types__=gnu/targets/std.h -Dxdc_bld__profile_release -Dxdc_bld__vers_1_0_4_2_1 -O2  $(XDCINCS)  -o $@ $<
	-@$(FIXDEP) $@.dep $@.dep
	
package/lib/lib/release/vicp2codec1_ti/package/package_ti.sdo.fc.ires.examples.codecs.vicp2codec1.s470uC:LD_LIBRARY_PATH=

ifneq (clean,$(MAKECMDGOALS))
-include package/lib/lib/release/vicp2codec1_ti/vicp2codec1_ti.o470uC.dep
endif

package/lib/lib/release/vicp2codec1_ti/vicp2codec1_ti.o470uC: | .interfaces
package/lib/lib/release/vicp2codec1_ti/vicp2codec1_ti.o470uC: vicp2codec1_ti.c lib/release/vicp2codec1_ti.a470uC.mak
	@$(RM) $@.dep
	$(RM) $@
	@$(MSG) cl470uC $< ...
	$(gnu.targets.UCArm9.rootDir)//bin/arm-linux-gcc -c -MD -MF $@.dep -x c  -Wunused -D_REENTRANT   -Dfar=   -DDBC_ASSERTS=0 -DGT_ASSERT=0 -DGT_TRACE=0 -Dxdc_target_name__=UCArm9 -Dxdc_target_types__=gnu/targets/std.h -Dxdc_bld__profile_release -Dxdc_bld__vers_1_0_4_2_1 -O2  $(XDCINCS)  -o $@ $<
	-@$(FIXDEP) $@.dep $@.dep
	
package/lib/lib/release/vicp2codec1_ti/vicp2codec1_ti.o470uC:LD_LIBRARY_PATH=

package/lib/lib/release/vicp2codec1_ti/vicp2codec1_ti.s470uC: | .interfaces
package/lib/lib/release/vicp2codec1_ti/vicp2codec1_ti.s470uC: vicp2codec1_ti.c lib/release/vicp2codec1_ti.a470uC.mak
	@$(RM) $@.dep
	$(RM) $@
	@$(MSG) cl470uC -S $< ...
	$(gnu.targets.UCArm9.rootDir)//bin/arm-linux-gcc -c -MD -MF $@.dep -x c -S -Wunused -D_REENTRANT   -Dfar=   -DDBC_ASSERTS=0 -DGT_ASSERT=0 -DGT_TRACE=0 -Dxdc_target_name__=UCArm9 -Dxdc_target_types__=gnu/targets/std.h -Dxdc_bld__profile_release -Dxdc_bld__vers_1_0_4_2_1 -O2  $(XDCINCS)  -o $@ $<
	-@$(FIXDEP) $@.dep $@.dep
	
package/lib/lib/release/vicp2codec1_ti/vicp2codec1_ti.s470uC:LD_LIBRARY_PATH=

ifneq (clean,$(MAKECMDGOALS))
-include package/lib/lib/release/vicp2codec1_ti/vicp2codec1_ti_ires.o470uC.dep
endif

package/lib/lib/release/vicp2codec1_ti/vicp2codec1_ti_ires.o470uC: | .interfaces
package/lib/lib/release/vicp2codec1_ti/vicp2codec1_ti_ires.o470uC: vicp2codec1_ti_ires.c lib/release/vicp2codec1_ti.a470uC.mak
	@$(RM) $@.dep
	$(RM) $@
	@$(MSG) cl470uC $< ...
	$(gnu.targets.UCArm9.rootDir)//bin/arm-linux-gcc -c -MD -MF $@.dep -x c  -Wunused -D_REENTRANT   -Dfar=   -DDBC_ASSERTS=0 -DGT_ASSERT=0 -DGT_TRACE=0 -Dxdc_target_name__=UCArm9 -Dxdc_target_types__=gnu/targets/std.h -Dxdc_bld__profile_release -Dxdc_bld__vers_1_0_4_2_1 -O2  $(XDCINCS)  -o $@ $<
	-@$(FIXDEP) $@.dep $@.dep
	
package/lib/lib/release/vicp2codec1_ti/vicp2codec1_ti_ires.o470uC:LD_LIBRARY_PATH=

package/lib/lib/release/vicp2codec1_ti/vicp2codec1_ti_ires.s470uC: | .interfaces
package/lib/lib/release/vicp2codec1_ti/vicp2codec1_ti_ires.s470uC: vicp2codec1_ti_ires.c lib/release/vicp2codec1_ti.a470uC.mak
	@$(RM) $@.dep
	$(RM) $@
	@$(MSG) cl470uC -S $< ...
	$(gnu.targets.UCArm9.rootDir)//bin/arm-linux-gcc -c -MD -MF $@.dep -x c -S -Wunused -D_REENTRANT   -Dfar=   -DDBC_ASSERTS=0 -DGT_ASSERT=0 -DGT_TRACE=0 -Dxdc_target_name__=UCArm9 -Dxdc_target_types__=gnu/targets/std.h -Dxdc_bld__profile_release -Dxdc_bld__vers_1_0_4_2_1 -O2  $(XDCINCS)  -o $@ $<
	-@$(FIXDEP) $@.dep $@.dep
	
package/lib/lib/release/vicp2codec1_ti/vicp2codec1_ti_ires.s470uC:LD_LIBRARY_PATH=

clean,470uC ::
	-$(RM) package/lib/lib/release/vicp2codec1_ti/package/package_ti.sdo.fc.ires.examples.codecs.vicp2codec1.o470uC
	-$(RM) package/lib/lib/release/vicp2codec1_ti/vicp2codec1_ti.o470uC
	-$(RM) package/lib/lib/release/vicp2codec1_ti/vicp2codec1_ti_ires.o470uC
	-$(RM) package/lib/lib/release/vicp2codec1_ti/package/package_ti.sdo.fc.ires.examples.codecs.vicp2codec1.s470uC
	-$(RM) package/lib/lib/release/vicp2codec1_ti/vicp2codec1_ti.s470uC
	-$(RM) package/lib/lib/release/vicp2codec1_ti/vicp2codec1_ti_ires.s470uC

lib/release/vicp2codec1_ti.a470uC: package/lib/lib/release/vicp2codec1_ti/package/package_ti.sdo.fc.ires.examples.codecs.vicp2codec1.o470uC package/lib/lib/release/vicp2codec1_ti/vicp2codec1_ti.o470uC package/lib/lib/release/vicp2codec1_ti/vicp2codec1_ti_ires.o470uC lib/release/vicp2codec1_ti.a470uC.mak

clean::
	-$(RM) lib/release/vicp2codec1_ti.a470uC.mak
