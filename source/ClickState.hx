import flixel.FlxState;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.math.FlxPoint;
import TitleState;
import openfl.Lib;
import openfl.events.MouseEvent;

class ClickState extends FlxState
{
    var touchHereToPlay:FlxSprite;

    override public function create():Void
    {
        super.create();

        FlxG.mouse.visible = false;

        touchHereToPlay = new FlxSprite(0, 0, "assets/images/touchHereToPlay.png");
        touchHereToPlay.scale.set(0.5, 0.5);
        touchHereToPlay.updateHitbox();
        touchHereToPlay.screenCenter();
        add(touchHereToPlay);

        Lib.current.stage.addEventListener(MouseEvent.CLICK, onMouseClick);
    }

    function onMouseClick(e:MouseEvent):Void
    {
        var mousePos = new FlxPoint(e.stageX, e.stageY);

        if (touchHereToPlay.overlapsPoint(mousePos, true))
        {
            FlxG.switchState(() -> new TitleState());
        }
    }

    override public function destroy():Void
    {
        Lib.current.stage.removeEventListener(MouseEvent.CLICK, onMouseClick);
        super.destroy();
    }
}
