/*
 *  Do not modify this file; it is automatically 
 *  generated and any modifications will be overwritten.
 *
 * @(#) xdc-u12
 */
import java.util.*;
import org.mozilla.javascript.*;
import xdc.services.intern.xsr.*;
import xdc.services.spec.*;

public class ti_xdais_dm_examples_imgdec1_copy
{
    static final String VERS = "@(#) xdc-u12\n";

    static final Proto.Elm $$T_Bool = Proto.Elm.newBool();
    static final Proto.Elm $$T_Num = Proto.Elm.newNum();
    static final Proto.Elm $$T_Str = Proto.Elm.newStr();
    static final Proto.Elm $$T_Obj = Proto.Elm.newObj();

    static final Proto.Fxn $$T_Met = new Proto.Fxn(null, null, 0, -1, false);
    static final Proto.Map $$T_Map = new Proto.Map($$T_Obj);
    static final Proto.Arr $$T_Vec = new Proto.Arr($$T_Obj);

    static final XScriptO $$DEFAULT = Value.DEFAULT;
    static final Object $$UNDEF = Undefined.instance;

    static final Proto.Obj $$Package = (Proto.Obj)Global.get("$$Package");
    static final Proto.Obj $$Module = (Proto.Obj)Global.get("$$Module");
    static final Proto.Obj $$Instance = (Proto.Obj)Global.get("$$Instance");
    static final Proto.Obj $$Params = (Proto.Obj)Global.get("$$Params");

    static final Object $$objFldGet = Global.get("$$objFldGet");
    static final Object $$objFldSet = Global.get("$$objFldSet");
    static final Object $$proxyGet = Global.get("$$proxyGet");
    static final Object $$proxySet = Global.get("$$proxySet");
    static final Object $$delegGet = Global.get("$$delegGet");
    static final Object $$delegSet = Global.get("$$delegSet");

    Scriptable xdcO;
    Session ses;
    Value.Obj om;

    boolean isROV;
    boolean isCFG;

    Proto.Obj pkgP;
    Value.Obj pkgV;

    ArrayList<Object> imports = new ArrayList<Object>();
    ArrayList<Object> loggables = new ArrayList<Object>();
    ArrayList<Object> mcfgs = new ArrayList<Object>();
    ArrayList<Object> proxies = new ArrayList<Object>();
    ArrayList<Object> sizes = new ArrayList<Object>();
    ArrayList<Object> tdefs = new ArrayList<Object>();

    void $$IMPORTS()
    {
        Global.callFxn("loadPackage", xdcO, "xdc");
        Global.callFxn("loadPackage", xdcO, "xdc.corevers");
    }

    void $$OBJECTS()
    {
        pkgP = (Proto.Obj)om.bind("ti.xdais.dm.examples.imgdec1_copy.Package", new Proto.Obj());
        pkgV = (Value.Obj)om.bind("ti.xdais.dm.examples.imgdec1_copy", new Value.Obj("ti.xdais.dm.examples.imgdec1_copy", pkgP));
    }

    void $$SINGLETONS()
    {
        pkgP.init("ti.xdais.dm.examples.imgdec1_copy.Package", (Proto.Obj)om.findStrict("xdc.IPackage.Module", "ti.xdais.dm.examples.imgdec1_copy"));
        Scriptable cap = (Scriptable)Global.callFxn("loadCapsule", xdcO, "ti/xdais/dm/examples/imgdec1_copy/package.xs");
        om.bind("xdc.IPackage$$capsule", cap);
        Object fxn;
                fxn = Global.get(cap, "init");
                if (fxn != null) pkgP.addFxn("init", (Proto.Fxn)om.findStrict("xdc.IPackage$$init", "ti.xdais.dm.examples.imgdec1_copy"), fxn);
                fxn = Global.get(cap, "close");
                if (fxn != null) pkgP.addFxn("close", (Proto.Fxn)om.findStrict("xdc.IPackage$$close", "ti.xdais.dm.examples.imgdec1_copy"), fxn);
                fxn = Global.get(cap, "validate");
                if (fxn != null) pkgP.addFxn("validate", (Proto.Fxn)om.findStrict("xdc.IPackage$$validate", "ti.xdais.dm.examples.imgdec1_copy"), fxn);
                fxn = Global.get(cap, "exit");
                if (fxn != null) pkgP.addFxn("exit", (Proto.Fxn)om.findStrict("xdc.IPackage$$exit", "ti.xdais.dm.examples.imgdec1_copy"), fxn);
                fxn = Global.get(cap, "getLibs");
                if (fxn != null) pkgP.addFxn("getLibs", (Proto.Fxn)om.findStrict("xdc.IPackage$$getLibs", "ti.xdais.dm.examples.imgdec1_copy"), fxn);
                fxn = Global.get(cap, "getSects");
                if (fxn != null) pkgP.addFxn("getSects", (Proto.Fxn)om.findStrict("xdc.IPackage$$getSects", "ti.xdais.dm.examples.imgdec1_copy"), fxn);
        pkgP.bind("$capsule", cap);
        pkgV.init2(pkgP, "ti.xdais.dm.examples.imgdec1_copy", Value.DEFAULT, false);
        pkgV.bind("$name", "ti.xdais.dm.examples.imgdec1_copy");
        pkgV.bind("$category", "Package");
        pkgV.bind("$$qn", "ti.xdais.dm.examples.imgdec1_copy.");
        pkgV.bind("$vers", Global.newArray("2, 0, 0"));
        Value.Map atmap = (Value.Map)pkgV.getv("$attr");
        atmap.seal("length");
        imports.clear();
        pkgV.bind("$imports", imports);
        StringBuilder sb = new StringBuilder();
        sb.append("var pkg = xdc.om['ti.xdais.dm.examples.imgdec1_copy'];\n");
        sb.append("if (pkg.$vers.length >= 3) {\n");
            sb.append("pkg.$vers.push(Packages.xdc.services.global.Vers.getDate(xdc.csd() + '/..'));\n");
        sb.append("}\n");
        sb.append("pkg.build.libraries = [\n");
            sb.append("'lib/release/imgdec1_copy.a86U',\n");
            sb.append("'lib/release/imgdec1_copy.av4TCE',\n");
            sb.append("'lib/debug/imgdec1_copy.av5T',\n");
            sb.append("'lib/debug/imgdec1_copy.av4TCE',\n");
            sb.append("'lib/release/imgdec1_copy.av5T',\n");
            sb.append("'lib/release/imgdec1_copy.a470uC',\n");
            sb.append("'lib/debug/imgdec1_copy.a674',\n");
            sb.append("'lib/debug/imgdec1_copy.a470uC',\n");
            sb.append("'lib/release/imgdec1_copy.a674',\n");
            sb.append("'lib/debug/imgdec1_copy.a64P',\n");
            sb.append("'lib/release/imgdec1_copy.a64P',\n");
            sb.append("'lib/debug/imgdec1_copy.a86U',\n");
        sb.append("];\n");
        sb.append("pkg.build.libDesc = [\n");
            sb.append("['lib/release/imgdec1_copy.a86U', {target: 'gnu.targets.Linux86'}],\n");
            sb.append("['lib/release/imgdec1_copy.av4TCE', {target: 'microsoft.targets.arm.WinCE'}],\n");
            sb.append("['lib/debug/imgdec1_copy.av5T', {target: 'gnu.targets.arm.GCArmv5T'}],\n");
            sb.append("['lib/debug/imgdec1_copy.av4TCE', {target: 'microsoft.targets.arm.WinCE'}],\n");
            sb.append("['lib/release/imgdec1_copy.av5T', {target: 'gnu.targets.arm.GCArmv5T'}],\n");
            sb.append("['lib/release/imgdec1_copy.a470uC', {target: 'gnu.targets.UCArm9'}],\n");
            sb.append("['lib/debug/imgdec1_copy.a674', {target: 'ti.targets.C674'}],\n");
            sb.append("['lib/debug/imgdec1_copy.a470uC', {target: 'gnu.targets.UCArm9'}],\n");
            sb.append("['lib/release/imgdec1_copy.a674', {target: 'ti.targets.C674'}],\n");
            sb.append("['lib/debug/imgdec1_copy.a64P', {target: 'ti.targets.C64P'}],\n");
            sb.append("['lib/release/imgdec1_copy.a64P', {target: 'ti.targets.C64P'}],\n");
            sb.append("['lib/debug/imgdec1_copy.a86U', {target: 'gnu.targets.Linux86'}],\n");
        sb.append("];\n");
        sb.append("if('suffix' in xdc.om['xdc.IPackage$$LibDesc']) {\n");
            sb.append("pkg.build.libDesc['lib/release/imgdec1_copy.a86U'].suffix = '86U';\n");
            sb.append("pkg.build.libDesc['lib/release/imgdec1_copy.av4TCE'].suffix = 'v4TCE';\n");
            sb.append("pkg.build.libDesc['lib/debug/imgdec1_copy.av5T'].suffix = 'v5T';\n");
            sb.append("pkg.build.libDesc['lib/debug/imgdec1_copy.av4TCE'].suffix = 'v4TCE';\n");
            sb.append("pkg.build.libDesc['lib/release/imgdec1_copy.av5T'].suffix = 'v5T';\n");
            sb.append("pkg.build.libDesc['lib/release/imgdec1_copy.a470uC'].suffix = '470uC';\n");
            sb.append("pkg.build.libDesc['lib/debug/imgdec1_copy.a674'].suffix = '674';\n");
            sb.append("pkg.build.libDesc['lib/debug/imgdec1_copy.a470uC'].suffix = '470uC';\n");
            sb.append("pkg.build.libDesc['lib/release/imgdec1_copy.a674'].suffix = '674';\n");
            sb.append("pkg.build.libDesc['lib/debug/imgdec1_copy.a64P'].suffix = '64P';\n");
            sb.append("pkg.build.libDesc['lib/release/imgdec1_copy.a64P'].suffix = '64P';\n");
            sb.append("pkg.build.libDesc['lib/debug/imgdec1_copy.a86U'].suffix = '86U';\n");
        sb.append("}\n");
        Global.eval(sb.toString());
    }

    void $$INITIALIZATION()
    {
        Value.Obj vo;

        if (isCFG) {
        }//isCFG
        Global.callFxn("init", pkgV);
        ((Value.Arr)om.findStrict("$packages", "ti.xdais.dm.examples.imgdec1_copy")).add(pkgV);
    }

    public void exec( Scriptable xdcO, Session ses )
    {
        this.xdcO = xdcO;
        this.ses = ses;
        om = (Value.Obj)xdcO.get("om", null);

        Object o = om.geto("$name");
        String s = o instanceof String ? (String)o : null;
        isCFG = s != null && s.equals("cfg");
        isROV = s != null && s.equals("rov");

        $$IMPORTS();
        $$OBJECTS();
        if (isROV) {
        }//isROV
        $$SINGLETONS();
        $$INITIALIZATION();
    }
}
