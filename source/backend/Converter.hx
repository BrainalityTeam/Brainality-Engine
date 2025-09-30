package backend;

//various conversions for different data types from different engines

import backend.CharacterData;
import backend.animation.AnimationData;

using StringTools;

typedef PsychAnimArray = {
	var anim:String;
	var name:String;
	var fps:Int;
	var loop:Bool;
	var indices:Array<Int>;
	var offsets:Array<Int>;
}

typedef PsychCharacter = {
    var animations:Array<PsychAnimArray>;
	var image:String;
	var scale:Float;
	var sing_duration:Float;
	var healthicon:String;

	var position:Array<Float>;
	var camera_position:Array<Float>;

	var flip_x:Bool;
	var no_antialiasing:Bool;
	var healthbar_colors:Array<Int>;
	var vocals_file:String;
	@:optional var _editor_isPlayer:Null<Bool>;
}

class Converter
{
    public static function character(char:Dynamic, ?engine:String = 'psych'):CharacterData
    {
        var convertedCharacter:CharacterData = CharacterUtil.dummy();

        switch (engine.toLowerCase())
        {
            case "psych":
                try 
                {
                    convertedCharacter.x = char.position[0];
                    convertedCharacter.y = char.position[1];
                    convertedCharacter.image = char.image;
                    convertedCharacter.antialiasing = !char.no_antialiasing;
                    convertedCharacter.icon = char.healthicon;
                    convertedCharacter.iconRGB = char.healthbar_colors;
                    convertedCharacter.singTime = char.sing_duration;
                    convertedCharacter.flipX = char.flip_x;
                    convertedCharacter.scale = char.scale;

                    convertedCharacter.framerate = char.animations[0].fps;

                    var anims:Array<Dynamic> = cast char.animations;
                    if (anims != null) {
                        for (anim in anims) {
                            convertedCharacter.animations.push(Converter.animation(anim, "psych"));
                        }
                    }
                } 
                catch(e:Dynamic)
                {
                    trace("ERROR CONVERTING CHARACTER!!!");
                }
                
            case "codename":
                trace("Support for Codename Engine is coming in the future!");

            default:
                trace('Engine ${engine} not supported!');
        }

        return convertedCharacter;
    }

    public static function animation(anim:Dynamic, ?engine:String = 'psych'):AnimationData
    {
        var convertedAnim:AnimationData = AnimationUtil.dummy();

        switch (engine.toLowerCase())
        {
            case "psych":
                try 
                {
                    convertedAnim.name = anim.anim;
                    convertedAnim.animName = anim.name;
                    if (anim.offsets != null) convertedAnim.offsets = anim.offsets; else convertedAnim.offsets = null;
                    if (anim.offsets != null) convertedAnim.indices = anim.indices;else convertedAnim.indices = null;
                    convertedAnim.looped = anim.loop;
                } 
                catch(e:Dynamic)
                {
                    trace("ERROR CONVERTING ANIMATION!!!");
                }
                
            case "codename":
                trace("Support for Codename Engine is comming in the future!");

            default:
                trace('Engine ${engine} not supported!');
        }

        return convertedAnim;
    }
}