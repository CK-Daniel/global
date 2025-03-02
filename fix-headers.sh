#!/bin/bash

# This script standardizes headers across all pages and fixes relative paths

echo "Standardizing headers and fixing relative paths..."

# Create a directory for backups
mkdir -p backups

# Extract the main header from index.html to use as a template
HEADER=$(sed -n '/<\!DOCTYPE html>/,/<\/header>/p' index.html)

# Process all index.html files
find . -name "index.html" ! -path "./index.html" | while read file; do
    echo "Processing $file"
    
    # Create backup
    parent_dir=$(dirname "$file")
    backup_name=$(echo "$parent_dir" | sed 's|^\./||; s|/|_|g')
    cp "$file" "backups/${backup_name}_index.html"
    
    # Get the body content after </header>
    BODY=$(sed -n '/<\/header>/,$p' "$file" | tail -n +2)
    
    # Calculate the relative path depth
    DEPTH=$(echo "$file" | tr -cd '/' | wc -c)
    DEPTH=$((DEPTH - 1))  # Adjust for leading ./
    
    # Create temp header file
    echo "$HEADER" > temp_header.html
    
    # Create relative path prefix
    REL_PATH=""
    for ((i=0; i<DEPTH; i++)); do
        REL_PATH="../$REL_PATH"
    done
    
    if [ "$DEPTH" -gt 0 ]; then
        # Fix asset paths in header
        sed -i -E "s|href=\"css/|href=\"${REL_PATH}css/|g" temp_header.html
        sed -i -E "s|href=\"fonts/|href=\"${REL_PATH}fonts/|g" temp_header.html
        sed -i -E "s|href=\"js/|href=\"${REL_PATH}js/|g" temp_header.html
        sed -i -E "s|href=\"wp-content/|href=\"${REL_PATH}wp-content/|g" temp_header.html
        sed -i -E "s|href=\"wp-includes/|href=\"${REL_PATH}wp-includes/|g" temp_header.html
        sed -i -E "s|href=\"style|href=\"${REL_PATH}style|g" temp_header.html
        sed -i -E "s|href=\"feed/|href=\"${REL_PATH}feed/|g" temp_header.html
        sed -i -E "s|href=\"comments/|href=\"${REL_PATH}comments/|g" temp_header.html
        
        # Fix image paths
        sed -i -E "s|src=\"img/|src=\"${REL_PATH}img/|g" temp_header.html
        sed -i -E "s|src=\"wp-includes/|src=\"${REL_PATH}wp-includes/|g" temp_header.html
        sed -i -E "s|src=\"wp-content/|src=\"${REL_PATH}wp-content/|g" temp_header.html
        
        # Fix script paths
        sed -i -E "s|src=\"js/|src=\"${REL_PATH}js/|g" temp_header.html
        
        # Fix logo link and navigation links
        sed -i -E "s|<a href=\"index.html\">|<a href=\"${REL_PATH}index.html\">|g" temp_header.html
        
        # Fix navigation menu links
        sed -i -E "s|href=\"ovens-and-compacts/index.html\"|href=\"${REL_PATH}ovens-and-compacts/index.html\"|g" temp_header.html
        sed -i -E "s|href=\"hobs/index.html\"|href=\"${REL_PATH}hobs/index.html\"|g" temp_header.html
        sed -i -E "s|href=\"hoods/index.html\"|href=\"${REL_PATH}hoods/index.html\"|g" temp_header.html
        sed -i -E "s|href=\"refrigeration/index.html\"|href=\"${REL_PATH}refrigeration/index.html\"|g" temp_header.html
        sed -i -E "s|href=\"dishwashers/index.html\"|href=\"${REL_PATH}dishwashers/index.html\"|g" temp_header.html
        sed -i -E "s|href=\"laundry/index.html\"|href=\"${REL_PATH}laundry/index.html\"|g" temp_header.html
        sed -i -E "s|href=\"sinks-and-taps/index.html\"|href=\"${REL_PATH}sinks-and-taps/index.html\"|g" temp_header.html
        sed -i -E "s|href=\"brand/index.html\"|href=\"${REL_PATH}brand/index.html\"|g" temp_header.html
        sed -i -E "s|href=\"design/index.html\"|href=\"${REL_PATH}design/index.html\"|g" temp_header.html
        sed -i -E "s|href=\"in-the-world/index.html\"|href=\"${REL_PATH}in-the-world/index.html\"|g" temp_header.html
        sed -i -E "s|href=\"history/index.html\"|href=\"${REL_PATH}history/index.html\"|g" temp_header.html
        sed -i -E "s|href=\"downloads/index.html\"|href=\"${REL_PATH}downloads/index.html\"|g" temp_header.html
        sed -i -E "s|href=\"service/index.html\"|href=\"${REL_PATH}service/index.html\"|g" temp_header.html
        sed -i -E "s|href=\"k-series/index.html\"|href=\"${REL_PATH}k-series/index.html\"|g" temp_header.html
        sed -i -E "s|href=\"individual/index.html\"|href=\"${REL_PATH}individual/index.html\"|g" temp_header.html
        sed -i -E "s|href=\"new-energy-label/index.html\"|href=\"${REL_PATH}new-energy-label/index.html\"|g" temp_header.html
        sed -i -E "s|href=\"privacy-policy/index.html\"|href=\"${REL_PATH}privacy-policy/index.html\"|g" temp_header.html
        sed -i -E "s|href=\"cookies-policy/index.html\"|href=\"${REL_PATH}cookies-policy/index.html\"|g" temp_header.html
        sed -i -E "s|href=\"legal-notice/index.html\"|href=\"${REL_PATH}legal-notice/index.html\"|g" temp_header.html
        
        # Fix favicon path
        sed -i -E "s|href=\"img/favicon/favicon.ico\"|href=\"${REL_PATH}img/favicon/favicon.ico\"|g" temp_header.html
        
        # Fix background image references
        sed -i -E "s|background-image: url\(img/|background-image: url\(${REL_PATH}img/|g" temp_header.html
    fi
    
    # Combine the standardized header with the original body content
    cat temp_header.html > "$file"
    echo "$BODY" >> "$file"
    
    echo "Completed header standardization for $file"
done

# Clean up temp file
rm -f temp_header.html

echo "Header standardization complete!"
echo "Original files have been backed up in the 'backups' directory"