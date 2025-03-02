#!/bin/bash

# Final cleanup for remaining hard-to-find wp-content references

echo "Starting extensive cleanup..."

# Find all HTML files
find . -name "*.html" -type f | while read file; do
  echo "Processing HTML $file..."
  
  # Fix all possible relative path variations
  sed -i 's|src="../../wp-content/themes/kueppersbusch/img/|src="../../img/|g' "$file"
  sed -i 's|src="../../wp-content/|src="../../assets/|g' "$file"
  sed -i 's|src="../../../wp-content/|src="../../../assets/|g' "$file"
  sed -i 's|href="../../wp-content/|href="../../assets/|g' "$file"
  sed -i 's|href="../../../wp-content/|href="../../../assets/|g' "$file"
  
  # Fix the most specific patterns from the examples
  sed -i 's|src="../../wp-content/themes/kueppersbusch/img/kuppersbusch-white.svg"|src="../../img/kuppersbusch-white.svg"|g' "$file"
  
  # Fix all additional possible variations
  sed -i 's|"../wp-content/themes/kueppersbusch/img/|"../img/|g' "$file"
  sed -i 's|"../../wp-content/themes/kueppersbusch/img/|"../../img/|g' "$file"
  sed -i 's|"../../../wp-content/themes/kueppersbusch/img/|"../../../img/|g' "$file"
  
  # Deeper nested paths
  sed -i 's|"../wp-content/themes/Divi/|"../js/divi/|g' "$file"
  sed -i 's|"../../wp-content/themes/Divi/|"../../js/divi/|g' "$file"
  sed -i 's|"../../../wp-content/themes/Divi/|"../../../js/divi/|g' "$file"
done

echo "Creating unified directory structure document..."

# Create a README document for the new directory structure
cat > /workspaces/global/DIRECTORY_STRUCTURE.md << EOL
# Directory Structure Overview

This document outlines the unified directory structure after removing wp-content references.

## Main Asset Directories

- **/assets/** - Main assets directory containing uploads and other assets
  - **/assets/css/** - CSS files
  - **/assets/js/** - JavaScript files
  - **/assets/fonts/** - Font files
  - **/assets/images/** - Image files
  - **/assets/uploads/** - User uploads, organized by date

- **/css/** - CSS files
  - **/css/divi/** - Divi theme CSS files

- **/js/** - JavaScript files
  - **/js/divi/** - Divi theme JS files
  - **/js/select2/** - Select2 library
  - **/js/slick/** - Slick slider
  - **/js/jssocials/** - JS Socials library
  - **/js/tooltipster/** - Tooltipster library
  - **/js/featherlight/** - Featherlight lightbox

- **/fonts/** - Font files
  - **/fonts/divi/** - Divi theme fonts

- **/img/** - Image files
  - **/img/divi/** - Divi theme images
  - **/img/favicon/** - Favicon images

- **/plugins/** - WordPress plugin files

## Backward Compatibility

For backward compatibility with any remaining wp-content references, symbolic links have been created:

- **/wp-content/themes/kueppersbusch/img/** → **/img/**
- **/wp-content/themes/Divi/images/** → **/img/divi/**
- **/wp-content/themes/Divi/includes/builder/images/** → **/img/divi/builder/**

This ensures that any missed references continue to work while the codebase transitions to the new structure.

## Benefits of the New Structure

1. **Simplified Paths** - All asset paths are shorter and more intuitive
2. **Improved Organization** - Assets are organized by type rather than by WordPress structure
3. **Non-WordPress Compatibility** - Site structure no longer requires WordPress knowledge to navigate
4. **Future-Proofing** - Structure is independent of the CMS and more portable
EOL

echo "Extensive cleanup completed!"
echo "New directory structure documented in DIRECTORY_STRUCTURE.md"