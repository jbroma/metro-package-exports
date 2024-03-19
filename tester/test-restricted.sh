echo 'From Node.js:'
echo
node -e "console.log(require.resolve('@metro-package-exports/restricted/features/internal/b.js'))"

echo
echo '----------------------------------------'
echo 'From enhanced-resolve:'
echo
node enhanced-resolve.js "@metro-package-exports/restricted/features/internal/b.js"

echo
echo '----------------------------------------'
echo 'From metro-resolve:'
echo
node metro-resolver.js "@metro-package-exports/restricted/features/internal/b.js"
