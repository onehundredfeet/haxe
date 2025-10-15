class StandardMathTest {
  static function main() {
    trace('=== Math Functions ===');
    trace('abs(-5): ' + Math.abs(-5));
    trace('min(3, 7): ' + Math.min(3, 7));
    trace('max(3, 7): ' + Math.max(3, 7));
    trace('sqrt(16): ' + Math.sqrt(16));
    trace('pow(2, 3): ' + Math.pow(2, 3));
    trace('sin(Math.PI/2): ' + Math.sin(Math.PI/2));
    trace('cos(0): ' + Math.cos(0));
    trace('floor(3.7): ' + Math.floor(3.7));
    trace('ceil(3.2): ' + Math.ceil(3.2));
    trace('round(3.6): ' + Math.round(3.6));
    
    trace('=== Math Constants ===');
    trace('PI: ' + Math.PI);
    trace('NaN: ' + Math.NaN);
    trace('NEGATIVE_INFINITY: ' + Math.NEGATIVE_INFINITY);
    trace('POSITIVE_INFINITY: ' + Math.POSITIVE_INFINITY);
    trace('isNaN(Math.NaN): ' + Math.isNaN(Math.NaN));
    trace('isNaN(5): ' + Math.isNaN(5));
  }
}
