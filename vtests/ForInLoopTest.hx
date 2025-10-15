class ForInLoopTest {
	static function main() {
		// Array iteration
		var numbers = [1, 2, 3, 4, 5];
		for (num in numbers) {
			trace("Number: " + num);
		}
		
		// Range iteration  
		for (i in 0...5) {
			trace("Range: " + i);
		}
	}
}