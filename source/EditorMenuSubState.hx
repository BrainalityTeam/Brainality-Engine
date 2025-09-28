package;

import SelectionSubstate;
import flixel.FlxG;
class EditorSubstate extends SelectionSubstate
{
    override public function new(x:Float, y:Float)
    {
        super(x, y);
        
        menuItems = [
            ['Back to Main Menu', function():Void {
                close();
            }],
            ['Chart Editor', function():Void {
                FlxG.switchState(new ChartingState());
            }],
        ];

        createMenu(x, y);
    }
}