package backend;

class FileUtil {
    public static function readText(path:String):String {
        #if sys
        return sys.io.File.getContent(path);
        #elseif html5
        return openfl.utils.Assets.getText(path);
        #else
        throw "readText not implemented for this platform";
        #end
    }
}