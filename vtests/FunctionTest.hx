class FunctionTest {
    static function greet(name: String): String {
        return "Hello " + name;
    }
    
    static function main() {
        var result = greet("V World");
        trace(result);
    }
}