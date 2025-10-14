class AdvancedSwitchTest {
	static function main() {
		// Test with integer
		var num = 5;
		switch(num) {
			case 1: trace("small");
			case 2 | 3 | 4: trace("medium");
			case 5: trace("five");
			default: trace("large");
		}
		
		// Test with string  
		var name = "bob";
		switch(name) {
			case "alice": trace("Hello Alice");
			case "bob": trace("Hi Bob");
			default: trace("Hello stranger");
		}
	}
}