# Metro Package Exports

This repository shows 2 edge cases where `metro-resolver` behaves different than both Node.js `require.resolve` and `enhanced-resolve`

## Setup

1. Install dependencies via `yarn` v1 (classic)
2. Make test scripts inside of `tester` directory executable using `chmod +x`
3. Run `test-root-shorthand.sh` & `test-restricted.sh`

## Description

1. Root Array shorthand implementation differs from Node.js / Webpack's `enhanced-resolve` spec:

```json
{
  "name": "@metro-package-exports/root-shorthand",
  "exports": ["./index.js"]
}
```

### Results:

Import specifier: `@metro-package-exports/root-shorthand`

- node.js -> resolves to `index.js` inside of `@metro-package-exports/root-shorthand`
- enhanced-resolve -> resolves to `index.js` inside of `@metro-package-exports/root-shorthand`
- metro-resolver -> fails to resolve, fallbacks to file resolution and resolves to `@metro-package-exports/root-shorthand` directory

2. Subpath patterns in `exports` matching import specifier

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

### Results:

Import specifier: `@metro-package-exports/restricted/features/internal/b.js`

- node.js -> fails to resolve, `b.js` is not exported from `@metro-package-exports/restricted`
- enhanced-resolve -> fails to resolve, `b.js` is not exported from `@metro-package-exports/restricted`
- metro-resolver -> resolves to `@metro-package-exports/restricted/features/internal/b.js` without falling back to file resolution
