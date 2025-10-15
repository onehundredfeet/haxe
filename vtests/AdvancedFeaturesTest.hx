class AdvancedFeaturesTest {
    static function main() {
        // Test increment/decrement operators
        var i = 5;
        trace("Pre-increment: " + (++i));
        trace("Post-increment: " + (i++));
        trace("Pre-decrement: " + (--i));
        trace("Post-decrement: " + (i--));
        trace("Final value: " + i);
        
        // Test compound expressions
        var result = (i + 1) * (i - 1);
        trace("Compound expression: " + result);
        
        // Test bitwise operations
        var a = 12; // 1100 in binary
        var b = 10; // 1010 in binary
        trace("Bitwise AND: " + (a & b)); // Should be 8 (1000)
        trace("Bitwise OR: " + (a | b)); // Should be 14 (1110) 
        trace("Bitwise XOR: " + (a ^ b)); // Should be 6 (0110)
        trace("Bitwise NOT: " + (~a)); // Should be -13
        trace("Left shift: " + (a << 1)); // Should be 24
        trace("Right shift: " + (a >> 1)); // Should be 6
    }
}