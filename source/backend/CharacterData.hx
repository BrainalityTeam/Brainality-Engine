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
    var antialiasing:Bool;
    @:optional var scale:Float;
}

class CharacterUtil
{
    public inline static function dummy():CharacterData
    {
        return {
            image: "BOYFRIEND",
            x: 0,
            y: 0,
            animations: [],
            icon: "bf",
            iconRGB: [0, 0, 0],
            singTime: 6,
            framerate: 24,
            flipX: false,
            antialiasing: true,
            scale: 1
        };
    }

    public static function getCharacters():Array<String> {
        var folderPath = "assets/characters/";
        var characters:Array<String> = [];

        if (!sys.FileSystem.exists(folderPath)) {
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