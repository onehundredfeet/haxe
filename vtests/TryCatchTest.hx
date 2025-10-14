class TryCatchTest {
	static function main() {
		try {
			var result = riskyOperation();
			trace("Success: " + result);
		} catch (e:Dynamic) {
			trace("Error: " + e);
		}
		
		// Test try-catch with specific exception types (if supported)
		try {
			var number = Std.parseInt("not_a_number");
			trace("Parsed: " + number);
		} catch (e:String) {
			trace("String error: " + e);
		} catch (e:Dynamic) {
			trace("Other error: " + e);
		}
	}
	
	static function riskyOperation():String {
		throw "Something went wrong!";
		return "OK";
	}
}