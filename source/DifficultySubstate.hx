package;

import SelectionSubstate;
import flixel.FlxG;

class PauseSubstate extends SelectionSubstate
{
    override public function new(x:Float, y:Float)
    {
        super(x, y);

        //in the future we will add custom difficultie's, etc, but this should work for now.
        
        menuItems = [
            ['easy', function():Void {
                trace('Not implemented!');
            }],
            ['normal', function():Void {
                trace('Not implemented!');
            }],
            ['hard', function():Void {
                trace('Not implemented!');
            }],
            ['Back', function():Void {
                openSubState(new PauseSubstate());
                close();
            }]
        ];

        createMenu(x, y);
    }
}