package scripting;

#if HSCRIPT_ALLOWED
import crowplexus.iris.Iris;
import crowplexus.iris.IrisConfig;

class HScript
{
    public final getText:String->String = #if sys sys.io.File.getContent #elseif openfl openfl.utils.Assets.getText #end;

    var cache:Map<String, Iris> = new Map();

    var script:String;

    public function new(script:String)
    {
        execute(script);
        this.script = script;
    }

    function getOrLoad(script:String):Iris {
        if (!cache.exists(script)) {
            #if sys
            if (!sys.FileSystem.exists(script)) return null;
            #end
            cache.set(script, new Iris(getText(script)));
        }
        return cache.get(script);
    }

    public function execute(script) {
        try {
            var s = getOrLoad(script);
            if (s == null) return null;
            return s.execute();
        }
        catch (e:Dynamic)
        {
            trace("Script failed to run with error: " + e);
            return null;
        }
    }

    public function call(func:String, ?args:Array<Dynamic> = null) {
        try
        {
            return cache.get(script).call(func, args);
        }
        catch (e:Dynamic)
        {
            trace("Script failed to run with error: " + e);
            return null;
        }
    }
}
#end
