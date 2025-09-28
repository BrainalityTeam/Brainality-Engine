package;

import SelectionSubstate;
import flixel.FlxG;
class PauseSubstate extends SelectionSubstate
{
    override public function new(x:Float, y:Float)
    {
        super(x, y);
        
        menuItems = [
            ['Resume', function():Void {
                close();
            }],
            ['Restart Song', function():Void {
                FlxG.resetState();
            }],
            ['Exit to menu', function():Void {
                FlxG.switchState(new MainMenuState());
            }]
        ];

        createMenu(x, y);
    }
}