#
#  Do not edit this file.  This file is generated from 
#  package.bld.  Any modifications to this file will be 
#  overwritten whenever makefiles are re-generated.
#
#  target compatibility key = gnu.targets.MVArm9{1,0,4.2,0
#
ifneq (clean,$(MAKECMDGOALS))
-include package/cfg/aac_dec_app/app.o470MV.dep
endif

package/cfg/aac_dec_app/app.o470MV: | .interfaces
package/cfg/aac_dec_app/app.o470MV: app.c package/cfg/aac_dec_app_x470MV.mak
	@$(RM) $@.dep
	$(RM) $@
	@$(MSG) cl470MV $< ...
	$(gnu.targets.MVArm9.rootDir)/bin/arm_v5t_le-gcc -c -MD -MF $@.dep -x c  -fPIC -Wunused  -Dfar=  -DOS_LINUX -Dxdc_cfg__header__='ittiam/app/aac_dec_app/package/cfg/aac_dec_app_x470MV.h'  -Dxdc_target_name__=MVArm9 -Dxdc_target_types__=gnu/targets/std.h -Dxdc_bld__profile_release -Dxdc_bld__vers_1_0_4_2_0 -O2  $(XDCINCS)  -o $@ $<
	-@$(FIXDEP) $@.dep $@.dep
	
package/cfg/aac_dec_app/app.o470MV:LD_LIBRARY_PATH=

package/cfg/aac_dec_app/app.s470MV: | .interfaces
package/cfg/aac_dec_app/app.s470MV: app.c package/cfg/aac_dec_app_x470MV.mak
	@$(RM) $@.dep
	$(RM) $@
	@$(MSG) cl470MV -S $< ...
	$(gnu.targets.MVArm9.rootDir)/bin/arm_v5t_le-gcc -c -MD -MF $@.dep -x c -S -fPIC -Wunused  -Dfar=  -DOS_LINUX -Dxdc_cfg__header__='ittiam/app/aac_dec_app/package/cfg/aac_dec_app_x470MV.h'  -Dxdc_target_name__=MVArm9 -Dxdc_target_types__=gnu/targets/std.h -Dxdc_bld__profile_release -Dxdc_bld__vers_1_0_4_2_0 -O2  $(XDCINCS)  -o $@ $<
	-@$(FIXDEP) $@.dep $@.dep
	
package/cfg/aac_dec_app/app.s470MV:LD_LIBRARY_PATH=

ifneq (clean,$(MAKECMDGOALS))
-include package/cfg/aac_dec_app/ceapp.o470MV.dep
endif

package/cfg/aac_dec_app/ceapp.o470MV: | .interfaces
package/cfg/aac_dec_app/ceapp.o470MV: ceapp.c package/cfg/aac_dec_app_x470MV.mak
	@$(RM) $@.dep
	$(RM) $@
	@$(MSG) cl470MV $< ...
	$(gnu.targets.MVArm9.rootDir)/bin/arm_v5t_le-gcc -c -MD -MF $@.dep -x c  -fPIC -Wunused  -Dfar=  -DOS_LINUX -Dxdc_cfg__header__='ittiam/app/aac_dec_app/package/cfg/aac_dec_app_x470MV.h'  -Dxdc_target_name__=MVArm9 -Dxdc_target_types__=gnu/targets/std.h -Dxdc_bld__profile_release -Dxdc_bld__vers_1_0_4_2_0 -O2  $(XDCINCS)  -o $@ $<
	-@$(FIXDEP) $@.dep $@.dep
	
package/cfg/aac_dec_app/ceapp.o470MV:LD_LIBRARY_PATH=

package/cfg/aac_dec_app/ceapp.s470MV: | .interfaces
package/cfg/aac_dec_app/ceapp.s470MV: ceapp.c package/cfg/aac_dec_app_x470MV.mak
	@$(RM) $@.dep
	$(RM) $@
	@$(MSG) cl470MV -S $< ...
	$(gnu.targets.MVArm9.rootDir)/bin/arm_v5t_le-gcc -c -MD -MF $@.dep -x c -S -fPIC -Wunused  -Dfar=  -DOS_LINUX -Dxdc_cfg__header__='ittiam/app/aac_dec_app/package/cfg/aac_dec_app_x470MV.h'  -Dxdc_target_name__=MVArm9 -Dxdc_target_types__=gnu/targets/std.h -Dxdc_bld__profile_release -Dxdc_bld__vers_1_0_4_2_0 -O2  $(XDCINCS)  -o $@ $<
	-@$(FIXDEP) $@.dep $@.dep
	
package/cfg/aac_dec_app/ceapp.s470MV:LD_LIBRARY_PATH=

ifneq (clean,$(MAKECMDGOALS))
-include package/cfg/aac_dec_app/ia_enhaacplus_dec_error_handler.o470MV.dep
endif

package/cfg/aac_dec_app/ia_enhaacplus_dec_error_handler.o470MV: | .interfaces
package/cfg/aac_dec_app/ia_enhaacplus_dec_error_handler.o470MV: ia_enhaacplus_dec_error_handler.c package/cfg/aac_dec_app_x470MV.mak
	@$(RM) $@.dep
	$(RM) $@
	@$(MSG) cl470MV $< ...
	$(gnu.targets.MVArm9.rootDir)/bin/arm_v5t_le-gcc -c -MD -MF $@.dep -x c  -fPIC -Wunused  -Dfar=  -DOS_LINUX -Dxdc_cfg__header__='ittiam/app/aac_dec_app/package/cfg/aac_dec_app_x470MV.h'  -Dxdc_target_name__=MVArm9 -Dxdc_target_types__=gnu/targets/std.h -Dxdc_bld__profile_release -Dxdc_bld__vers_1_0_4_2_0 -O2  $(XDCINCS)  -o $@ $<
	-@$(FIXDEP) $@.dep $@.dep
	
package/cfg/aac_dec_app/ia_enhaacplus_dec_error_handler.o470MV:LD_LIBRARY_PATH=

package/cfg/aac_dec_app/ia_enhaacplus_dec_error_handler.s470MV: | .interfaces
package/cfg/aac_dec_app/ia_enhaacplus_dec_error_handler.s470MV: ia_enhaacplus_dec_error_handler.c package/cfg/aac_dec_app_x470MV.mak
	@$(RM) $@.dep
	$(RM) $@
	@$(MSG) cl470MV -S $< ...
	$(gnu.targets.MVArm9.rootDir)/bin/arm_v5t_le-gcc -c -MD -MF $@.dep -x c -S -fPIC -Wunused  -Dfar=  -DOS_LINUX -Dxdc_cfg__header__='ittiam/app/aac_dec_app/package/cfg/aac_dec_app_x470MV.h'  -Dxdc_target_name__=MVArm9 -Dxdc_target_types__=gnu/targets/std.h -Dxdc_bld__profile_release -Dxdc_bld__vers_1_0_4_2_0 -O2  $(XDCINCS)  -o $@ $<
	-@$(FIXDEP) $@.dep $@.dep
	
package/cfg/aac_dec_app/ia_enhaacplus_dec_error_handler.s470MV:LD_LIBRARY_PATH=

ifneq (clean,$(MAKECMDGOALS))
-include package/cfg/aac_dec_app_x470MV.o470MV.dep
endif

package/cfg/aac_dec_app_x470MV.o470MV: | .interfaces
package/cfg/aac_dec_app_x470MV.o470MV: package/cfg/aac_dec_app_x470MV.c package/cfg/aac_dec_app_x470MV.mak
	@$(RM) $@.dep
	$(RM) $@
	@$(MSG) cl470MV $< ...
	$(gnu.targets.MVArm9.rootDir)/bin/arm_v5t_le-gcc -c -MD -MF $@.dep -x c  -fPIC -Wunused  -Dfar=  -DOS_LINUX -Dxdc_cfg__header__='ittiam/app/aac_dec_app/package/cfg/aac_dec_app_x470MV.h'  -Dxdc_target_name__=MVArm9 -Dxdc_target_types__=gnu/targets/std.h -Dxdc_bld__profile_release -Dxdc_bld__vers_1_0_4_2_0 -O2  $(XDCINCS)  -o $@ $<
	-@$(FIXDEP) $@.dep $@.dep
	
package/cfg/aac_dec_app_x470MV.o470MV:LD_LIBRARY_PATH=

package/cfg/aac_dec_app_x470MV.s470MV: | .interfaces
package/cfg/aac_dec_app_x470MV.s470MV: package/cfg/aac_dec_app_x470MV.c package/cfg/aac_dec_app_x470MV.mak
	@$(RM) $@.dep
	$(RM) $@
	@$(MSG) cl470MV -S $< ...
	$(gnu.targets.MVArm9.rootDir)/bin/arm_v5t_le-gcc -c -MD -MF $@.dep -x c -S -fPIC -Wunused  -Dfar=  -DOS_LINUX -Dxdc_cfg__header__='ittiam/app/aac_dec_app/package/cfg/aac_dec_app_x470MV.h'  -Dxdc_target_name__=MVArm9 -Dxdc_target_types__=gnu/targets/std.h -Dxdc_bld__profile_release -Dxdc_bld__vers_1_0_4_2_0 -O2  $(XDCINCS)  -o $@ $<
	-@$(FIXDEP) $@.dep $@.dep
	
package/cfg/aac_dec_app_x470MV.s470MV:LD_LIBRARY_PATH=

clean,470MV ::
	-$(RM) package/cfg/aac_dec_app/app.o470MV
	-$(RM) package/cfg/aac_dec_app/ceapp.o470MV
	-$(RM) package/cfg/aac_dec_app/ia_enhaacplus_dec_error_handler.o470MV
	-$(RM) package/cfg/aac_dec_app_x470MV.o470MV
	-$(RM) package/cfg/aac_dec_app/app.s470MV
	-$(RM) package/cfg/aac_dec_app/ceapp.s470MV
	-$(RM) package/cfg/aac_dec_app/ia_enhaacplus_dec_error_handler.s470MV
	-$(RM) package/cfg/aac_dec_app_x470MV.s470MV

aac_dec_app.x470MV: package/cfg/aac_dec_app/app.o470MV package/cfg/aac_dec_app/ceapp.o470MV package/cfg/aac_dec_app/ia_enhaacplus_dec_error_handler.o470MV package/cfg/aac_dec_app_x470MV.o470MV package/cfg/aac_dec_app_x470MV.mak

clean::
	-$(RM) package/cfg/aac_dec_app_x470MV.mak
