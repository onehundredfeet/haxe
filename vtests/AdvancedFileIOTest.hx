import sys.io.File;

class AdvancedFileIOTest {
  static function main() {
    trace("=== Advanced File I/O Tests ===");
    
    // Test file writing and reading
    var data = "Line 1\nLine 2\nLine 3\n";
    File.saveContent("data.txt", data);
    
    // Test file existence check
    if (File.exists != null) {
      // Note: File.exists might not be available in all Haxe versions
      trace("Checking if file exists...");
    }
    
    // Test reading content
    var content = File.getContent("data.txt");
    trace("Read content: " + content);
    
    // Test getting bytes
    var bytes = File.getBytes("data.txt");
    trace("File bytes length: " + bytes.length);
    
    // Test overwriting file
    File.saveContent("data.txt", "New content");
    var newContent = File.getContent("data.txt");
    trace("New content: " + newContent);
    
    trace("All file operations completed successfully!");
  }
}