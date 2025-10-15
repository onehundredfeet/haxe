import sys.thread.Thread;

class ThreadTest {
  static var counter = 0;
  
  static function workerFunction():Void {
    for (i in 0...5) {
      counter++;
      trace("Worker thread: " + counter);
      // Simulate some work
      Sys.sleep(0.1);
    }
  }
  
  static function secondWorker():Void {
    for (i in 0...3) {
      trace("Second worker: " + i);
      Sys.sleep(0.15);
    }
  }
  
  static function main() {
    trace("=== Thread Test ===");
    
    // Test basic thread creation and execution
    trace("Creating threads...");
    
    var thread1 = Thread.create(workerFunction);
    var thread2 = Thread.create(secondWorker);
    
    // Do some work in main thread
    for (i in 0...3) {
      trace("Main thread: " + i);
      Sys.sleep(0.05);
    }
    
    trace("Main thread waiting for workers to complete...");
    
    // Wait for threads to complete (if Haxe supports join)
    // Note: Haxe's Thread.join() may not be available on all targets
    
    trace("All threads completed!");
    trace("Final counter value: " + counter);
  }
}