/*
 *  Do not modify this file; it is automatically 
 *  generated and any modifications will be overwritten.
 *
 * @(#) xdc-u17
 */
import java.util.*;
import org.mozilla.javascript.*;
import xdc.services.intern.xsr.*;
import xdc.services.spec.*;

public class ti_targets_omf_cof
{
    static final String VERS = "@(#) xdc-u17\n";

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
        pkgP = (Proto.Obj)om.bind("ti.targets.omf.cof.Package", new Proto.Obj());
        pkgV = (Value.Obj)om.bind("ti.targets.omf.cof", new Value.Obj("ti.targets.omf.cof", pkgP));
    }

    void Settings$$OBJECTS()
    {
        Proto.Obj po, spo;
        Value.Obj vo;

        po = (Proto.Obj)om.bind("ti.targets.omf.cof.Settings.Module", new Proto.Obj());
        vo = (Value.Obj)om.bind("ti.targets.omf.cof.Settings", new Value.Obj("ti.targets.omf.cof.Settings", po));
        pkgV.bind("Settings", vo);
        // decls 
        om.bind("ti.targets.omf.cof.Settings.Mode", new Proto.Enm("ti.targets.omf.cof.Settings.Mode"));
    }

    void Settings$$CONSTS()
    {
        // module Settings
        om.bind("ti.targets.omf.cof.Settings.TI", xdc.services.intern.xsr.Enum.make((Proto.Enm)om.findStrict("ti.targets.omf.cof.Settings.Mode", "ti.targets.omf.cof"), "ti.targets.omf.cof.Settings.TI", 0));
        om.bind("ti.targets.omf.cof.Settings.MOTOROLA", xdc.services.intern.xsr.Enum.make((Proto.Enm)om.findStrict("ti.targets.omf.cof.Settings.Mode", "ti.targets.omf.cof"), "ti.targets.omf.cof.Settings.MOTOROLA", 1));
    }

    void Settings$$CREATES()
    {
        Proto.Fxn fxn;
        StringBuilder sb;

    }

    void Settings$$FUNCTIONS()
    {
        Proto.Fxn fxn;

    }

    void Settings$$SIZES()
    {
    }

    void Settings$$TYPES()
    {
        Scriptable cap;
        Proto.Obj po;
        Proto.Str ps;
        Proto.Typedef pt;
        Object fxn;

        po = (Proto.Obj)om.findStrict("ti.targets.omf.cof.Settings.Module", "ti.targets.omf.cof");
        po.init("ti.targets.omf.cof.Settings.Module", $$Module);
                po.addFld("$hostonly", $$T_Num, 1, "r");
                po.addFld("mode", (Proto)om.findStrict("ti.targets.omf.cof.Settings.Mode", "ti.targets.omf.cof"), om.find("ti.targets.omf.cof.Settings.TI"), "wh");
    }

    void Settings$$ROV()
    {
    }

    void $$SINGLETONS()
    {
        pkgP.init("ti.targets.omf.cof.Package", (Proto.Obj)om.findStrict("xdc.IPackage.Module", "ti.targets.omf.cof"));
        Scriptable cap = (Scriptable)Global.callFxn("loadCapsule", xdcO, "ti/targets/omf/cof/package.xs");
        om.bind("xdc.IPackage$$capsule", cap);
        Object fxn;
                fxn = Global.get(cap, "init");
                if (fxn != null) pkgP.addFxn("init", (Proto.Fxn)om.findStrict("xdc.IPackage$$init", "ti.targets.omf.cof"), fxn);
                fxn = Global.get(cap, "close");
                if (fxn != null) pkgP.addFxn("close", (Proto.Fxn)om.findStrict("xdc.IPackage$$close", "ti.targets.omf.cof"), fxn);
                fxn = Global.get(cap, "validate");
                if (fxn != null) pkgP.addFxn("validate", (Proto.Fxn)om.findStrict("xdc.IPackage$$validate", "ti.targets.omf.cof"), fxn);
                fxn = Global.get(cap, "exit");
                if (fxn != null) pkgP.addFxn("exit", (Proto.Fxn)om.findStrict("xdc.IPackage$$exit", "ti.targets.omf.cof"), fxn);
                fxn = Global.get(cap, "getLibs");
                if (fxn != null) pkgP.addFxn("getLibs", (Proto.Fxn)om.findStrict("xdc.IPackage$$getLibs", "ti.targets.omf.cof"), fxn);
                fxn = Global.get(cap, "getSects");
                if (fxn != null) pkgP.addFxn("getSects", (Proto.Fxn)om.findStrict("xdc.IPackage$$getSects", "ti.targets.omf.cof"), fxn);
        pkgP.bind("$capsule", cap);
        pkgV.init2(pkgP, "ti.targets.omf.cof", Value.DEFAULT, false);
        pkgV.bind("$name", "ti.targets.omf.cof");
        pkgV.bind("$category", "Package");
        pkgV.bind("$$qn", "ti.targets.omf.cof.");
        pkgV.bind("$vers", Global.newArray());
        Value.Map atmap = (Value.Map)pkgV.getv("$attr");
        atmap.seal("length");
        imports.clear();
        pkgV.bind("$imports", imports);
        StringBuilder sb = new StringBuilder();
        sb.append("var pkg = xdc.om['ti.targets.omf.cof'];\n");
        sb.append("if (pkg.$vers.length >= 3) {\n");
            sb.append("pkg.$vers.push(Packages.xdc.services.global.Vers.getDate(xdc.csd() + '/..'));\n");
        sb.append("}\n");
        sb.append("pkg.build.libraries = [\n");
            sb.append("'lib/cof_ti.a5',\n");
            sb.append("'lib/debug/cof_ti.lib',\n");
            sb.append("'lib/release/cof_ti.lib',\n");
            sb.append("'lib/cof_ti.a470MV',\n");
            sb.append("'lib/cof_ti.a86U',\n");
        sb.append("];\n");
        sb.append("pkg.build.libDesc = [\n");
            sb.append("['lib/cof_ti.a5', {target: 'gnu.targets.Sparc'}],\n");
            sb.append("['lib/debug/cof_ti.lib', {target: 'microsoft.targets.VC98'}],\n");
            sb.append("['lib/release/cof_ti.lib', {target: 'microsoft.targets.VC98'}],\n");
            sb.append("['lib/cof_ti.a470MV', {target: 'gnu.targets.MVArm9'}],\n");
            sb.append("['lib/cof_ti.a86U', {target: 'gnu.targets.Linux86'}],\n");
        sb.append("];\n");
        sb.append("if('suffix' in xdc.om['xdc.IPackage$$LibDesc']) {\n");
            sb.append("pkg.build.libDesc['lib/cof_ti.a5'].suffix = '5';\n");
            sb.append("pkg.build.libDesc['lib/debug/cof_ti.lib'].suffix = '86';\n");
            sb.append("pkg.build.libDesc['lib/release/cof_ti.lib'].suffix = '86';\n");
            sb.append("pkg.build.libDesc['lib/cof_ti.a470MV'].suffix = '470MV';\n");
            sb.append("pkg.build.libDesc['lib/cof_ti.a86U'].suffix = '86U';\n");
        sb.append("}\n");
        Global.eval(sb.toString());
    }

    void Settings$$SINGLETONS()
    {
        Proto.Obj po;
        Value.Obj vo;

        vo = (Value.Obj)om.findStrict("ti.targets.omf.cof.Settings", "ti.targets.omf.cof");
        po = (Proto.Obj)om.findStrict("ti.targets.omf.cof.Settings.Module", "ti.targets.omf.cof");
        vo.init2(po, "ti.targets.omf.cof.Settings", $$DEFAULT, false);
        vo.bind("Module", po);
        vo.bind("$category", "Module");
        vo.bind("$capsule", $$UNDEF);
        vo.bind("$package", om.findStrict("ti.targets.omf.cof", "ti.targets.omf.cof"));
        tdefs.clear();
        proxies.clear();
        mcfgs.clear();
        vo.bind("Mode", om.findStrict("ti.targets.omf.cof.Settings.Mode", "ti.targets.omf.cof"));
        vo.bind("TI", om.findStrict("ti.targets.omf.cof.Settings.TI", "ti.targets.omf.cof"));
        vo.bind("MOTOROLA", om.findStrict("ti.targets.omf.cof.Settings.MOTOROLA", "ti.targets.omf.cof"));
        vo.bind("$$tdefs", Global.newArray(tdefs.toArray()));
        vo.bind("$$proxies", Global.newArray(proxies.toArray()));
        vo.bind("$$mcfgs", Global.newArray(mcfgs.toArray()));
        ((Value.Arr)pkgV.getv("$modules")).add(vo);
        ((Value.Arr)om.findStrict("$modules", "ti.targets.omf.cof")).add(vo);
        vo.bind("$$instflag", 0);
        vo.bind("$$iobjflag", 1);
        vo.bind("$$sizeflag", 1);
        vo.bind("$$dlgflag", 0);
        vo.bind("$$iflag", 0);
        vo.bind("$$romcfgs", "|");
        Proto.Str ps = (Proto.Str)vo.find("Module_State");
        if (ps != null) vo.bind("$object", ps.newInstance());
        vo.bind("$$meta_iobj", om.has("ti.targets.omf.cof.Settings$$instance$static$init", null) ? 1 : 0);
        vo.bind("$$fxntab", Global.newArray());
        vo.bind("$$logEvtCfgs", Global.newArray());
        vo.bind("$$errorDescCfgs", Global.newArray());
        vo.bind("$$assertDescCfgs", Global.newArray());
        Value.Map atmap = (Value.Map)vo.getv("$attr");
        atmap.seal("length");
        pkgV.bind("Settings", vo);
        ((Value.Arr)pkgV.getv("$unitNames")).add("Settings");
    }

    void $$INITIALIZATION()
    {
        Value.Obj vo;

        if (isCFG) {
        }//isCFG
        Global.callFxn("module$meta$init", (Scriptable)om.findStrict("ti.targets.omf.cof.Settings", "ti.targets.omf.cof"));
        Global.callFxn("init", pkgV);
        ((Value.Obj)om.getv("ti.targets.omf.cof.Settings")).bless();
        ((Value.Arr)om.findStrict("$packages", "ti.targets.omf.cof")).add(pkgV);
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
        Settings$$OBJECTS();
        Settings$$CONSTS();
        Settings$$CREATES();
        Settings$$FUNCTIONS();
        Settings$$SIZES();
        Settings$$TYPES();
        if (isROV) {
            Settings$$ROV();
        }//isROV
        $$SINGLETONS();
        Settings$$SINGLETONS();
        $$INITIALIZATION();
    }
}
