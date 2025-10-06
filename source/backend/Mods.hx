package backend;

#if sys
import sys.FileSystem;
import sys.io.File;
#end

class Mods
{
    public static var modsFolder = "./mods/";

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