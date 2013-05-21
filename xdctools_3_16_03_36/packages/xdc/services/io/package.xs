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
 *  ======== getLibs ========
 */
function getLibs() 
{
    if (Program.build.target.name == "VC98") {
	/* *.o files are returned only when ncdb.dll is built within this
	 * package.
	 */
	if (Program.$$isasm == 1 && Program.buildPackage == this.$name) {
            if (Program.build.profile == "debug") {
                return ("package/lib/debug/Doss/Dos.o" + 
                	Program.build.target.suffix +
                        ";package/lib/debug/Doss/StringUtils.o" + 
                	Program.build.target.suffix);
            }
            else {
                return ("package/lib/release/Doss/Dos.o" + 
                	Program.build.target.suffix +
                        ";package/lib/release/Doss/StringUtils.o" + 
                	Program.build.target.suffix);
            }
	}
	else {
	    return (Program.build.profile + "/Doss.lib");
	}
    }
    else {
        return null;
    }
}
