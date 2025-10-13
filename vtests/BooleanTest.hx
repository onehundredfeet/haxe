class BooleanTest {
    static function main() {
        var isTrue = true;
        var isFalse = false;
        
        if (isTrue && !isFalse) {
            trace("Logic works!");
        }
        
        if (isTrue || isFalse) {
            trace("OR logic works!");
        }
    }
}