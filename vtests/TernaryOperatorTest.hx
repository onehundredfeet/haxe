class TernaryOperatorTest {
    static function main() {
        // Test basic ternary operator
        var condition = true;
        var result1 = condition ? "yes" : "no";
        trace("Basic ternary: " + result1);
        
        // Test with numbers
        var x = 5;
        var result2 = x > 3 ? 10 : 20;
        trace("Number ternary: " + result2);
        
        // Test nested ternary
        var score = 85;
        var grade = score >= 90 ? "A" : (score >= 80 ? "B" : "C");
        trace("Nested ternary: " + grade);
        
        // Test with function calls
        var value = 7;
        var result3 = value % 2 == 0 ? "even" : "odd";
        trace("Function ternary: " + result3);
        
        // Test as assignment
        var isPositive = true;
        var number = isPositive ? 42 : -42;
        trace("Assignment ternary: " + number);
    }
}