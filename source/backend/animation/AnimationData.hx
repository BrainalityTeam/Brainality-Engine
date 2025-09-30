package backend.animation;

typedef AnimationData = {
    var name:String;
    var animName:String;
    @:optional var offsets:Array<Dynamic>;
    @:optional var indices:Array<Int>;
    @:optional var looped:Bool;
}

class AnimationUtil {
    public static function dummy():AnimationData return {
        name: "idle",
        animName: "idle"
    };
}