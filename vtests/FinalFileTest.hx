import sys.io.File;

class FinalFileTest {
  static function main() {
    trace("=== Final File I/O Test ===");
    
    // Test the core File operations that we've implemented
    
    // 1. Write a file
    trace("1. Writing file...");
    File.saveContent("final.txt", "Hello from Haxe sys.io.File!\nLine 2\nLine 3\n");
    
    // 2. Read the file back
    trace("2. Reading file...");
    var content = File.getContent("final.txt");
    trace("Content: " + content);
    
    // 3. Get file as bytes
    trace("3. Getting file bytes...");
    var bytes = File.getBytes("final.txt");
    trace("File size: " + bytes.length + " bytes");
    
    // 4. Overwrite with new content
    trace("4. Overwriting file...");
    File.saveContent("final.txt", "New content after overwrite\n");
    var newContent = File.getContent("final.txt");
    trace("New content: " + newContent);
    
    trace("=== All File operations completed successfully! ===");
  }
}