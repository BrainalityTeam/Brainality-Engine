package states.options;

import states.SelectionState;
import states.options.*;

import MainMenuState;

class OptionsMenu extends SelectionState
{
    override public function new()
    {
        super();

        menuItems = [
            ['Gameplay', function():Void {
                FlxG.switchState(()->new GameplayOptionsState());
            }]
        ];

        createMenu();
        bg.color = 0xff5ce9;
    }

    override function update(elapsed:Float)
    {
        super.update(elapsed);

        if (controls.BACK) FlxG.switchState(()->new MainMenuState());
    }
}