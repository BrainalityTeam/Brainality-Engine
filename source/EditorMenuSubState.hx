package;

import SelectionSubstate;
import flixel.FlxG;

import states.editors.PsychCharacterConverter;
class EditorMenuSubState extends SelectionSubstate
{
    public static var value:Bool = true;
    override public function new(x:Float, y:Float)
    {
        super(x, y);
        
        menuItems = [
            ['Back to Main Menu', function():Void {
                close();
                EditorMenuSubState.value = false;
            }],
            ['Chart Editor', function():Void {
                FlxG.switchState(new ChartingState());
                EditorMenuSubState.value = false;
            }],
            ['Character Convertor', function():Void {
                FlxG.switchState(new PsychCharacterConverter());
                EditorMenuSubState.value = false;
            }]
        ];

        createMenu(x, y);
    }
}