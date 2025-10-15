class SimpleLambdaTest {
    static function main() {
        // Simple lambda without closure
        var add = function(a:Int, b:Int):Int {
            return a + b;
        };
        var result = add(3, 4);
        trace("Lambda result: " + result);
        
        // Lambda that just transforms input
        var multiply = function(x:Int):Int {
            return x * 2;
        };
        trace("Multiply result: " + multiply(5));
    }
}