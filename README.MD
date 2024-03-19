# Metro Package Exports

This repository demonstrates two edge cases where `metro-resolver` behaves differently from both Node.js's `require.resolve` and `enhanced-resolve` from Webpack.

## Setup

To get started with this project, follow these steps:

1. Install dependencies via `yarn` v1 (classic).
2. Make the test scripts within the `tester` directory executable by running `chmod +x` on them.
3. Execute `test-root-shorthand.sh` & `test-restricted.sh` scripts.

## Description

The cases outlined below highlight the differences in resolving mechanisms between `metro-resolver` and the other resolvers.

### 1. Root Array Shorthand

For the Root Array shorthand, the implementation differs when compared to Node.js or Webpack's `enhanced-resolve` specification:

```json
{
  "name": "@metro-package-exports/root-shorthand",
  "exports": ["./index.js"]
}
```

#### Results:

For the import specifier: `@metro-package-exports/root-shorthand`

- **Node.js**: Resolves to `index.js` inside of `@metro-package-exports/root-shorthand`.
- **enhanced-resolve**: Identically resolves to `index.js` within `@metro-package-exports/root-shorthand`.
- **metro-resolver**: Fails to resolve, falling back to file resolution and ultimately resolving to the `@metro-package-exports/root-shorthand` directory itself.

### 2. Subpath Patterns in `exports`

When using subpath patterns in `exports` to match the import specifier, the behaviors observed are as follows:

```json
{
  "name": "@metro-package-exports/restricted",
  "exports": {
    ".": "./index.js",
    "./features/*.js": "./features/*.js",
    "./features/internal/*.js": null
  }
}
```

#### Results:

For the import specifier: `@metro-package-exports/restricted/features/internal/b.js`

- **Node.js**: Fails to resolve as `b.js` is not exported from `@metro-package-exports/restricted`.
- **enhanced-resolve**: Also fails to resolve for the same reason as Node.js.
- **metro-resolver**: Successfully resolves to `@metro-package-exports/restricted/features/internal/b.js` without falling back to file resolution.
