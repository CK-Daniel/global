#!/bin/bash

# Standardize headers across all pages to match the main index.html
echo "Standardizing headers across all pages..."

# Get the header from the main index.html file
# We'll extract from <!DOCTYPE html> to </header>
MAIN_HEADER=$(sed -n '/<\!DOCTYPE html>/,/<\/header>/p' index.html)

# Create a directory for backups
mkdir -p backups

# Process all HTML files except the main index.html
find . -type f -name "index.html" ! -path "./index.html" | while read -r file; do
    echo "Processing $file"
    
    # Create a backup of the file
    cp "$file" "backups/$(basename "$(dirname "$file")")_index.html"
    
    # Get the content after </header> from the current file
    BODY_CONTENT=$(sed -n '/<\/header>/,$p' "$file" | tail -n +2)
    
    # Determine the relative path prefix based on directory depth
    # Count slashes to determine depth
    DEPTH=$(echo "$file" | tr -cd '/' | wc -c)
    DEPTH=$((DEPTH - 1)) # Adjust depth (. counts as one level)
    
    # Create the relative path prefix
    REL_PREFIX=""
    for ((i=0; i<DEPTH; i++)); do
        REL_PREFIX="../$REL_PREFIX"
    done
    
    # Copy the main header to a temp file
    echo "$MAIN_HEADER" > temp_header.html
    
    # Adjust paths in the header to be relative to the current file
    if [ "$DEPTH" -gt 1 ]; then
        # Replace direct paths with relative paths
        sed -i "s|href=\"css/|href=\"$REL_PREFIX\css/|g" temp_header.html
        sed -i "s|href=\"fonts/|href=\"$REL_PREFIX\fonts/|g" temp_header.html
        sed -i "s|href=\"js/|href=\"$REL_PREFIX\js/|g" temp_header.html
        sed -i "s|href=\"wp-content/|href=\"$REL_PREFIX\wp-content/|g" temp_header.html
        sed -i "s|href=\"wp-includes/|href=\"$REL_PREFIX\wp-includes/|g" temp_header.html
        sed -i "s|href=\"style|href=\"$REL_PREFIX\style|g" temp_header.html
        sed -i "s|src=\"img/|src=\"$REL_PREFIX\img/|g" temp_header.html
        sed -i "s|src=\"js/|src=\"$REL_PREFIX\js/|g" temp_header.html
        sed -i "s|src=\"wp-includes/|src=\"$REL_PREFIX\wp-includes/|g" temp_header.html
        
        # Fix links to main pages
        sed -i "s|href=\"index.html\"|href=\"$REL_PREFIX\index.html\"|g" temp_header.html
        sed -i "s|href=\"brand/index.html\"|href=\"$REL_PREFIX\brand/index.html\"|g" temp_header.html
        sed -i "s|href=\"design/index.html\"|href=\"$REL_PREFIX\design/index.html\"|g" temp_header.html
        sed -i "s|href=\"in-the-world/index.html\"|href=\"$REL_PREFIX\in-the-world/index.html\"|g" temp_header.html
        sed -i "s|href=\"history/index.html\"|href=\"$REL_PREFIX\history/index.html\"|g" temp_header.html
        sed -i "s|href=\"downloads/index.html\"|href=\"$REL_PREFIX\downloads/index.html\"|g" temp_header.html
        sed -i "s|href=\"ovens-and-compacts/index.html\"|href=\"$REL_PREFIX\ovens-and-compacts/index.html\"|g" temp_header.html
        sed -i "s|href=\"hobs/index.html\"|href=\"$REL_PREFIX\hobs/index.html\"|g" temp_header.html
        sed -i "s|href=\"hoods/index.html\"|href=\"$REL_PREFIX\hoods/index.html\"|g" temp_header.html
        sed -i "s|href=\"refrigeration/index.html\"|href=\"$REL_PREFIX\refrigeration/index.html\"|g" temp_header.html
        sed -i "s|href=\"dishwashers/index.html\"|href=\"$REL_PREFIX\dishwashers/index.html\"|g" temp_header.html
        sed -i "s|href=\"laundry/index.html\"|href=\"$REL_PREFIX\laundry/index.html\"|g" temp_header.html
        sed -i "s|href=\"sinks-and-taps/index.html\"|href=\"$REL_PREFIX\sinks-and-taps/index.html\"|g" temp_header.html
        sed -i "s|href=\"service/index.html\"|href=\"$REL_PREFIX\service/index.html\"|g" temp_header.html
    fi
    
    # Combine the adjusted header with the body content from the original file
    cat temp_header.html > "$file"
    echo "$BODY_CONTENT" >> "$file"
    
    echo "Standardized header for $file"
done

# Clean up the temp file
rm -f temp_header.html

echo "Header standardization complete!"
echo "Original files have been backed up in the 'backups' directory"