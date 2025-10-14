class Person {
    var name: String;
    var age: Int;
    
    public function new(name: String, age: Int) {
        this.name = name;
        this.age = age;
    }
    
    public function greet(): String {
        return "Hello, I'm " + name + " and I'm " + age + " years old.";
    }
    
    public function isAdult(): Bool {
        return age >= 18;
    }
}

class ClassTest {
    static function main() {
        var person = new Person("Alice", 25);
        trace(person.greet());
        trace("Is adult: " + person.isAdult());
        
        var child = new Person("Bob", 12);
        trace(child.greet());
        trace("Is adult: " + child.isAdult());
    }
}