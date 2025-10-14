class SimpleTypeTest {
    static function main() {
        // Integer operations
        var intVal: Int = 42;
        trace("Integer: " + intVal);
        
        // Float operations  
        var floatVal: Float = 3.14;
        trace("Float: " + floatVal);
        
        // Boolean operations
        var boolVal: Bool = true;
        if (boolVal) {
            trace("Boolean is true");
        } else {
            trace("Boolean is false");
        }
        
        // String operations
        var strVal: String = "Haxe to V";
        trace("String: " + strVal);
        
        // Basic arithmetic
        var sum = intVal + 10;
        trace("Sum: " + sum);
        
        var product = floatVal * 2.0;
        trace("Product: " + product);
    }
}