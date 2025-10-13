package;

class Std {
	public static function string(s:Dynamic):String {
		return s.str();
	}
	
	public static function int(x:Dynamic):Int {
		return 0; // TODO: implement proper conversion
	}
	
	public static function isOfType(v:Dynamic, t:Dynamic):Bool {
		return false; // TODO: implement proper type checking
	}
	
	public static function parseFloat(x:String):Float {
		return 0.0; // TODO: implement proper parsing
	}
	
	public static function parseInt(x:String):Null<Int> {
		return 0; // TODO: implement proper parsing
	}
}