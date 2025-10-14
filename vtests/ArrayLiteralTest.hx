class ArrayLiteralTest {
    static function main() {
        var numbers = [1, 2, 3, 4, 5];
        trace("First number: " + numbers[0]);
        trace("Last number: " + numbers[4]);
        
        var fruits = ["apple", "banana", "orange"];
        trace("First fruit: " + fruits[0]);
        trace("Second fruit: " + fruits[1]);
        
        var mixed = [10, 20, 30];
        var sum = mixed[0] + mixed[1] + mixed[2];
        trace("Sum: " + sum);
    }
}