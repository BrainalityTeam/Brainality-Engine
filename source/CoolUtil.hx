package;

import lime.utils.Assets;

using StringTools;

class CoolUtil
{
	public inline static function getSave():String
	{
		return "Brainy7890";
	}

	public static function stringToBool(string:String):Bool
	{
		switch (string.toLowerCase().trim())
		{
			case 'true', 'yes':
				return true;

			default:
				return false;
		}
	}

	public static function coolTextFile(path:String):Array<String>
	{
		var daList:Array<String> = Assets.getText(path).trim().split('\n');

		for (i in 0...daList.length)
		{
			daList[i] = daList[i].trim();
		}

		return daList;
	}

	public static function numberArray(max:Int, ?min = 0):Array<Int>
	{
		var dumbArray:Array<Int> = [];
		for (i in min...max)
		{
			dumbArray.push(i);
		}
		return dumbArray;
	}
}
