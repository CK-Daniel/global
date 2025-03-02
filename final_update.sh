#!/bin/bash

# Final script to update all wp-content references to the new directory structure

echo "Starting final reference updates..."

# Handle hard-coded URLs with full domain in JS/JSON data
find . -name "*.html" -type f | while read file; do
  echo "Processing HTML $file..."
  
  # Replace URLs in script data blocks (JSON)
  sed -i 's|https:\\/\\/www.home-kueppersbusch.com\\/global\\/wp-content\\/themes\\/Divi\\/images|/img/divi|g' "$file"
  sed -i 's|https:\\/\\/www.home-kueppersbusch.com\\/global\\/wp-content\\/themes\\/Divi\\/includes\\/builder\\/images|/img/divi/builder|g' "$file"
  sed -i 's|https:\\/\\/www.home-kueppersbusch.com\\/global\\/wp-content\\/themes\\/Divi\\/includes\\/builder|/js/divi|g' "$file"
  sed -i 's|https:\\/\\/www.home-kueppersbusch.com\\/global\\/wp-content\\/themes\\/Divi|/js/divi|g' "$file"
  sed -i 's|https:\\/\\/www.home-kueppersbusch.com\\/global\\/wp-content\\/themes\\/kueppersbusch|/js|g' "$file"
  sed -i 's|https:\\/\\/www.home-kueppersbusch.com\\/global\\/wp-content\\/uploads|/assets/uploads|g' "$file"
  
  # Replace URLs in text (non-JSON)
  sed -i 's|https://www.home-kueppersbusch.com/global/wp-content/themes/Divi/images|/img/divi|g' "$file"
  sed -i 's|https://www.home-kueppersbusch.com/global/wp-content/themes/Divi/includes/builder/images|/img/divi/builder|g' "$file"
  sed -i 's|https://www.home-kueppersbusch.com/global/wp-content/themes/Divi/includes/builder|/js/divi|g' "$file"
  sed -i 's|https://www.home-kueppersbusch.com/global/wp-content/themes/Divi|/js/divi|g' "$file"
  sed -i 's|https://www.home-kueppersbusch.com/global/wp-content/themes/kueppersbusch|/js|g' "$file"
  sed -i 's|https://www.home-kueppersbusch.com/global/wp-content/uploads|/assets/uploads|g' "$file"
  
  # Fix specific paths
  sed -i 's|wp-content/themes/Divi/includes/builder/frontend-builder/assets/vendors|js/divi/vendors|g' "$file"
  sed -i 's|/wp-content/themes/Divi/includes/builder/frontend-builder/assets/vendors|/js/divi/vendors|g' "$file"
  
  # Fix tinymce paths
  sed -i 's|tinymce_uri":"https:\\/\\/www.home-kueppersbusch.com\\/global\\/wp-content|tinymce_uri":"https:\\/\\/www.home-kueppersbusch.com\\/global\\/js|g' "$file"
done

# Clean up any remaining wp-content references in JS files
find . -name "*.js" -type f | while read file; do
  echo "Processing JS $file..."
  sed -i 's|https:\\/\\/www.home-kueppersbusch.com\\/global\\/wp-content|/assets|g' "$file"
  sed -i 's|https://www.home-kueppersbusch.com/global/wp-content|/assets|g' "$file"
  sed -i 's|/wp-content/|/assets/|g' "$file"
  sed -i 's|wp-content/|assets/|g' "$file"
done

# Clean up any remaining wp-content references in CSS files
find . -name "*.css" -type f | while read file; do
  echo "Processing CSS $file..."
  sed -i 's|https://www.home-kueppersbusch.com/global/wp-content|/assets|g' "$file"
  sed -i 's|/wp-content/|/assets/|g' "$file"
  sed -i 's|wp-content/|assets/|g' "$file"
done

echo "Final reference updates completed."