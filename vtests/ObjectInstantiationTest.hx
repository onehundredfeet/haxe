class Point {
	public var x:Int;
	public var y:Int;
	
	public function new(x:Int, y:Int) {
		this.x = x;
		this.y = y;
	}
	
	public function toString():String {
		return "Point(" + Std.string(this.x) + ", " + Std.string(this.y) + ")";
	}
}

class Person {
	public var name:String;
	public var age:Int;
	
	public function new(name:String, age:Int) {
		this.name = name;
		this.age = age;
	}
	
	public function greet():String {
		return "Hello, I am " + this.name + " and I am " + Std.string(this.age) + " years old";
	}
}

class ObjectInstantiationTest {
	static function main() {
		var point = new Point(10, 20);
		trace(point.toString());
		
		var person = new Person("Bob", 30);
		trace(person.greet());
	}
}