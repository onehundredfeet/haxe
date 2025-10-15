class ArrayMethodsTest {
    static function main() {
        // Test array map
        var numbers = [1, 2, 3, 4, 5];
        var doubled = numbers.map(function(x) return x * 2);
        trace("Original: " + numbers);
        trace("Doubled: " + doubled);
        
        // Test array filter
        var filtered = numbers.filter(function(x) return x % 2 == 0);
        trace("Even numbers: " + filtered);
        
        // Test combined map and filter
        var processed = numbers
            .filter(function(x) return x > 2)
            .map(function(x) return x * 3);
        trace("Filtered and tripled: " + processed);
        
        // Test with string array
        var words = ["hello", "world", "test"];
        var uppercase = words.map(function(s) return s.toUpperCase());
        trace("Uppercase: " + uppercase);
        
        // Test filter with strings
        var longWords = words.filter(function(s) return s.length > 4);
        trace("Long words: " + longWords);
    }
}