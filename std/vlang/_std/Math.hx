/*
 * Copyright (C)2005-2019 Haxe Foundation
 *
 * Permission is hereby granted, free of charge, to any person obtaining a
 * copy of this software and associated documentation files (the "Software"),
 * to deal in the Software without restriction, including without limitation
 * the rights to use, copy, modify, merge, publish, distribute, sublicense,
 * and/or sell copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 * DEALINGS IN THE SOFTWARE.
 */

/**
	This class defines mathematical functions and constants for the V target.
	
	V backend implementation using V's built-in math module.
**/
@:coreApi
class Math {
	/**
		Represents the ratio of the circumference of a circle to its diameter,
		specified by the constant, π. `PI` is approximately `3.141592653589793`.
	**/
	public static var PI(default, null):Float = untyped __v__("math.pi");

	/**
		A special `Float` constant which denotes negative infinity.
	**/
	public static var NEGATIVE_INFINITY(default, null):Float = untyped __v__("-math.inf");

	/**
		A special `Float` constant which denotes positive infinity.
	**/
	public static var POSITIVE_INFINITY(default, null):Float = untyped __v__("math.inf");

	/**
		A special `Float` constant which denotes an invalid number.
		`NaN` stands for "Not a Number".
	**/
	public static var NaN(default, null):Float = untyped __v__("math.nan()");

	/**
		Returns the absolute value of `v`.
	**/
	public static function abs(v:Float):Float {
		return untyped __v__("math.abs({0})", v);
	}

	/**
		Returns the smaller of values `a` and `b`.
	**/
	public static function min(a:Float, b:Float):Float {
		return untyped __v__("math.min({0}, {1})", a, b);
	}

	/**
		Returns the greater of values `a` and `b`.
	**/
	public static function max(a:Float, b:Float):Float {
		return untyped __v__("math.max({0}, {1})", a, b);
	}

	/**
		Returns the trigonometric sine of the specified angle `v`, in radians.
	**/
	public static function sin(v:Float):Float {
		return untyped __v__("math.sin({0})", v);
	}

	/**
		Returns the trigonometric cosine of the specified angle `v`, in radians.
	**/
	public static function cos(v:Float):Float {
		return untyped __v__("math.cos({0})", v);
	}

	/**
		Returns the trigonometric tangent of the specified angle `v`, in radians.
	**/
	public static function tan(v:Float):Float {
		return untyped __v__("math.tan({0})", v);
	}

	/**
		Returns the trigonometric arc sine of the specified angle `v`, in radians.
	**/
	public static function asin(v:Float):Float {
		return untyped __v__("math.asin({0})", v);
	}

	/**
		Returns the trigonometric arc cosine of the specified angle `v`, in radians.
	**/
	public static function acos(v:Float):Float {
		return untyped __v__("math.acos({0})", v);
	}

	/**
		Returns the trigonometric arc tangent of the specified angle `v`, in radians.
	**/
	public static function atan(v:Float):Float {
		return untyped __v__("math.atan({0})", v);
	}

	/**
		Returns the arc tangent of `y/x`, in radians.
	**/
	public static function atan2(y:Float, x:Float):Float {
		return untyped __v__("math.atan2({0}, {1})", y, x);
	}

	/**
		Returns Euler's number, raised to the power of `v`.
	**/
	public static function exp(v:Float):Float {
		return untyped __v__("math.exp({0})", v);
	}

	/**
		Returns the natural logarithm of `v`.
	**/
	public static function log(v:Float):Float {
		return untyped __v__("math.log({0})", v);
	}

	/**
		Returns the value of `v`, raised to the power of `exp`.
	**/
	public static function pow(v:Float, exp:Float):Float {
		return untyped __v__("math.pow({0}, {1})", v, exp);
	}

	/**
		Returns the square root of `v`.
	**/
	public static function sqrt(v:Float):Float {
		return untyped __v__("math.sqrt({0})", v);
	}

	/**
		Returns the largest integer value that is not greater than `v`.
	**/
	public static function floor(v:Float):Int {
		return untyped __v__("int(math.floor({0}))", v);
	}

	/**
		Returns the smallest integer value that is not less than `v`.
	**/
	public static function ceil(v:Float):Int {
		return untyped __v__("int(math.ceil({0}))", v);
	}

	/**
		Rounds `v` to the nearest integer value.
	**/
	public static function round(v:Float):Int {
		return untyped __v__("int(math.round({0}))", v);
	}

	/**
		Returns a pseudo-random number which is greater than or equal to 0.0,
		and less than 1.0.
	**/
	public static function random():Float {
		return untyped __v__("math.random()");
	}

	/**
		Tells if `f` is a finite number.
	**/
	public static function isFinite(f:Float):Bool {
		return untyped __v__("math.is_finite({0})", f);
	}

	/**
		Tells if `f` is not a valid number.
	**/
	public static function isNaN(f:Float):Bool {
		return untyped __v__("math.is_nan({0})", f);
	}

	/**
		Returns the floating-point remainder of `f1/f2`.
	**/
	public static function fmod(f1:Float, f2:Float):Float {
		return untyped __v__("math.fmod({0}, {1})", f1, f2);
	}

	/**
		Returns the greater precision floating point operations.
	**/
	public static function ffloor(v:Float):Float {
		return untyped __v__("math.floor({0})", v);
	}

	/**
		Returns the greater precision floating point operations.
	**/
	public static function fceil(v:Float):Float {
		return untyped __v__("math.ceil({0})", v);
	}

	/**
		Returns the greater precision floating point operations.
	**/
	public static function fround(v:Float):Float {
		return untyped __v__("math.round({0})", v);
	}
}