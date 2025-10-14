class SwitchTest {
    static function getDayName(day: Int): String {
        return switch (day) {
            case 1: "Monday";
            case 2: "Tuesday";
            case 3: "Wednesday";
            case 4: "Thursday";
            case 5: "Friday";
            case 6: "Saturday";
            case 7: "Sunday";
            default: "Invalid day";
        }
    }
    
    static function categorizeNumber(num: Int): String {
        return switch (num) {
            case 0: "Zero";
            case 1 | 2 | 3: "Small positive";
            case n if (n > 3 && n <= 10): "Medium positive";
            case n if (n > 10): "Large positive";
            case n if (n < 0): "Negative";
            default: "Unknown";
        }
    }
    
    static function main() {
        for (day in 1...8) {
            trace("Day " + day + ": " + getDayName(day));
        }
        
        var testNumbers = [0, 2, 5, 15, -3];
        for (num in testNumbers) {
            trace("Number " + num + ": " + categorizeNumber(num));
        }
    }
}