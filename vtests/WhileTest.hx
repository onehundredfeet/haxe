class WhileTest {
    static function main() {
        var i = 0;
        while (i < 3) {
            trace("Count: " + i);
            i = i + 1;
        }
        trace("Done counting!");
    }
}