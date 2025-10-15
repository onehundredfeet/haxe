import sys.io.File;

class FileIOTest {
  static function main() {
    // Test basic file operations
    trace("=== File I/O Tests ===");
    
    // Write to file
    var content = "Hello, World!\nThis is a test file.\n";
    File.saveContent("test.txt", content);
    trace("File written successfully");
    
    // Read from file
    var readContent = File.getContent("test.txt");
    trace("File content: " + readContent);
    
    // Append to file
    File.saveContent("test.txt", content + "Appended line\n");
    
    // Read again
    var finalContent = File.getContent("test.txt");
    trace("Final content: " + finalContent);
    
    // Get bytes
    var bytes = File.getBytes("test.txt");
    trace("File size: " + bytes.length);
  }
}