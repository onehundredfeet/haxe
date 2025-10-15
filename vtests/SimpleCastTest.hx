class SimpleCastTest {
	static function main() {
		// Simple unsafe cast
		var floatValue:Float = 3.14;
		var intValue:Int = cast floatValue;
		trace("Cast result: " + intValue);
		
		// String cast  
		var str:String = "hello";
		var strValue:String = cast str;
		trace("String cast: " + strValue);
	}
}