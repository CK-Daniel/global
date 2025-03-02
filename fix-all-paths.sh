#!/bin/bash

# This script standardizes headers and fixes ALL relative paths across pages

echo "Standardizing headers and fixing ALL relative paths..."

# Create a directory for backups
mkdir -p backups

# Extract the main header from index.html to use as a template
HEADER=$(sed -n '/<\!DOCTYPE html>/,/<\/header>/p' index.html)

# Process all index.html files
find . -name "index.html" ! -path "./index.html" | while read file; do
    echo "Processing $file"
    
    # Create backup if not already backed up
    parent_dir=$(dirname "$file")
    backup_name=$(echo "$parent_dir" | sed 's|^\./||; s|/|_|g')
    if [ ! -f "backups/${backup_name}_index.html" ]; then
        cp "$file" "backups/${backup_name}_index.html"
    fi
    
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
        # Fix all paths in header
        
        # 1. Fix href attributes in link tags
        sed -i -E "s|href=\"css/|href=\"${REL_PATH}css/|g" temp_header.html
        sed -i -E "s|href=\"fonts/|href=\"${REL_PATH}fonts/|g" temp_header.html
        sed -i -E "s|href=\"js/|href=\"${REL_PATH}js/|g" temp_header.html
        sed -i -E "s|href=\"wp-content/|href=\"${REL_PATH}wp-content/|g" temp_header.html
        sed -i -E "s|href=\"wp-includes/|href=\"${REL_PATH}wp-includes/|g" temp_header.html
        sed -i -E "s|href=\"style|href=\"${REL_PATH}style|g" temp_header.html
        sed -i -E "s|href=\"feed/|href=\"${REL_PATH}feed/|g" temp_header.html
        sed -i -E "s|href=\"comments/|href=\"${REL_PATH}comments/|g" temp_header.html
        
        # 2. Fix src attributes in script and img tags
        sed -i -E "s|src=\"img/|src=\"${REL_PATH}img/|g" temp_header.html
        sed -i -E "s|src=\"wp-includes/|src=\"${REL_PATH}wp-includes/|g" temp_header.html
        sed -i -E "s|src=\"wp-content/|src=\"${REL_PATH}wp-content/|g" temp_header.html
        sed -i -E "s|src=\"js/|src=\"${REL_PATH}js/|g" temp_header.html
        
        # 3. Fix background image urls in style attributes
        sed -i -E "s|background-image: url\(img/|background-image: url\(${REL_PATH}img/|g" temp_header.html
        
        # 4. Fix favicon and other icon links
        sed -i -E "s|href=\"img/favicon/|href=\"${REL_PATH}img/favicon/|g" temp_header.html
        
        # 5. Fix navigation menu links
        sed -i -E "s|href=\"index.html\"|href=\"${REL_PATH}index.html\"|g" temp_header.html
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
        
        # 6. Fix special cases for links with query parameters
        sed -i -E "s|href=\"wp-includes/js/jquery/jquery.min%EF%B9%96ver=3.7.1.js\"|href=\"${REL_PATH}wp-includes/js/jquery/jquery.min%EF%B9%96ver=3.7.1.js\"|g" temp_header.html
        sed -i -E "s|href=\"wp-includes/js/jquery/jquery-migrate.min%EF%B9%96ver=3.4.1.js\"|href=\"${REL_PATH}wp-includes/js/jquery/jquery-migrate.min%EF%B9%96ver=3.4.1.js\"|g" temp_header.html
        sed -i -E "s|src=\"wp-includes/js/jquery/jquery.min%EF%B9%96ver=3.7.1.js\"|src=\"${REL_PATH}wp-includes/js/jquery/jquery.min%EF%B9%96ver=3.7.1.js\"|g" temp_header.html
        sed -i -E "s|src=\"wp-includes/js/jquery/jquery-migrate.min%EF%B9%96ver=3.4.1.js\"|src=\"${REL_PATH}wp-includes/js/jquery/jquery-migrate.min%EF%B9%96ver=3.4.1.js\"|g" temp_header.html
    fi
    
    # Combine the standardized header with the original body content
    cat temp_header.html > "$file"
    echo "$BODY" >> "$file"
    
    # Now fix all paths in the body section too
    if [ "$DEPTH" -gt 0 ]; then
        # Create a temp file with the body content
        echo "$BODY" > temp_body.html
        
        # Fix all paths in the body content
        sed -i -E "s|href=\"css/|href=\"${REL_PATH}css/|g" temp_body.html
        sed -i -E "s|href=\"fonts/|href=\"${REL_PATH}fonts/|g" temp_body.html
        sed -i -E "s|href=\"js/|href=\"${REL_PATH}js/|g" temp_body.html
        sed -i -E "s|href=\"wp-content/|href=\"${REL_PATH}wp-content/|g" temp_body.html
        sed -i -E "s|href=\"wp-includes/|href=\"${REL_PATH}wp-includes/|g" temp_body.html
        sed -i -E "s|href=\"style|href=\"${REL_PATH}style|g" temp_body.html
        
        # Fix script sources
        sed -i -E "s|src=\"js/|src=\"${REL_PATH}js/|g" temp_body.html
        sed -i -E "s|src=\"wp-includes/|src=\"${REL_PATH}wp-includes/|g" temp_body.html
        sed -i -E "s|src=\"wp-content/|src=\"${REL_PATH}wp-content/|g" temp_body.html
        
        # Fix image sources (but don't touch product images from external domains)
        sed -i -E "s|src=\"img/|src=\"${REL_PATH}img/|g" temp_body.html
        
        # Update the file with the fixed body content
        cat temp_header.html > "$file"
        cat temp_body.html >> "$file"
    fi
    
    echo "Completed standardization for $file"
done

# Clean up temp files
rm -f temp_header.html temp_body.html

echo "Header and path standardization complete!"
echo "Original files have been backed up in the 'backups' directory"