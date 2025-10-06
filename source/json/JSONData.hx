package json;

import haxe.io.StringInput;
import json.path.JSONPath;
import json.util.TypeUtil;

/**
 * Wraps a JSON data structure in a `Map`-like interface,
 * with additional utilities for retrieving data from nested paths
 * and for handling array data.
 */
@:nullSafety
abstract JSONData(Dynamic) from Dynamic to Dynamic
{
    public static inline function build():JSONData {
        return buildObject();
    }

    public static inline function parse(input:String):JSONData {
        return haxe.Json.parse(~/(\r|\n|\t)/g.replace(input, ''));
    }

    public static inline function buildObject():JSONData {
        return {};
    }

    public static inline function buildArray():JSONData {
        return [];
    }

    @:arrayAccess
    public inline function get(key:String, ?defaultValue:Dynamic):Null<Dynamic>
    {
        #if js
        var result = untyped this[key];
        #else
        var result = isObject() ? get_obj(key) : get_arr(key);
        #end
        if (result == null) return defaultValue;
        return result;
    }

    inline function get_obj(key:String):Null<Dynamic> {
        return Reflect.field(this, key);
    }

    inline function get_arr(key:String):Null<Dynamic> {
        var index:Null<Int> = Std.parseInt(key);
        if (index == null) return null;
        return this[index];
    }

    public inline function getData(key:String):Null<JSONData> {
        return get(key);
    }

    public function getByPath(path:String):Null<Dynamic> {
        var pathParts = JSONPath.splitNormalizedPath(path);
        return getByPathParts(pathParts);
    }

    function getByPathParts(pathParts:Array<String>):Null<Dynamic> {
        if (pathParts.length == 0) return this;
        var child = getData(pathParts[0]);
        if (child == null) return null;
        return child.getByPathParts(pathParts.slice(1));
    }

    @:arrayAccess
    public inline function set(key:String, value:Dynamic):Dynamic
    {
        #if js
        return untyped this[key] = value;
        #else
        return isObject() ? set_obj(key, value) : set_arr(key, value);
        #end
    }

    inline function set_obj(key:String, value:Dynamic):Dynamic {
        Reflect.setField(this, key, value);
        return value;
    }

    inline function set_arr(key:String, value:Dynamic):Dynamic {
        var index:Null<Int> = Std.parseInt(key);
        if (index == null) return null;
        this[index] = value;
        return value;
    }

    public inline function exists(key:String):Bool {
        return isObject() ? exists_obj(key) : exists_arr(key);
    }

    inline function exists_obj(key:String):Bool {
        return Reflect.hasField(this, key);
    }

    inline function exists_arr(key:String):Bool {
        var index:Null<Int> = Std.parseInt(key);
        if (index == null) return false;
        return this.length > index;
    }

    public inline function remove(key:String):Bool {
        return isObject() ? remove_obj(key) : remove_arr(key);
    }

    inline function remove_obj(key:String):Bool {
        return Reflect.deleteField(this, key);
    }

    inline function remove_arr(key:String):Bool {
        var index:Null<Int> = Std.parseInt(key);
        if (index == null) return false;
        if (index >= this.length) return false;
        this.splice(index, 1);
        return true;
    }

    public inline function keys():Array<String> {
        if (isPrimitive()) return [];
        return isObject() ? keys_obj() : keys_arr();
    }

    inline function keys_obj():Array<String> {
        return Reflect.fields(this);
    }

    inline function keys_arr():Array<String> {
        return [for (i in 0...this.length) Std.string(i)];
    }

    public inline function length():Int {
        return isObject() ? keys_obj().length : this.length;
    }

    public inline function isPrimitive():Bool {
        return TypeUtil.isPrimitive(this);
    }

    public inline function copy():Null<JSONData> {
        return Reflect.copy(this);
    }

    public inline function isArray():Bool {
        return TypeUtil.isArray(this);
    }

    public inline function isObject():Bool {
        return !TypeUtil.isArray(this);
    }

    // ===== MISSING FUNCTIONS FOR POLYMOD =====
    public function existsByPath(path:String):Bool {
        return getByPath(path) != null;
    }

    public function removeByPath(path:String):Bool {
        var pathParts = JSONPath.splitNormalizedPath(path);
        if (pathParts.length == 0) return false;

        var lastKey = pathParts.pop();
        if (lastKey == null) return false; // guard null

        var parent = getByPathParts(pathParts);
        if (parent == null) return false;

        if (TypeUtil.isArray(parent)) {
            var index = Std.parseInt(lastKey);
            if (index == null || index >= parent.length) return false;
            parent.splice(index, 1);
            return true;
        } else {
            return lastKey != null && Reflect.deleteField(parent, lastKey);
        }
    }

    public function insertByPath(path:String, value:Dynamic, ?overwrite:Bool = true):Dynamic {
        var pathParts = JSONPath.splitNormalizedPath(path);
        if (pathParts.length == 0) return null;

        var lastKey = pathParts.pop();
        if (lastKey == null) return null; // guard null

        var parent = getByPathParts(pathParts);
        if (parent == null) return null;

        if (TypeUtil.isArray(parent)) {
            var index = Std.parseInt(lastKey);
            if (index == null) return null;
            if (overwrite && index < parent.length) parent[index] = value;
            else parent.splice(index, 0, value);
        } else {
            if (lastKey != null && (overwrite || !Reflect.hasField(parent, lastKey))) {
                Reflect.setField(parent, lastKey, value);
            }
        }

        return value;
    }

    public function setByPath(path:String, value:Dynamic):Dynamic {
        return insertByPath(path, value, true);
    }

}
