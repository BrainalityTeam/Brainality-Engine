package backend;

class ClientPrefs
{
    static var data:Map<String, Dynamic> = new Map();
    
    public static function getPrefs()
    {
        data.set("ghosttap", true);
    }

    inline public static function getSaveVariable(key:String)
    {
        return data.get(key);
    }
}