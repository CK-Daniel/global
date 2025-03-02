#!/bin/bash

# Create local copies of font files
mkdir -p local/fonts/bunny
mkdir -p local/fonts/google

# Function to replace Google Fonts URLs
replace_font_links() {
  find . -name "*.html" -o -name "*.css" | xargs sed -i -E \
    -e 's|https://fonts.googleapis.com/css[^"'\'']*|/local/fonts/google/fonts.css|g' \
    -e 's|https://fonts.gstatic.com/[^"'\'']*|/local/fonts/google/|g' \
    -e 's|https://fonts.bunny.net/[^"'\'']*|/local/fonts/bunny/fonts-bunny.css|g'
}

# Create placeholder font CSS files
echo "/* Local placeholder for Google Fonts */" > local/fonts/google/fonts.css
echo "/* Local placeholder for Bunny Fonts */" > local/fonts/bunny/fonts-bunny.css

echo "Running search and replace for font resources..."
replace_font_links

echo "Font localization complete!"