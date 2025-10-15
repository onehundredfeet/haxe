class NullCoalescingTest {
    static function main() {
        // Test basic null coalescing
        var nullValue:Null<String> = null;
        var defaultValue = "default";
        var result1 = nullValue ?? defaultValue;
        trace("Null coalescing: " + result1);
        
        // Test with non-null value
        var nonNullValue:Null<String> = "hello";
        var result2 = nonNullValue ?? defaultValue;
        trace("Non-null coalescing: " + result2);
        
        // Test with numbers
        var nullNumber:Null<Int> = null;
        var result3 = nullNumber ?? 42;
        trace("Number coalescing: " + result3);
        
        // Test chaining
        var a:Null<String> = null;
        var b:Null<String> = null;
        var c:Null<String> = "found";
        var result4 = a ?? b ?? c ?? "default";
        trace("Chained coalescing: " + result4);
        
        // Test with expressions
        var result5 = null ?? (10 + 5);
        trace("Expression coalescing: " + result5);
    }
}