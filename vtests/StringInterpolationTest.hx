class StringInterpolationTest {
    static function main() {
        var name = "World";
        var number = 42;
        var pi = 3.14159;
        
        // String interpolation with ${}
        var message1 = 'Hello ${name}!';
        trace(message1);
        
        // String interpolation with variables
        var message2 = 'The answer is ${number}';
        trace(message2);
        
        // String interpolation with expressions
        var message3 = 'Pi is approximately ${pi}';
        trace(message3);
        
        // String interpolation with complex expressions
        var message4 = 'The sum is ${number + 10}';
        trace(message4);
        
        // String interpolation with method calls
        var message5 = 'Uppercase: ${name.toUpperCase()}';
        trace(message5);
    }
}