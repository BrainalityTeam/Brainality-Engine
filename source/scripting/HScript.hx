package scripting;

#if HSCRIPT_ALLOWED
import crowplexus.iris.Iris;
import crowplexus.iris.IrisConfig;

class HScript
{
    public static final getText:String->String = #if sys sys.io.File.getContent #elseif openfl openfl.utils.Assets.getText #end;

    static var cache:Map<String, Iris> = new Map();

    static function getOrLoad(script:String):Iris {
        if (!cache.exists(script)) {
            #if sys
            if (!sys.FileSystem.exists(script)) return null;
            #end
            cache.set(script, new Iris(getText(script)));
        }
        return cache.get(script);
    }

    public static function execute(script:String) {
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

    public static function call(script:String, func:String, ?args:Array<Dynamic> = null) {
        try
        {
            var s = getOrLoad(script);
            if (s == null) return null;
            return s.call(func, args);
        }
        catch (e:Dynamic)
        {
            trace("Script failed to run with error: " + e);
            return null;
        }
    }
}
#end
