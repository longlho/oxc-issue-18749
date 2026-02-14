# Dockerfile for reproducing oxfmt Linux behavior
# https://github.com/oxc-project/oxc/issues/18749

FROM node:20-slim

WORKDIR /app

# Copy test files
COPY test.tsx .
COPY .oxfmtrc.json .
COPY package.json .

# Install oxfmt locally
RUN npm install

# Run oxfmt and show output
CMD ["sh", "-c", "echo '=== Original file ===' && cat test.tsx && echo '' && echo '=== Running oxfmt ===' && npx oxfmt test.tsx && echo '' && echo '=== Formatted output ===' && cat test.tsx"]
