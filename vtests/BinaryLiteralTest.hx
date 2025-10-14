class BinaryLiteralTest {
	static function main() {
		var binaryNum = 0b1010;  // Should be 10 in decimal
		var hexNum = 0xFF;       // Should be 255 in decimal
		
		trace("Binary 0b1010 = " + binaryNum);
		trace("Hex 0xFF = " + hexNum);
		
		// Test operations with binary literals
		var result = 0b1010 + 0b0101;  // 10 + 5 = 15
		trace("0b1010 + 0b0101 = " + result);
	}
}