package;

import flixel.FlxSprite;
import flixel.math.FlxMath;
import flixel.FlxG;

class HealthIcon extends FlxSprite
{
	public var targetY:Float = 0;

	public var char:String = 'bf';

	public var isMenuItem:Bool = false;

	override function update(elapsed:Float)
	{
		if (isMenuItem)
		{
			var scaledY = FlxMath.remapToRange(targetY, 0, 1, 0, 1.3);

			y = FlxMath.lerp(y, (scaledY * 120) + (FlxG.height * 0.48), 0.16);
			x = FlxMath.lerp(x, (targetY * 20) + 400, 0.16);
		}

		super.update(elapsed);
	}

	public function setChar(char:String = "bf", isPlayer:Bool = false) {
		var path = 'assets/images/icons/icon-${char}.png';

		if (!sys.FileSystem.exists(path)) {
			char = "face";
			path = 'assets/images/icons/icon-face.png';
		}

		this.char = char;
		loadGraphic(path, true, 150, 150);

		antialiasing = true;
		animation.add('idle', [0, 1], 0, false, isPlayer);
		animation.play('idle');
		scrollFactor.set();
	}


	public function new(char:String = 'bf', isPlayer:Bool = false)
	{
		super();
		
		setChar(char, isPlayer);
	}
}
