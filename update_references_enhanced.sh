#!/bin/bash

# Script to update all wp-content references to the new directory structure

echo "Starting enhanced reference updates..."

# Update references in HTML files
find . -name "*.html" -type f | while read file; do
  echo "Processing $file..."
  
  # 1. Update theme references
  sed -i 's|wp-content/themes/Divi/js/|js/divi/|g' "$file"
  sed -i 's|wp-content/themes/Divi/core/admin/js/|js/divi/admin/|g' "$file"
  sed -i 's|wp-content/themes/Divi/core/admin/fonts/|fonts/divi/admin/|g' "$file"
  sed -i 's|wp-content/themes/kueppersbusch/js/|js/|g' "$file"
  sed -i 's|wp-content/themes/kueppersbusch/fonts/|fonts/|g' "$file"
  
  # 2. Update plugin references
  sed -i 's|wp-content/plugins/|plugins/|g' "$file"
  
  # 3. Update upload references
  sed -i 's|wp-content/uploads/|assets/uploads/|g' "$file"
  
  # 4. Update relative paths
  sed -i 's|../wp-content/themes/Divi/js/|../js/divi/|g' "$file"
  sed -i 's|../wp-content/themes/Divi/core/admin/js/|../js/divi/admin/|g' "$file"
  sed -i 's|../wp-content/themes/Divi/core/admin/fonts/|../fonts/divi/admin/|g' "$file"
  sed -i 's|../wp-content/themes/kueppersbusch/js/|../js/|g' "$file"
  sed -i 's|../wp-content/themes/kueppersbusch/fonts/|../fonts/|g' "$file"
  sed -i 's|../wp-content/plugins/|../plugins/|g' "$file"
  sed -i 's|../wp-content/uploads/|../assets/uploads/|g' "$file"
  
  # 5. Update full URLs
  sed -i 's|\/wp-content\/themes\/Divi\/|\/js\/divi\/|g' "$file"
  sed -i 's|https:\/\/www.home-kueppersbusch.com\/global\/wp-content\/themes\/Divi\/|\/js\/divi\/|g' "$file"
  sed -i 's|\/\/www.home-kueppersbusch.com\/global\/wp-content\/themes\/Divi\/|\/js\/divi\/|g' "$file"
  
  # 6. Fix specific includes
  sed -i 's|wp-content/themes/Divi/includes/builder/feature/dynamic-assets/assets/js/|js/divi/|g' "$file"
  sed -i 's|/wp-content/themes/Divi/includes/builder/feature/dynamic-assets/assets/js/|/js/divi/|g' "$file"
done

# Update references in CSS files
find . -name "*.css" -type f | while read file; do
  echo "Processing CSS $file..."
  
  # Similar replacements for CSS files
  sed -i 's|wp-content/themes/Divi/|css/divi/|g' "$file"
  sed -i 's|wp-content/themes/kueppersbusch/|css/|g' "$file"
  sed -i 's|wp-content/plugins/|plugins/|g' "$file"
  sed -i 's|wp-content/uploads/|assets/uploads/|g' "$file"
  
  # Relative paths in CSS
  sed -i 's|../wp-content/themes/Divi/|../css/divi/|g' "$file"
  sed -i 's|../wp-content/themes/kueppersbusch/|../css/|g' "$file"
  sed -i 's|../wp-content/plugins/|../plugins/|g' "$file"
  sed -i 's|../wp-content/uploads/|../assets/uploads/|g' "$file"
  
  # Full URLs in CSS
  sed -i 's|https:\/\/www.home-kueppersbusch.com\/global\/wp-content\/|\/assets\/|g' "$file"
  sed -i 's|\/\/www.home-kueppersbusch.com\/global\/wp-content\/|\/assets\/|g' "$file"
done

# Update references in JS files
find . -name "*.js" -type f | while read file; do
  echo "Processing JS $file..."
  
  # Similar replacements for JS files
  sed -i 's|wp-content/themes/Divi/|js/divi/|g' "$file"
  sed -i 's|wp-content/themes/kueppersbusch/|js/|g' "$file"
  sed -i 's|wp-content/plugins/|plugins/|g' "$file"
  sed -i 's|wp-content/uploads/|assets/uploads/|g' "$file"
  
  # Relative paths in JS
  sed -i 's|../wp-content/themes/Divi/|../js/divi/|g' "$file"
  sed -i 's|../wp-content/themes/kueppersbusch/|../js/|g' "$file"
  sed -i 's|../wp-content/plugins/|../plugins/|g' "$file"
  sed -i 's|../wp-content/uploads/|../assets/uploads/|g' "$file"
  
  # Full URLs in JS
  sed -i 's|https:\/\/www.home-kueppersbusch.com\/global\/wp-content\/|\/assets\/|g' "$file"
  sed -i 's|\/\/www.home-kueppersbusch.com\/global\/wp-content\/|\/assets\/|g' "$file"
done

echo "Enhanced reference updates completed."