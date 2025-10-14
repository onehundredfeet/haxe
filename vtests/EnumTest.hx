enum Color {
    Red;
    Green;
    Blue;
    RGB(r: Int, g: Int, b: Int);
}

enum Direction {
    North;
    South; 
    East;
    West;
}

class EnumTest {
    static function getColorName(color: Color): String {
        return switch (color) {
            case Red: "Red";
            case Green: "Green"; 
            case Blue: "Blue";
            case RGB(r, g, b): "RGB(" + r + "," + g + "," + b + ")";
        }
    }
    
    static function movePoint(x: Int, y: Int, dir: Direction): String {
        return switch (dir) {
            case North: "Moving to (" + x + "," + (y + 1) + ")";
            case South: "Moving to (" + x + "," + (y - 1) + ")";
            case East: "Moving to (" + (x + 1) + "," + y + ")";
            case West: "Moving to (" + (x - 1) + "," + y + ")";
        }
    }
    
    static function main() {
        var simpleColor = Red;
        trace("Simple color: " + getColorName(simpleColor));
        
        var complexColor = RGB(255, 128, 64);
        trace("Complex color: " + getColorName(complexColor));
        
        var direction = North;
        trace(movePoint(5, 5, direction));
        
        trace(movePoint(10, 10, East));
    }
}