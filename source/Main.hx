package;

import flixel.FlxGame;
import openfl.display.FPS;
import openfl.display.Sprite;
import MemBar;
class Main extends Sprite
{
	public function new()
	{
		super();
		addChild(new FlxGame(0, 0, TitleState, 60, 60, true));

		#if !mobile
		addChild(new FPS(10, 3, 0xFFFFFF));
		var memBar = new MemBar(10, 10, 0xFFFFFF); 
		addChild(memBar);
		#end
	}
}
