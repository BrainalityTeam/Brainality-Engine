package backend;

#if sys
import sys.FileSystem;
import sys.io.File;
#end
typedef ModData = {
    ?windowName:String,
    ?discordRPC:String,
    ?global:Bool,
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
    public static var modsFolder = "./mods/";

    public static function dummy():ModData
        return {
            windowName: "YOUR MOD NAME",
            global: false,
        };

    public static function getMods():Array<String>
    {
        var folders:Array<String> = new Array();

        #if sys
        if (!FileSystem.exists(modsFolder)) return folders;

        for (fileName in FileSystem.readDirectory(modsFolder)) {
            if (FileSystem.isDirectory(modsFolder + fileName)) {
                folders.push(fileName);
            }
        }
        #end

        return folders;
    }
}