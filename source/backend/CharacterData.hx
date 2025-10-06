package backend;

import backend.animation.AnimationData;

#if sys
import sys.FileSystem;
import sys.io.File;
#end

import haxe.Json;

#if sys
import sys.FileSystem;
import sys.io.File;
#end
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
        #if sys
        var folderPath = "assets/characters/";
        var characters:Array<String> = [];

        if (!FileSystem.exists(folderPath)) return characters;

        for (fileName in FileSystem.readDirectory(folderPath)) {
            if (StringTools.endsWith(fileName, ".json")) {
                characters.push(fileName.substr(0, fileName.length - 5));
            }
        }
        return characters;

        #elseif html5
        var characters:Array<String> = [];
        try {
            var manifestStr = Assets.getText("assets/manifest.json");
            var manifest:Dynamic = Json.parse(manifestStr);

            if (manifest.characters != null) {
                var charList:Array<Dynamic> = manifest.characters; // assign to typed array
                for (c in charList) {
                    characters.push(c);
                }
            }
        } catch(e:Dynamic) {
            trace("Failed to load manifest.json: " + e);
        }
        return characters;
        #else
        return ['bf', 'gf', 'dad'];
        #end
    }

    public static function loadCharacter(name:String):CharacterData {
        var path = "assets/characters/" + name + ".json";
        var jsonStr = Assets.getText(path);

        return Json.parse(jsonStr);
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