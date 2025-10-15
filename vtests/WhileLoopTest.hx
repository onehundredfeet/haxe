class WhileLoopTest {
    static function main() {
        // Basic while loop
        var i = 0;
        while (i < 5) {
            trace("Count: " + i);
            i++;
        }
        
        // While loop with condition
        var value = 10;
        while (value > 0) {
            trace("Value: " + value);
            value = value - 2;
        }
        
        // While loop with break
        var counter = 0;
        while (true) {
            if (counter >= 3) {
                break;
            }
            trace("Counter: " + counter);
            counter++;
        }
        
        // While loop with continue
        var num = 0;
        while (num < 8) {
            num++;
            if (num % 2 == 0) {
                continue;
            }
            trace("Odd number: " + num);
        }
    }
}