package backend;

import backend.animation.AnimationData;

import sys.FileSystem;
import sys.io.File;
import haxe.Json;

typedef CharacterData = {
    var image:String;
    var x:Float;
    var y:Float;
    var animations:Array<AnimationData>;
    var icon:String;
    var iconRGB:Array<Int>;

    var singTime:Float;

    var framerate:Int;

    var flipX:Bool;
}

class CharacterUtil
{
    public static function getCharacters():Array<String> {
        var folderPath = "assets/characters/";
        var characters:Array<String> = [];

        if (!sys.FileSystem.exists(folderPath)) {
            // Optionally create the folder:
            // sys.FileSystem.createDirectory(folderPath);

            // Or just return empty array to avoid crashing
            return characters;
        }

        for (fileName in sys.FileSystem.readDirectory(folderPath)) {
            if (StringTools.endsWith(fileName, ".json")) {
                var name = fileName.substr(0, fileName.length - 5);
                characters.push(name);
            }
        }

        return characters;
    }


    public static function loadCharacter(name:String):CharacterData {
        var path = 'assets/characters/' + name + '.json';
        var jsonStr = File.getContent(path);
        var data:CharacterData = Json.parse(jsonStr);
        return data;
    }

    public static function checkCharacter(name:String)
    {
        var characterExists = false;

		for (char in getCharacters())
		{
			if (char == name)
			{
				characterExists = true;
                break;
			}
		}

        return characterExists;
    }
}