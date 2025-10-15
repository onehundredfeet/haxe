import sys.io.File;

class FileErrorTest {
  static function main() {
    trace("=== File Error Handling Tests ===");
    
    // Test successful operation first
    File.saveContent("good.txt", "This works!");
    var content = File.getContent("good.txt");
    trace("Success: " + content);
    
    // Test error handling - this should trigger the panic
    trace("Now testing error handling...");
    try {
      var badContent = File.getContent("nonexistent.txt");
      trace("This shouldn't print: " + badContent);
    } catch (e:Dynamic) {
      trace("Caught error (this might not work in V)");
    }
  }
}