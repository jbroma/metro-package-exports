#!/bin/bash
TARGET_PATH="@metro-package-exports/root-shorthand"

echo "Resolution target: $TARGET_PATH"
echo

echo 'From Node.js:'
echo
node -e "console.log(require.resolve('$TARGET_PATH'))"

echo
echo '----------------------------------------'
echo 'From enhanced-resolve:'
echo
node enhanced-resolve.js "$TARGET_PATH"

echo
echo '----------------------------------------'
echo 'From metro-resolve:'
echo
node metro-resolver.js "$TARGET_PATH"
