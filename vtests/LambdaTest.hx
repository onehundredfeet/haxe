class LambdaTest {
	static function main() {
		// Simple lambda function
		var add = function(a:Int, b:Int):Int {
			return a + b;
		};
		
		var result = add(3, 4);
		trace("Lambda result: " + result);
		
		// Lambda with captured variable
		var multiplier = 2;
		var multiply = function(x:Int):Int {
			return x * multiplier;
		};
		
		trace("Multiply result: " + multiply(5));
		
		// Array map with lambda
		var numbers = [1, 2, 3, 4];
		var doubled = numbers.map(function(n) return n * 2);
		trace("Doubled: " + doubled);
	}
}