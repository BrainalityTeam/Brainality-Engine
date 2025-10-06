package backend;

import openfl.utils.Assets;
import haxe.Json;

typedef MetaData = {
    ?windowName:String,
    ?discordRPC:String,
}

class Meta
{
    public static function dummy():MetaData
        return {
            windowName: "YOUR MOD NAME",
        };

    public inline static function loadMeta():MetaData
    {
        try 
        {
            return Json.parse(Assets.getText('assets/meta.json'));
        } catch (e:Dynamic)
        {
            trace("Error parsing meta.json");
            return dummy();
        }
    }
}