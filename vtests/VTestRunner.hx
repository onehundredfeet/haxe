import sys.io.Process;
import sys.FileSystem;

using StringTools;

class VTestRunner {
	static var haxePath = "../haxe";
	static var stdPath = "../std";
	
	static function main() {
		trace("Running V Language Backend Test Suite");
		
		var tests = [
			new BasicTest(),
			new ArithmeticTest(),
			new StringTest()
		];
		
		var passed = 0;
		var failed = 0;
		
		for (test in tests) {
			trace('Running test: ${test.getName()}');
			try {
				if (runTest(test)) {
					trace('✓ ${test.getName()} PASSED');
					passed++;
				} else {
					trace('✗ ${test.getName()} FAILED');
					failed++;
				}
			} catch (e:Dynamic) {
				trace('✗ ${test.getName()} ERROR: $e');
				failed++;
			}
		}
		
		trace('');
		trace('Test Results: $passed passed, $failed failed');
		if (failed > 0) {
			Sys.exit(1);
		}
	}
	
	static function runTest(test:VTest):Bool {
		// Generate Haxe source
		var haxeFile = '${test.getName()}.hx';
		sys.io.File.saveContent(haxeFile, test.getHaxeSource());
		
		// Compile to V
		var vFile = '${test.getName()}.v';
		var compileCmd = 'HAXE_STD_PATH=$stdPath $haxePath -cp . -main ${test.getName()} --vlang $vFile';
		var compileResult = Sys.command(compileCmd);
		
		if (compileResult != 0) {
			trace('Failed to compile Haxe to V');
			return false;
		}
		
		if (!FileSystem.exists(vFile)) {
			trace('V file was not generated');
			return false;
		}
		
		// Compile and run V code
		var runResult = new Process('v', ['run', vFile]);
		var output = runResult.stdout.readAll().toString().trim();
		var exitCode = runResult.exitCode();
		
		if (exitCode != 0) {
			trace('V compilation/execution failed');
			var error = runResult.stderr.readAll().toString();
			if (error != "") trace('Error: $error');
			return false;
		}
		
		// Check output
		var expected = test.getExpectedOutput().trim();
		if (output != expected) {
			trace('Output mismatch:');
			trace('Expected: "$expected"');
			trace('Got:      "$output"');
			return false;
		}
		
		// Cleanup
		FileSystem.deleteFile(haxeFile);
		FileSystem.deleteFile(vFile);
		
		return true;
	}
}

abstract class VTest {
	public abstract function getName():String;
	public abstract function getHaxeSource():String;
	public abstract function getExpectedOutput():String;
}

class BasicTest extends VTest {
	public function new() {}
	
	public function getName():String {
		return "BasicTest";
	}
	
	public function getHaxeSource():String {
		return 'class BasicTest {
	static function main() {
		trace("Hello V World");
	}
}';
	}
	
	public function getExpectedOutput():String {
		return "Hello V World";
	}
}

class ArithmeticTest extends VTest {
	public function new() {}
	
	public function getName():String {
		return "ArithmeticTest";
	}
	
	public function getHaxeSource():String {
		return 'class ArithmeticTest {
	static function main() {
		var a = 10;
		var b = 5;
		trace(a + b);
		trace(a - b);
		trace(a * b);
	}
}';
	}
	
	public function getExpectedOutput():String {
		return "15\n5\n50";
	}
}

class StringTest extends VTest {
	public function new() {}
	
	public function getName():String {
		return "StringTest";
	}
	
	public function getHaxeSource():String {
		return 'class StringTest {
	static function main() {
		var name = "World";
		trace("Hello " + name);
	}
}';
	}
	
	public function getExpectedOutput():String {
		return "Hello World";
	}
}