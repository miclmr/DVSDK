/* 
 * Copyright (c) 2010, Texas Instruments Incorporated
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 *
 * *  Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 *
 * *  Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 *
 * *  Neither the name of Texas Instruments Incorporated nor the names of
 *    its contributors may be used to endorse or promote products derived
 *    from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
 * THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
 * PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
 * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
 * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
 * OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
 * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
 * OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
 * EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 * 
 */

/*
 *  ======== validate ========
 */
function validate()
{
    /* TODO: validate the range of all the config params */
}

/*
 *  ======== getLibs ========
 */
function getLibs(prog)
{    

    var device = prog.cpu.deviceName;
    var suffix = "";

    suffix = prog.build.target.findSuffix(this);

    if (null == suffix) {
        return (null);
    }

    /* For Arm devices, this package is available only for DM355 and DM365 */
    if (prog.cpu.attrs.cpuCore == "v7A") {
        if (!(device.match("DM355") || (device.match("DM365")))) {
            return (null);
        }
    }

    var lib = "edma3Chan";
    lib += ".a" + suffix

    var dir = "lib/" + this.profile;

    if (!java.io.File(this.packageBase + dir + "/" + lib ).exists()) {

        print(this.$name + ": Requested profile '" + this.profile + "' does"
                + " not exist.\n\tDefaulting to the 'release' profile");
 
        dir = "lib/release";
    }

    print("    will link with " + this.$name + ":" + dir + "/" + lib);
    return (dir + "/" + lib);
}


/*
 *  ======== getSects ========
 */
function getSects() {
   return (null);
}


/*
 * ======== close ========
 */
function close() {

    xdc.loadPackage("ti.sdo.fc.ires");

    if ((this.EDMA3CHAN.debug) || (this.EDMA3CHAN.trace)) {
        print(this + ": This module no longer supports the .debug "
                + "or the .trace config params. Set desired profile for all "
                + "FC modules as follows: "
                + "xdc.useModule\('ti.sdo.fc.global.Settings'\).profile = "
                + "\"debug\""
                + " or set profiles for individual packages like this: "
                + "xdc.loadPackage('" 
                + this + "').profile = \"debug\"\;"
                + " .\n\tDefaulting to the 'release' profile");
    } 

    if (this.profile == undefined) {
        this.profile = xdc.useModule('ti.sdo.fc.global.Settings').profile;
    }

    if (this.profile.match("trace")) {
        xdc.useModule("ti.sdo.utils.trace.GT");
    }

    xdc.useModule('ti.sdo.fc.edma3.Settings');

    if (prog.cpu.attrs.cpuCore == "v7A") {
        /* Supports late-acquire, hence requires the grouputils APIs */ 
        xdc.useModule("ti.sdo.fc.ires.grouputils.GROUPUTILS");
    }
}
/*
 *  @(#) ti.sdo.fc.ires.edma3chan; 1, 0, 0,177; 12-1-2010 17:25:02; /db/atree/library/trees/fc/fc-p01x/src/ xlibrary

 */
