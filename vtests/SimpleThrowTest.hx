class SimpleThrowTest {
	static function main() {
		try {
			throwError();
		} catch (e:Dynamic) {
			trace("Caught: " + e);
		}
	}
	
	static function throwError():Void {
		throw "Simple error message";
	}
}