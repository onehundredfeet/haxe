class Point {
    var x: Int;
    var y: Int;
    
    public function new(x: Int, y: Int) {
        this.x = x;
        this.y = y;
    }
    
    public function getDistance(): Float {
        return Math.sqrt(x * x + y * y);
    }
    
    public function toString(): String {
        return "Point(" + x + ", " + y + ")";
    }
}

class ObjectTest {
    static function main() {
        var p1 = new Point(3, 4);
        trace("Point 1: " + p1.toString());
        
        var p2 = new Point(0, 0);
        trace("Point 2: " + p2.toString());
        
        var origin = new Point(5, 12);
        trace("Distance from origin: " + origin.getDistance());
    }
}