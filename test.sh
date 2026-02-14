#!/bin/bash
# Test script to compare oxfmt output between platforms
# https://github.com/oxc-project/oxc/issues/18749

set -e

echo "========================================"
echo "Testing oxfmt Tailwind CSS ordering"
echo "Issue: https://github.com/oxc-project/oxc/issues/18749"
echo "========================================"
echo ""

# Install dependencies if needed
if [ ! -d "node_modules" ]; then
    echo ">>> Installing dependencies..."
    npm install
    echo ""
fi

# Test on macOS (if running on mac)
if [[ "$OSTYPE" == "darwin"* ]]; then
    echo ">>> Testing on macOS..."
    # Make a copy of the original
    cp test.tsx test-macos.tsx
    # Format it
    npx oxfmt test-macos.tsx 2>&1 || true
    echo "✓ macOS formatted output: test-macos.tsx"
    echo ""
fi

# Test on Linux (using Docker)
echo ">>> Testing on Linux (Docker)..."
if command -v docker &> /dev/null; then
    echo "Building Docker image..."
    docker build -t oxfmt-repro . 2>&1 | grep -E "(FROM|RUN|COPY|CMD|DONE|writing image)" || true

    echo ""
    echo "Running oxfmt in Linux container..."
    docker run --rm oxfmt-repro > linux-output.txt
    cat linux-output.txt
    echo ""

    # Extract the formatted file from container
    docker run --rm oxfmt-repro cat test.tsx > test-linux.tsx 2>/dev/null || true

    echo "✓ Linux formatted output: test-linux.tsx"
    echo ""

    # Show comparison if both outputs exist
    if [ -f test-macos.tsx ] && [ -f test-linux.tsx ]; then
        echo "========================================"
        echo ">>> COMPARISON"
        echo "========================================"
        echo ""
        if diff -u test-macos.tsx test-linux.tsx > diff.txt 2>&1; then
            echo "✅ No differences! Both platforms produce the same output."
        else
            echo "❌ DIFFERENCES FOUND!"
            echo ""
            cat diff.txt
        fi
    fi
else
    echo "⚠ Docker not found. Please install Docker to test Linux behavior."
fi

echo ""
echo "========================================"
echo "Test complete!"
echo "========================================"
