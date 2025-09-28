package;
import openfl.text.TextField;
import openfl.text.TextFormat;
import openfl.system.System;

class MemBar extends TextField
{
	public var memoryMegas(get, never):Float;

	public function new(x:Float = 10, y:Float = 40, color:Int = 0x000000)
	{
		super();

		this.x = x;
		this.y = y;

		selectable = false;
		mouseEnabled = false;
		defaultTextFormat = new TextFormat("_sans", 12, color);
		autoSize = LEFT;
		multiline = true;
		updateText();
	}

	private override function __enterFrame(deltaTime:Float):Void
	{
		updateText();
	}

	public dynamic function updateText():Void {
		text = 'Memory: ${flixel.util.FlxStringUtil.formatBytes(memoryMegas)}';
		textColor = 0xFFFFFFFF;
	}

	inline function get_memoryMegas():Float
		return cast(System.totalMemory, UInt);
}
