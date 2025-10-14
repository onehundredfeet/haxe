class AdvancedArrayTest {
    static function sumArray(arr: Array<Int>): Int {
        var sum = 0;
        for (value in arr) {
            sum += value;
        }
        return sum;
    }
    
    static function findMax(arr: Array<Int>): Int {
        var max = arr[0];
        for (i in 1...arr.length) {
            if (arr[i] > max) {
                max = arr[i];
            }
        }
        return max;
    }
    
    static function reverseArray(arr: Array<String>): Array<String> {
        var reversed = [];
        var i = arr.length - 1;
        while (i >= 0) {
            reversed.push(arr[i]);
            i--;
        }
        return reversed;
    }
    
    static function main() {
        var numbers = [1, 5, 3, 9, 2, 7];
        trace("Numbers: " + numbers);
        trace("Sum: " + sumArray(numbers));
        trace("Max: " + findMax(numbers));
        
        var words = ["hello", "world", "haxe", "vlang"];
        var reversed = reverseArray(words);
        trace("Original: " + words);
        trace("Reversed: " + reversed);
        
        // Array manipulation
        var mutableArray = [1, 2, 3];
        mutableArray.push(4);
        mutableArray.push(5);
        trace("After pushing: " + mutableArray);
    }
}