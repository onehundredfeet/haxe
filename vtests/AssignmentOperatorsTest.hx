class AssignmentOperatorsTest {
    static function main() {
        // Test += operator
        var a = 5;
        a += 3;
        trace("Addition assignment: " + a); // Should be 8
        
        // Test -= operator
        var b = 10;
        b -= 4;
        trace("Subtraction assignment: " + b); // Should be 6
        
        // Test *= operator
        var c = 3;
        c *= 4;
        trace("Multiplication assignment: " + c); // Should be 12
        
        // Test /= operator
        var d = 20.0;
        d /= 5;
        trace("Division assignment: " + d); // Should be 4
        
        // Test %= operator
        var e = 17;
        e %= 5;
        trace("Modulo assignment: " + e); // Should be 2
        
        // Test with expressions
        var f = 100;
        f += (10 + 5);
        trace("Expression assignment: " + f); // Should be 115
        
        // Test chained usage
        var g = 1;
        g += 2;
        g *= 3;
        g -= 1;
        trace("Chained assignments: " + g); // Should be 8
    }
}