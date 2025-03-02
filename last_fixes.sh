#!/bin/bash

echo "Starting last fixes for wp-content references..."

# Fix history/index.html specifically
sed -i "s|href='/wp-content/themes/kueppersbusch/css/historia/normalize.min.css?ver=1.0'|href='/css/historia/normalize.min.css?ver=1.0'|g" history/index.html
sed -i "s|href='/wp-content/themes/kueppersbusch/css/historia/swiper.min.css?ver=1.0'|href='/css/historia/swiper.min.css?ver=1.0'|g" history/index.html
sed -i "s|href='/wp-content/themes/kueppersbusch/css/historia/style.css?ver=1.0'|href='/css/historia/style.css?ver=1.0'|g" history/index.html

# Fix new-energy-label/index.html specifically
sed -i "s|href='/wp-content/et-cache/1/3/72734/et-divi-dynamic-72734.css?ver=1.0'|href='/css/divi/dynamic-72734.css?ver=1.0'|g" new-energy-label/index.html

# Create directory for dynamic CSS
mkdir -p css/divi
touch css/divi/dynamic-72734.css

# Create et-cache symlink for backward compatibility
mkdir -p wp-content/et-cache/1/3/72734
touch wp-content/et-cache/1/3/72734/et-divi-dynamic-72734.css

# Create symlinks for specific locations if needed
mkdir -p css/historia
touch css/historia/normalize.min.css
touch css/historia/swiper.min.css
touch css/historia/style.css

# Check for remaining wp-content references
echo "Checking for remaining wp-content references..."
grep -rn "wp-content" --include="*.html" .

echo "Last fixes completed!"