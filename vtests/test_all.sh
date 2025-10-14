#!/bin/bash

# Simple V Test Runner
# Tests each Haxe file, compiles to V, and runs it

export HAXE_STD_PATH=/Users/rcleven/git/haxev/std

echo "V Language Test Suite"
echo "===================="

tests=("BasicTest" "ArithmeticTest" "StringTest" "ConditionalTest" "LoopTest" "ArrayTest" "ComparisonTest" "BooleanTest" "WhileTest" "FunctionTest" "MathTest" "SimpleTypeTest" "RecursionTest")

for test in "${tests[@]}"; do
    echo
    echo "Testing $test..."
    
    # Compile Haxe to V
    if ../haxe -main $test --vlang $test.v 2>/dev/null; then
        echo "  ✓ Haxe compilation successful"
        
        # Try to run with V
        if output=$(v run $test.v 2>/dev/null); then
            echo "  ✓ V execution successful"
            echo "  Output: $output"
        else
            echo "  ✗ V execution failed"
        fi
    else
        echo "  ✗ Haxe compilation failed"
    fi
done