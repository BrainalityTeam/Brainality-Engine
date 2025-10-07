package backend;

import hxdiscord_rpc.Discord;
import hxdiscord_rpc.Types;
import sys.thread.Thread;

class DiscordRPC
{
    private static var handlers:DiscordEventHandlers;
    private static var runningThread:Thread;

    private static function onReady(request:cpp.RawConstPointer<DiscordUser>)
    {
        final discordPresence:DiscordRichPresence = new DiscordRichPresence();
		discordPresence.type = DiscordActivityType_Watching;
		discordPresence.state = "Playing Brainality Engine";
    }

    private static function onError(errorCode:Int, message:cpp.ConstCharStar) {
        trace("DISCORD ERROR WITH CODE " + errorCode);
    }
    private static function onDisconnected(errorCode:Int, message:cpp.ConstCharStar) {}

    public static function init(appID:String = "1424911475109007433"):Void
    {
		Sys.println('Initializing Discord RPC...');

		final handlers:DiscordEventHandlers = new DiscordEventHandlers();
		handlers.ready = cpp.Function.fromStaticFunction(onReady);
		handlers.disconnected = cpp.Function.fromStaticFunction(onDisconnected);
		handlers.errored = cpp.Function.fromStaticFunction(onError);
		Discord.Initialize(appID, cpp.RawPointer.addressOf(handlers), false, null);
	}
}
