import sys.io.File;

class SimpleFileTest {
  static function main() {
    trace("=== Simple File I/O Tests ===");
    
    // Test basic file operations that exist in Haxe sys.io.File
    var data = "Hello from Haxe!\nSecond line\n";
    
    // Write file
    File.saveContent("simple.txt", data);
    trace("File written successfully");
    
    // Read file
    var content = File.getContent("simple.txt");
    trace("Read content: " + content);
    
    // Get file as bytes
    var bytes = File.getBytes("simple.txt");
    trace("File size in bytes: " + bytes.length);
    
    // Write different content (overwrite)
    File.saveContent("simple.txt", "Overwritten content\n");
    var newContent = File.getContent("simple.txt");
    trace("New content: " + newContent);
    
    trace("File operations completed!");
  }
}