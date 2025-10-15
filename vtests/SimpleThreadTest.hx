import sys.thread.Thread;

class SimpleThreadTest {
  static function simpleWorker():Void {
    trace("Hello from worker thread!");
  }
  
  static function main() {
    trace("=== Simple Thread Test ===");
    trace("Creating a thread...");
    
    var thread = Thread.create(simpleWorker);
    
    trace("Main thread continuing...");
    trace("Thread test completed!");
  }
}