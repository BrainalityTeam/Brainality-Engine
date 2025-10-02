package;

import flixel.FlxGame;
import openfl.display.FPS;
import openfl.display.Sprite;
import MemBar;
import backend.ClientPrefs;

#if CRASH_HANDLER
import openfl.Lib;
import lime.app.Application;
import sys.io.File;
import sys.FileSystem;
import openfl.events.UncaughtErrorEvent;
import haxe.CallStack;
import haxe.io.Path;
#end

class Main extends Sprite
{
	public function new()
	{
		super();

		#if CRASH_HANDLER
		Lib.current.loaderInfo.uncaughtErrorEvents.addEventListener(UncaughtErrorEvent.UNCAUGHT_ERROR, onCrash);
		#end

		ClientPrefs.getPrefs();

		#if html5
		addChild(new FlxGame(0, 0, ClickState, 60, 60, true));
		#else
		addChild(new FlxGame(0, 0, TitleState, 60, 60, true));
		#end

		#if !mobile
		addChild(new FPS(10, 3, 0xFFFFFF));
		var memBar = new MemBar(10, 15, 0xFFFFFF); 
		addChild(memBar);
		#end
	}

	// Code was entirely made by sqirra-rng for their fnf engine named "Izzy Engine", big props to them!!!
	// very cool person for real they don't get enough credit for their work
	#if CRASH_HANDLER
	function onCrash(e:UncaughtErrorEvent):Void
	{
		var errMsg:String = "";
		var path:String;
		var callStack:Array<StackItem> = CallStack.exceptionStack(true);
		var dateNow:String = Date.now().toString();

		//dateNow = dateNow.replace(" ", "_");
		//dateNow = dateNow.replace(":", "'");

		path = "./crash/" + "BrainalityEngine" + dateNow + ".txt";

		for (stackItem in callStack)
		{
			switch (stackItem)
			{
				case FilePos(s, file, line, column):
					errMsg += file + " (line " + line + ")\n";
				default:
					Sys.println(stackItem);
			}
		}

		errMsg += "\nUncaught Error: " + e.error;
		// remove if you're modding and want the crash log message to contain the link
		// please remember to actually modify the link for the github page to report the issues to.
		#if officialBuild
		errMsg += "\nPlease report this error to the GitHub page: https://github.com/ShadowMario/FNF-PsychEngine";
		#end
		errMsg += "\n\n> Crash Handler written by: sqirra-rng";

		if (!FileSystem.exists("./crash/"))
			FileSystem.createDirectory("./crash/");

		File.saveContent(path, errMsg + "\n");

		Sys.println(errMsg);
		Sys.println("Crash dump saved in " + Path.normalize(path));

		Application.current.window.alert(errMsg, "Error!");
		#if DISCORD_ALLOWED
		DiscordClient.shutdown();
		#end
		Sys.exit(1);
	}
	#end
}
