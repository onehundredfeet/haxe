class NestedTest {
    static function processNumbers(numbers: Array<Int>): Void {
        for (i in 0...numbers.length) {
            var num = numbers[i];
            if (num > 0) {
                if (num % 2 == 0) {
                    trace("Positive even: " + num);
                } else {
                    trace("Positive odd: " + num);
                }
            } else if (num < 0) {
                trace("Negative: " + num);
            } else {
                trace("Zero");
            }
        }
    }
    
    static function main() {
        var numbers = [1, -2, 3, 0, 4, -5];
        trace("Processing numbers:");
        processNumbers(numbers);
        
        var count = 0;
        while (count < 3) {
            if (count == 1) {
                trace("Middle iteration: " + count);
            } else {
                trace("Regular iteration: " + count);
            }
            count++;
        }
    }
}