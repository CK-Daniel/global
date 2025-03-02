#!/bin/bash

# Final cleanup to localize any remaining external URLs (excluding W3C SVG namespace)
find . -name "*.html" -o -name "*.css" -o -name "*.js" | xargs grep -l "http[s]\?://" | 
while read file; do
  # Skip files that only contain W3C namespaces
  if grep -q "http[s]\?://[^w]" "$file" || grep -q "http[s]\?://www\.[^w]" "$file"; then
    echo "Processing $file"
    # Extract URLs from the file
    grep -o "http[s]\?://[^\"']*" "$file" | 
    while read url; do
      # Skip W3C namespace URLs
      if [[ "$url" != "http://www.w3.org/"* ]]; then
        echo "  Found URL: $url"
        # Create a path based on the URL
        domain=$(echo "$url" | sed -E 's|http[s]?://||' | cut -d'/' -f1)
        path=$(echo "$url" | sed -E 's|http[s]?://[^/]+||')
        if [[ -z "$path" ]]; then
          path="index.html"
        fi
        
        # Create local directory structure
        localdir="local/external/$domain"
        mkdir -p "$localdir"
        
        # Replace URL in the file
        replacement="/local/external/$domain$path"
        # Escape special characters in the URL for sed
        url_escaped=$(echo "$url" | sed 's/[\/&]/\\&/g')
        replacement_escaped=$(echo "$replacement" | sed 's/[\/&]/\\&/g')
        
        sed -i "s|$url_escaped|$replacement_escaped|g" "$file"
        echo "  Replaced with: $replacement"
      fi
    done
  fi
done

echo "Final localization complete!"