package;

import SelectionSubstate;
import flixel.FlxG;

#if sys
import states.editors.PsychCharacterConverter;
#end
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
            }]#if sys ,
            ['Character Convertor', function():Void {
                FlxG.switchState(new PsychCharacterConverter());
                EditorMenuSubState.value = false;
            }]
            #end
        ];

        createMenu(x, y);
    }
}