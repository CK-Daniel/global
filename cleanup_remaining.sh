#!/bin/bash

# Final script to clean up remaining wp-content references

echo "Starting final cleanup..."

# Handle specific HTML patterns
find . -name "*.html" -type f | while read file; do
  echo "Processing HTML $file..."
  
  # Fix favicon paths
  sed -i 's|href="../wp-content/themes/kueppersbusch/img/favicon/favicon.ico"|href="../img/favicon/favicon.ico"|g' "$file"
  sed -i 's|href="/wp-content/themes/kueppersbusch/img/favicon/favicon.ico"|href="/img/favicon/favicon.ico"|g' "$file"
  
  # Fix image src and data-src paths
  sed -i 's|src="/wp-content/themes/kueppersbusch/img/|src="/img/|g' "$file"
  sed -i 's|data-src="/wp-content/themes/kueppersbusch/img/|data-src="/img/|g' "$file"
  
  # Fix relative image paths
  sed -i 's|src="../wp-content/themes/kueppersbusch/img/|src="../img/|g' "$file"
  sed -i 's|data-src="../wp-content/themes/kueppersbusch/img/|data-src="../img/|g' "$file"
  
  # Additional patterns from sinks-and-taps file
  sed -i 's|/wp-content/themes/kueppersbusch/img/px.png|/img/px.png|g' "$file"
done

# Create wp-content wrapper in case there are still legacy references 
echo "Creating wp-content redirection layer for backward compatibility..."
mkdir -p wp-content/themes/kueppersbusch/img wp-content/themes/Divi/images wp-content/themes/Divi/includes/builder/images

# Create symlinks for backward compatibility
ln -sf ../../../img wp-content/themes/kueppersbusch/img
ln -sf ../../../img/divi wp-content/themes/Divi/images
ln -sf ../../../img/divi/builder wp-content/themes/Divi/includes/builder/images

echo "Final cleanup completed!"