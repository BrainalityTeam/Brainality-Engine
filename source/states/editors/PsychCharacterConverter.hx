package states.editors;

#if sys
import backend.CharacterData;
import backend.Converter;
import backend.FileDialogHandler;
import flixel.ui.FlxButton;
import flixel.FlxG;
import haxe.Json;

class PsychCharacterConverter extends MusicBeatState
{
    var convertButton:FlxButton;

    var dialog = new FileDialogHandler();

    override function destroy()
    {
        FlxG.mouse.visible = false;
        dialog.destroy();
        super.destroy();
    }

    override function create()
    {
        super.create();
        FlxG.mouse.visible = true;
        convertButton = new FlxButton(FlxG.width / 2, FlxG.height / 2, "Convert", function()
        {
            convertAndSave();
        });
        add(convertButton);
    }
    
    public function convertAndSave():Void
    {
        dialog.open(null, "Select a Psych JSON character file", null, function()
        {
            var rawJson = dialog.data;
            var charData:Dynamic = Json.parse(rawJson);
            var converted:CharacterData = Converter.character(charData, "psych");
            trace("Character converted successfully!");

            var saveDialog = new FileDialogHandler();
            saveDialog.save("converted_character.json", Json.stringify(converted), function()
            {
                trace("Converted character saved successfully!");
            }, function()
            {
                trace("Save cancelled.");
            }, function()
            {
                trace("Error saving file!");
            });
        }, function()
        {
            trace("User cancelled file selection.");
        }, function()
        {
            trace("Error opening file!");
        });
    }
}
#end