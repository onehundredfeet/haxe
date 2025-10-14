class ForInTest {
    static function main() {
        var numbers = [1, 2, 3, 4, 5];
        
        trace("Numbers:");
        for (num in numbers) {
            trace("Number: " + num);
        }
        
        var fruits = ["apple", "banana", "orange"];
        trace("Fruits:");
        for (fruit in fruits) {
            trace("Fruit: " + fruit);
        }
        
        // Test with range
        trace("Range 0-4:");
        for (i in 0...5) {
            trace("Index: " + i);
        }
    }
}