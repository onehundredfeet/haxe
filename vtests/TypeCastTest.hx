class TypeCastTest {
	static function main() {
		// Basic type casting
		var floatValue:Float = 3.14;
		var intValue:Int = cast floatValue;
		trace("Cast float to int: " + intValue);
		
		// String to Dynamic cast
		var str:String = "hello";
		var dynValue:Dynamic = cast str;
		trace("Cast to dynamic: " + dynValue);
		
		// Safe casting with type check
		var value:Dynamic = 42;
		var safeInt:Null<Int> = cast(value, Int);
		if (safeInt != null) {
			trace("Safe cast succeeded: " + safeInt);
		}
	}
}