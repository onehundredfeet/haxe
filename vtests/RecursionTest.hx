class RecursionTest {
    static function fibonacci(n: Int): Int {
        if (n <= 1) {
            return n;
        }
        return fibonacci(n - 1) + fibonacci(n - 2);
    }
    
    static function power(base: Int, exp: Int): Int {
        if (exp == 0) {
            return 1;
        }
        return base * power(base, exp - 1);
    }
    
    static function main() {
        trace("Fibonacci 10: " + fibonacci(10));
        trace("2^5 = " + power(2, 5));
        trace("3^4 = " + power(3, 4));
    }
}