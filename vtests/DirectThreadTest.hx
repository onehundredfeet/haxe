import sys.thread.Thread;

class DirectThreadTest {
  static function main() {
    trace("=== Direct Thread Test ===");
    
    // Use inline function instead of reference
    Thread.create(function() {
      trace("Hello from inline thread!");
    });
    
    trace("Main thread done!");
  }
}