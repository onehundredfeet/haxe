class SwitchExpressionTest {
	static function main() {
		var x = 2;
		switch(x) {
			case 1: trace("one");
			case 2: trace("two");
			case 3: trace("three");
			default: trace("other");
		}
	}
}