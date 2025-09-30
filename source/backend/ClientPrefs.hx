package backend;

class ClientPrefs
{
    static var data:Map<String, Dynamic> = new Map();
    
    public static function getPrefs()
    {
        data.set("ghostTap", true);
        data.set("middleScroll", false);
    }

    inline public static function getSaveVariable(key:String)
    {
        return data.get(key);
    }

    inline public static function setSaveVariable(key:String, v:Dynamic)
    {
        data.set(key, v);
    }
}