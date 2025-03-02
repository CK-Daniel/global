#!/bin/bash

echo "Starting final fixes for wp-content references..."

# Create missing directories for historia files
mkdir -p css/historia js/historia
mkdir -p css/product

# Copy missing files from wp-content
if [ -d wp-content/themes/kueppersbusch/css/historia ]; then
  echo "Copying historia CSS files..."
  cp -r wp-content/themes/kueppersbusch/css/historia/* css/historia/ 2>/dev/null || echo "No historia CSS files found"
fi

if [ -d wp-content/themes/kueppersbusch/js/historia ]; then
  echo "Copying historia JS files..."
  cp -r wp-content/themes/kueppersbusch/js/historia/* js/historia/ 2>/dev/null || echo "No historia JS files found"
fi

if [ -f wp-content/themes/kueppersbusch/product/css/customize-product﹖ver=1.0.css ]; then
  echo "Copying product CSS files..."
  cp wp-content/themes/kueppersbusch/product/css/customize-product﹖ver=1.0.css css/product/ 2>/dev/null || echo "No product CSS files found"
fi

# Copy top-level style files
if [ -f wp-content/themes/kueppersbusch/style-admin﹖ver=1.0.css ]; then
  cp wp-content/themes/kueppersbusch/style-admin﹖ver=1.0.css css/ 2>/dev/null || echo "No style-admin file found"
fi

if [ -f wp-content/themes/kueppersbusch/style﹖ver=1.0.css ]; then
  cp wp-content/themes/kueppersbusch/style﹖ver=1.0.css css/ 2>/dev/null || echo "No style file found"
fi

# Fix domain and wp-content references specifically in HTML
find . -name "*.html" -type f | while read file; do
  echo "Processing HTML $file for domain references..."
  
  # Replace absolute domain references
  sed -i 's|https://www.home-kueppersbusch.com/global/wp-content/|/assets/|g' "$file"
  sed -i 's|//www.home-kueppersbusch.com/global/wp-content/|/assets/|g' "$file"
  
  # Fix common patterns in historia pages
  sed -i 's|href="/wp-content/themes/kueppersbusch/css/historia/|href="/css/historia/|g' "$file"
  sed -i 's|src="/wp-content/themes/kueppersbusch/js/historia/|src="/js/historia/|g' "$file"
  sed -i 's|src="/js/historia/|src="/js/historia/|g' "$file"
  
  # Fix specific patterns in service/manuals
  sed -i 's|href='\''../../wp-content/themes/kueppersbusch/product/css/customize-product|href='\''../../css/product/customize-product|g' "$file"
  sed -i 's|href='\''../../wp-content/themes/kueppersbusch/style-admin|href='\''../../css/style-admin|g' "$file"
  sed -i 's|href='\''../../wp-content/themes/kueppersbusch/style|href='\''../../css/style|g' "$file"
  
  # Fix new-energy-label specific patterns
  sed -i 's|<img src="/wp-content/|<img src="/assets/|g' "$file"
done

# Create symlinks for specific files
mkdir -p wp-content/themes/kueppersbusch/css/historia
mkdir -p wp-content/themes/kueppersbusch/js/historia
mkdir -p wp-content/themes/kueppersbusch/product/css

# Create symlinks for historia files
ln -sf ../../../../css/historia wp-content/themes/kueppersbusch/css/historia
ln -sf ../../../../js/historia wp-content/themes/kueppersbusch/js/historia
ln -sf ../../../../css/product wp-content/themes/kueppersbusch/product/css

# Create top-level style symlinks
ln -sf ../css/style-admin.css wp-content/themes/kueppersbusch/style-admin.css
ln -sf ../css/style.css wp-content/themes/kueppersbusch/style.css

echo "Final fixes completed!"