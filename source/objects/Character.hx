package objects;

import backend.CharacterData;

import flixel.FlxSprite;
import flixel.animation.FlxBaseAnimation;
import flixel.graphics.frames.FlxAtlasFrames;

import flixel.util.FlxColor;

#if HSCRIPT_ALLOWED
import scripting.HScript;
#end

using StringTools;

class Character extends FlxSprite
{
    public var animOffsets:Map<String, Array<Dynamic>>;
	public var debugMode:Bool = false;

	public var isPlayer:Bool = false;
	public var curCharacter:String = 'bf';

	public var holdTimer:Float = 0;

	public var icon:String = 'bf';

	public var iconColor:Int;

	#if HSCRIPT_ALLOWED

	var hscript:HScript;

	function create()
	{
		hscript.call('onCreate');
		hscript.call('onCreatePost');
	}

	override function update(elapsed:Float) {
		hscript.call('onUpdate', [elapsed]);
		super.update(elapsed);
		hscript.call('onUpdatePost', [elapsed]);
	}
	#end

    public function new(x:Float, y:Float, ?character:String = "bf", isPlayer:Bool = false)
	{
		var characterExists = CharacterUtil.checkCharacter(character);

		if (!characterExists)
		{
			character = 'bf';
		}

		hscript = new HScript('assets/characters/${curCharacter}.hxs');

		var data = CharacterUtil.loadCharacter(character);

		animOffsets = new Map<String, Array<Dynamic>>();

		var tex:FlxAtlasFrames;

		super(x + data.x, y + data.y);

		curCharacter = character;
		this.isPlayer = isPlayer;

		var rgb = data.iconRGB;

		iconColor = FlxColor.fromRGB(rgb[0], rgb[1], rgb[2]);

		antialiasing = data.antialiasing;

		tex = FlxAtlasFrames.fromSparrow('assets/images/${data.image}.png', 'assets/images/${data.image}.xml');
		frames = tex;

		for (anim in data.animations)
		{
			if (anim.looped == null)
				anim.looped = false;

			if (anim.indices == null || anim.indices.length < 1)
				animation.addByPrefix(anim.name, anim.animName, data.framerate, anim.looped, data.flipX);
			else
				animation.addByIndices(anim.name, anim.animName, anim.indices, "", data.framerate, anim.looped, data.flipX);
			

			if (anim.offsets == null) anim.offsets = [0, 0];
			
			var offsetX = anim.offsets.length > 0 ? anim.offsets[0] : 0;
			var offsetY = anim.offsets.length > 1 ? anim.offsets[1] : 0;
			addOffset(anim.name, offsetX, offsetY);
		};

		this.icon = data.icon;

		if (data.scale == null) data.scale = 1;

		this.scale.set(data.scale, data.scale);

		dance();

		if (isPlayer)
		{
			flipX = !flipX;

			// Doesn't flip for BF, since his are already in the right place???
			if (!curCharacter.startsWith('bf'))
			{
				// var animArray
				var oldRight = animation.getByName('singRIGHT').frames;
				animation.getByName('singRIGHT').frames = animation.getByName('singLEFT').frames;
				animation.getByName('singLEFT').frames = oldRight;

				// IF THEY HAVE MISS ANIMATIONS??
				if (animation.getByName('singRIGHTmiss') != null)
				{
					var oldMiss = animation.getByName('singRIGHTmiss').frames;
					animation.getByName('singRIGHTmiss').frames = animation.getByName('singLEFTmiss').frames;
					animation.getByName('singLEFTmiss').frames = oldMiss;
				}
			}
		}

		create();
    }

	private var danced:Bool = false;

	public function dance()
	{
		if (!debugMode)
		{
			switch (curCharacter) {
				case 'gf', 'gf-christmas', 'gf-car', 'gf-pixel':
					if (animation.curAnim != null && !animation.curAnim.name.startsWith('hair')) {
						danced = !danced;
						playAnim(danced ? 'danceRight' : 'danceLeft');
					}

				case 'spooky':
					danced = !danced;
					playAnim(danced ? 'danceRight' : 'danceLeft');

				default:
					playAnim('idle');
			}
		}
	}

	public function playAnim(AnimName:String, Force:Bool = false, Reversed:Bool = false, Frame:Int = 0):Void
	{
		animation.play(AnimName, Force, Reversed, Frame);

		var daOffset = animOffsets.get(animation.curAnim.name);
		if (animOffsets.exists(animation.curAnim.name))
		{
			offset.set(daOffset[0], daOffset[1]);
		}
		else
			offset.set(0, 0);

		if (curCharacter == 'gf')
		{
			if (AnimName == 'singLEFT')
			{
				danced = true;
			}
			else if (AnimName == 'singRIGHT')
			{
				danced = false;
			}

			if (AnimName == 'singUP' || AnimName == 'singDOWN')
			{
				danced = !danced;
			}
		}
	}

	public function addOffset(name:String, x:Float = 0, y:Float = 0)
	{
		animOffsets[name] = [x, y];
	}
}