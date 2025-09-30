package backend;

typedef ModData = {
    name:String;
    description:String;
    @:optional var windowName:String;
    @:optional var discordRPC:String;
    global:Bool;
    loaderVersion:String;
}