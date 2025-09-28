package states.options.objects;

import flixel.FlxSprite;
import backend.ClientPrefs;

enum OptionType {
    BOOL;
    STRING;
    INT;
    FLOAT;
    PERCENT;
}

typedef OptionData = {
    var title:String;
    var description:String;
    var save:String;
    var type:OptionType;
    @:optional var min:Float;
    @:optional var max:Float;
}

class Option extends FlxSprite
{
    public var data:OptionData;
    public var index:Int;
    public var value:Dynamic;

    override public function new(data:OptionData, index:Int)
    {
        this.data = data;
        this.index = index;

        super();

        if (this.data.type == OptionType.BOOL)
        {
            loadGraphic("assets/images/options/checkbox.png");
        }

        this.value = ClientPrefs.getSaveVariable(this.data.save);
    }
}