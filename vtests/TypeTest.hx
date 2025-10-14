class TypeTest {
    static function main() {
        // Integer operations
        var intVal: Int = 42;
        trace("Integer: " + intVal);
        
        // Float operations
        var floatVal: Float = 3.14;
        trace("Float: " + floatVal);
        
        // Boolean operations
        var boolVal: Bool = true;
        trace("Boolean: " + boolVal);
        
        // String operations
        var strVal: String = "Haxe to V";
        trace("String: " + strVal);
        
        // Type casting and conversion
        var intToFloat: Float = intVal;
        trace("Int to Float: " + intToFloat);
        
        // Null checks
        var nullableStr: String = null;
        if (nullableStr == null) {
            trace("String is null");
        }
        
        nullableStr = "Not null anymore";
        if (nullableStr != null) {
            trace("String is not null: " + nullableStr);
        }
    }
}