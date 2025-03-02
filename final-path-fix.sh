#!/bin/bash

# This script thoroughly fixes all relative paths in all HTML files across the site

echo "Starting comprehensive path standardization..."

# Create a directory for backups if it doesn't exist
mkdir -p backups

# Define a function to process HTML files
process_html_file() {
    local file=$1
    echo "Processing $file"
    
    # Create backup if not already backed up
    local parent_dir=$(dirname "$file")
    local backup_name=$(echo "$parent_dir" | sed 's|^\./||; s|/|_|g')
    if [ ! -f "backups/${backup_name}_index.html" ]; then
        cp "$file" "backups/${backup_name}_index.html"
    fi
    
    # Calculate the relative path depth
    local depth=$(echo "$file" | tr -cd '/' | wc -c)
    depth=$((depth - 1))  # Adjust for leading ./
    
    # Skip processing for root index.html
    if [ "$depth" -eq 0 ]; then
        echo "Skipping root file $file"
        return
    fi
    
    # Create relative path prefix
    local rel_path=""
    for ((i=0; i<depth; i++)); do
        rel_path="../$rel_path"
    done
    
    echo "Applying relative prefix: $rel_path for depth $depth"
    
    # Create a temporary file
    cp "$file" temp.html
    
    # Fix all types of resource paths in a single pass
    
    # 1. Fix standard URL paths
    
    # CSS files
    sed -i -E "s|href=['\"]css/|href=\"${rel_path}css/|g" temp.html
    sed -i -E "s|href=['\"]style-admin.css|href=\"${rel_path}style-admin.css|g" temp.html
    sed -i -E "s|href=['\"]style.css|href=\"${rel_path}style.css|g" temp.html
    
    # Font files
    sed -i -E "s|href=['\"]fonts/|href=\"${rel_path}fonts/|g" temp.html
    
    # JS files and directories
    sed -i -E "s|href=['\"]js/|href=\"${rel_path}js/|g" temp.html
    sed -i -E "s|src=['\"]js/|src=\"${rel_path}js/|g" temp.html
    
    # WordPress content
    sed -i -E "s|href=['\"]wp-content/|href=\"${rel_path}wp-content/|g" temp.html
    sed -i -E "s|href=['\"]wp-includes/|href=\"${rel_path}wp-includes/|g" temp.html
    sed -i -E "s|src=['\"]wp-content/|src=\"${rel_path}wp-content/|g" temp.html
    sed -i -E "s|src=['\"]wp-includes/|src=\"${rel_path}wp-includes/|g" temp.html
    
    # Images
    sed -i -E "s|src=['\"]img/|src=\"${rel_path}img/|g" temp.html
    
    # 2. Fix navigation links for site structure
    
    # Main navigation
    sed -i -E "s|href=['\"]index.html|href=\"${rel_path}index.html|g" temp.html
    sed -i -E "s|href=['\"]ovens-and-compacts/index.html|href=\"${rel_path}ovens-and-compacts/index.html|g" temp.html
    sed -i -E "s|href=['\"]hobs/index.html|href=\"${rel_path}hobs/index.html|g" temp.html
    sed -i -E "s|href=['\"]hoods/index.html|href=\"${rel_path}hoods/index.html|g" temp.html
    sed -i -E "s|href=['\"]refrigeration/index.html|href=\"${rel_path}refrigeration/index.html|g" temp.html
    sed -i -E "s|href=['\"]dishwashers/index.html|href=\"${rel_path}dishwashers/index.html|g" temp.html
    sed -i -E "s|href=['\"]laundry/index.html|href=\"${rel_path}laundry/index.html|g" temp.html
    sed -i -E "s|href=['\"]sinks-and-taps/index.html|href=\"${rel_path}sinks-and-taps/index.html|g" temp.html
    sed -i -E "s|href=['\"]brand/index.html|href=\"${rel_path}brand/index.html|g" temp.html
    sed -i -E "s|href=['\"]design/index.html|href=\"${rel_path}design/index.html|g" temp.html
    sed -i -E "s|href=['\"]in-the-world/index.html|href=\"${rel_path}in-the-world/index.html|g" temp.html
    sed -i -E "s|href=['\"]history/index.html|href=\"${rel_path}history/index.html|g" temp.html
    sed -i -E "s|href=['\"]downloads/index.html|href=\"${rel_path}downloads/index.html|g" temp.html
    sed -i -E "s|href=['\"]service/index.html|href=\"${rel_path}service/index.html|g" temp.html
    sed -i -E "s|href=['\"]k-series/index.html|href=\"${rel_path}k-series/index.html|g" temp.html
    sed -i -E "s|href=['\"]individual/index.html|href=\"${rel_path}individual/index.html|g" temp.html
    sed -i -E "s|href=['\"]new-energy-label/index.html|href=\"${rel_path}new-energy-label/index.html|g" temp.html
    sed -i -E "s|href=['\"]privacy-policy/index.html|href=\"${rel_path}privacy-policy/index.html|g" temp.html
    sed -i -E "s|href=['\"]cookies-policy/index.html|href=\"${rel_path}cookies-policy/index.html|g" temp.html
    sed -i -E "s|href=['\"]legal-notice/index.html|href=\"${rel_path}legal-notice/index.html|g" temp.html
    
    # 3. Fix feed and comment links
    sed -i -E "s|href=['\"]feed/|href=\"${rel_path}feed/|g" temp.html
    sed -i -E "s|href=['\"]comments/|href=\"${rel_path}comments/|g" temp.html
    
    # 4. Fix specific problematic URLs
    
    # Fix URLs with query parameters
    sed -i -E "s|href=['\"]wp-includes/js/jquery/jquery.min%EF%B9%96ver=3.7.1.js|href=\"${rel_path}wp-includes/js/jquery/jquery.min%EF%B9%96ver=3.7.1.js|g" temp.html
    sed -i -E "s|href=['\"]wp-includes/js/jquery/jquery-migrate.min%EF%B9%96ver=3.4.1.js|href=\"${rel_path}wp-includes/js/jquery/jquery-migrate.min%EF%B9%96ver=3.4.1.js|g" temp.html
    sed -i -E "s|src=['\"]wp-includes/js/jquery/jquery.min%EF%B9%96ver=3.7.1.js|src=\"${rel_path}wp-includes/js/jquery/jquery.min%EF%B9%96ver=3.7.1.js|g" temp.html
    sed -i -E "s|src=['\"]wp-includes/js/jquery/jquery-migrate.min%EF%B9%96ver=3.4.1.js|src=\"${rel_path}wp-includes/js/jquery/jquery-migrate.min%EF%B9%96ver=3.4.1.js|g" temp.html
    
    # Fix any favicon links
    sed -i -E "s|href=['\"]img/favicon/favicon.ico|href=\"${rel_path}img/favicon/favicon.ico|g" temp.html
    
    # 5. Fix background image URLs in style attributes
    sed -i -E "s|background-image: url\(img/|background-image: url\(${rel_path}img/|g" temp.html
    sed -i -E "s|background-image: url\(/img/|background-image: url\(${rel_path}img/|g" temp.html
    sed -i -E "s|background-image: url\(/wp-content/|background-image: url\(${rel_path}wp-content/|g" temp.html
    
    # 6. Fix absolute paths by converting them to relative
    sed -i -E "s|src=['\"]\/img\/|src=\"${rel_path}img/|g" temp.html
    sed -i -E "s|href=['\"]\/img\/|href=\"${rel_path}img/|g" temp.html
    sed -i -E "s|src=['\"]\/css\/|src=\"${rel_path}css/|g" temp.html
    sed -i -E "s|href=['\"]\/css\/|href=\"${rel_path}css/|g" temp.html
    sed -i -E "s|src=['\"]\/js\/|src=\"${rel_path}js/|g" temp.html
    sed -i -E "s|href=['\"]\/js\/|href=\"${rel_path}js/|g" temp.html
    sed -i -E "s|src=['\"]\/fonts\/|src=\"${rel_path}fonts/|g" temp.html
    sed -i -E "s|href=['\"]\/fonts\/|href=\"${rel_path}fonts/|g" temp.html
    sed -i -E "s|src=['\"]\/wp-content\/|src=\"${rel_path}wp-content/|g" temp.html
    sed -i -E "s|href=['\"]\/wp-content\/|href=\"${rel_path}wp-content/|g" temp.html
    sed -i -E "s|src=['\"]\/wp-includes\/|src=\"${rel_path}wp-includes/|g" temp.html
    sed -i -E "s|href=['\"]\/wp-includes\/|href=\"${rel_path}wp-includes/|g" temp.html
    
    # 7. Fix WordPress multisite paths
    
    # Fix paths that go up multiple levels unnecessarily
    sed -i -E "s|src=['\"]\.\.\/\.\.\/\.\.\/wp-content\/|src=\"${rel_path}wp-content/|g" temp.html
    sed -i -E "s|href=['\"]\.\.\/\.\.\/\.\.\/wp-content\/|href=\"${rel_path}wp-content/|g" temp.html
    sed -i -E "s|src=['\"]\.\.\/\.\.\/wp-content\/|src=\"${rel_path}wp-content/|g" temp.html
    sed -i -E "s|href=['\"]\.\.\/\.\.\/wp-content\/|href=\"${rel_path}wp-content/|g" temp.html
    
    # 8. Fix logo in footer
    sed -i -E "s|src=['\"]\.\.\/\.\.\/\.\.\/wp-content\/themes\/kueppersbusch\/img\/kuppersbusch-white.svg|src=\"${rel_path}img/kuppersbusch-white.svg|g" temp.html
    sed -i -E "s|src=['\"]\.\.\/\.\.\/wp-content\/themes\/kueppersbusch\/img\/kuppersbusch-white.svg|src=\"${rel_path}img/kuppersbusch-white.svg|g" temp.html
    sed -i -E "s|src=['\"]\/wp-content\/themes\/kueppersbusch\/img\/kuppersbusch-white.svg|src=\"${rel_path}img/kuppersbusch-white.svg|g" temp.html
    
    # 9. Clean up duplicate or unnecessary path prefixes
    # (can add more if needed)
    
    # Move the processed file back
    mv temp.html "$file"
    echo "Completed path standardization for $file"
}

# Find all HTML files and process them
find . -name "*.html" | while read file; do
    process_html_file "$file"
done

echo "Comprehensive path standardization complete!"
echo "Original files have been backed up in the 'backups' directory"