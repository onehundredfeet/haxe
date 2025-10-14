class MathTest {
    static function add(a: Int, b: Int): Int {
        return a + b;
    }
    
    static function multiply(x: Float, y: Float): Float {
        return x * y;
    }
    
    static function factorial(n: Int): Int {
        if (n <= 1) {
            return 1;
        }
        return n * factorial(n - 1);
    }
    
    static function main() {
        trace("Addition: " + add(5, 3));
        trace("Multiplication: " + multiply(2.5, 4.0));
        trace("Factorial of 5: " + factorial(5));
        
        var result = add(10, 20);
        trace("Stored result: " + result);
    }
}