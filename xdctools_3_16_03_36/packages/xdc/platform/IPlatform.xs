/* --COPYRIGHT--,EPL
 *  Copyright (c) 2008 Texas Instruments and others.
 *  All rights reserved. This program and the accompanying materials
 *  are made available under the terms of the Eclipse Public License v1.0
 *  which accompanies this distribution, and is available at
 *  http://www.eclipse.org/legal/epl-v10.html
 * 
 *  Contributors:
 *      Texas Instruments - initial implementation
 * 
 * --/COPYRIGHT--*/
/*
 *  ======== IPlatform.xs ========
 *
 *! Revision History
 *! ================
 *! 11-Jul-2005 sasa	added 'prog' as a parameter to getLinkTemplate()
 */

/*
 *  ======== IPlatform.getCpuDataSheet ========
 *  Define the default platform package getCpuDataSheet() method.
 */
function getCpuDataSheet (cpuId) {
    throw new Error("The platform " + this.$orig
	+ " did not define the required getCpuDataSheet method.")
}

/*
 *  ======== IPlatform.getCreateArgs ========
 *  Define the default platform package getCreateArgs() method.
 */
function getCreateArgs () {
    throw new Error("The platform " + this.$orig
	+ " did not define the required getCreateArgs method.")
}

/*
 *  ======== IPlatform.getExeContext ========
 *  Define the default platform package getExeContext() method.
 */
function getExeContext (prog) {
    throw new Error("The platform " + prog.platform
	+ " did not define the required getExeContext method.")
}

/*
 *  ======== ICpuDataSheet.getMemoryMap ========
 *  Define the default IExeContext getMemoryMap() method.
 */
function getMemoryMap (registers) {
    return ([]);
}

/*
 *  ======== ICpuDataSheet.getRegisterSet ========
 *  Define the default IExeContext getRegisterSet() method.
 */
function getRegisterSet () {
    return ([]);
}

/*
 *  ======== IPlatform.getLinkTemplate ========
 *  Define the default platform package getLinkTemplate() method.
 */
function getLinkTemplate (prog) {
    return (null);    /*  no linker command template for this platform */
}

/*
 *  ======== IPlatform.getExecCmd ========
 *  Define the default program execution command
 */
function getExecCmd (prog, platPath) {
   return ("$(ECHO) don't know how to execute '" + prog.name + "'\nexit 1");
}
/*
 *  @(#) xdc.platform; 1, 0, 1, 0,237; 2-22-2010 10:33:24; /db/ztree/library/trees/xdc/xdc-u17x/src/packages/
 */

