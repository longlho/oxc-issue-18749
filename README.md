# Reproduction for oxc issue #18749

**Issue:** oxfmt produces different Tailwind CSS class ordering between Linux and macOS

**Link:** https://github.com/oxc-project/oxc/issues/18749

## Problem

When using `experimentalTailwindcss` configuration in `.oxfmtrc.json`, `oxfmt` reorders Tailwind CSS class names inconsistently across different operating systems (Linux vs macOS).

### Example

On one platform:
```tsx
className="text-pretty break-words font-normal"
```

On another platform:
```tsx
className="font-normal text-pretty break-words"
```

## Files

- `test.tsx` - Sample React/TSX file with Tailwind CSS classes
- `.oxfmtrc.json` - Configuration with `experimentalTailwindcss` enabled
- `Dockerfile` - Docker image for testing on Linux
- `test.sh` - Automated test script to compare both platforms

## How to Reproduce

### Method 1: Automated Testing (Recommended)

```bash
# Install dependencies
npm install

# Make test script executable
chmod +x test.sh

# Run the test (will test both macOS and Linux via Docker)
./test.sh
```

This script will:
1. Install dependencies (oxfmt)
2. Format the file on macOS
3. Format the file on Linux using Docker
4. Show differences between the outputs

### Method 2: Manual Testing

#### On macOS

```bash
# Install dependencies
npm install

# Format the test file
npx oxfmt test.tsx
```

#### On Linux (using Docker)

```bash
# Build the Docker image (installs oxfmt inside)
docker build -t oxfmt-repro .

# Run the formatter in container
docker run --rm oxfmt-repro
```

### Method 3: Interactive Docker Testing

```bash
# Build and run interactively
docker build -t oxfmt-repro .
docker run -it --rm oxfmt-repro sh

# Inside container:
npx oxfmt test.tsx
```

## Expected Behavior

The Tailwind CSS class ordering should be consistent across all platforms when using the same configuration.

## Actual Behavior

The class ordering differs between Linux and macOS, causing CI failures and unnecessary diffs.

## Configuration Used

```json
{
  "experimentalTailwindcss": {
    "attributes": ["class", "className"],
    "functions": ["clsx", "cn"],
    "preserveWhitespace": true
  }
}
```

## Environment

- **oxc version:** Latest (specify your version)
- **Node.js version:** 20
- **Platforms tested:** macOS (local), Linux (Docker)
