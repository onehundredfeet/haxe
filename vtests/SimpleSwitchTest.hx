class SimpleSwitchTest {
	static function main() {
		var x = 2;
		var result = switch(x) {
			case 1: "one";
			case 2: "two";
			case 3: "three";
			default: "other";
		};
		trace("Result: " + result);
	}
}