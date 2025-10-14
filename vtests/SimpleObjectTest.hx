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

class SimpleObjectTest {
	static function main() {
		var person = new Person("Alice", 25);
		var greeting = person.greet();
		trace(greeting);
	}
}