echo 'From Node.js:'
echo
node -e "console.log(require.resolve('@metro-exports/root-shorthand'))"

echo
echo '----------------------------------------'
echo 'From enhanced-resolve:'
echo
node enhanced-resolve.js "@metro-exports/root-shorthand"

echo
echo '----------------------------------------'
echo 'From metro-resolve:'
echo
node metro-resolver.js "@metro-exports/root-shorthand"
