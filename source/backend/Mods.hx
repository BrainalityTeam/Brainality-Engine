package backend;

#if sys
import sys.FileSystem;
import sys.io.File;
#end
typedef ModData = {
    name:String,
    description:String,
    ?windowName:String,
    ?discordRPC:String,
    global:Bool,
    loaderVersion:String,
}

class Mod
{
    public var data:ModData;
    public var folderName:String;

    public function new(data:ModData, folderName:String)
    {
        this.data = data;
        this.folderName = folderName;
    }
}

class Mods
{
    public inline static var folderPath = "mods/";
 
    public static var loaderVersion = "0.1.0";

    public static var mods:Array<Mod> = new Array();

    public static function dummy():ModData
        return {
            name: "Test Mod",
            description: "",
            windowName: "YOUR MOD NAME",
            global: false,
            loaderVersion: loaderVersion
        }

    public static function getMods():Array<Array<String>>
    {
        var mods:Array<String> = new Array();
        var folders:Array<String> = new Array();

        #if sys

        if (!FileSystem.exists(folderPath)) return mod;

        for (fileName in FileSystem.readDirectory(folderPath)) {
            if (FileSystem.isDirectory(folderPath + fileName)) {
                mods.push(getModName(folderPath + fileName));
                folders.push(fileName);
            }
        }
        #end

        return [mods, folders];
    }

    public static function loadMods()
    {
        var coolMods = getMods();
        var coolerMods = coolMods[0];
        var folders = coolMods[1];

        var i = 0;

        for (mod in coolerMods)
        {
            mods.push(new Mod(getModData(mod), folders[i]));
            i ++;
        }
    }

    public static function getModData(mod:String, ?directory:String = null):ModData
    {
        #if sys
        var path = "";
        if (directory == null)
            path = folderPath + getFolderName(mod) + "/pack.json";
        else
            path = folderPath + directory;

        return Json.parse(sys.io.File.getContent(path));
        #else
        return dummy();
        #end
    }

    inline public static function getModName(folderName:String):String return getModData("", folderName).name;
    
    public static function getFolderName(modName:String):String
    {
        return "";
    }

    public static function checkMod(modName:String):Bool
    {
        var modFound = false;

        for (mod in mods)
        {
            if (mod.data.name == modName)
            {
                modFound = true;
                break;
            }
        }

        return modFound;
    }
}