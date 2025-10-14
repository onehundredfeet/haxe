class ObjectLiteralTest {
	static function main() {
		var point = {x: 10, y: 20};
		trace("Point: " + point.x + ", " + point.y);
		
		var person = {name: "Alice", age: 25, active: true};
		trace("Person: " + person.name + " is " + person.age + " years old");
		
		// Nested object literal
		var config = {
			debug: true,
			server: {
				host: "localhost",
				port: 8080
			}
		};
		trace("Server config: " + config.server.host + ":" + config.server.port);
	}
}