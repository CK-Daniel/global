#!/bin/bash

# Function to replace URLs in JavaScript files
replace_js_urls() {
  find . -name "*.js" | xargs sed -i -E \
    -e 's|https://consent.cookiebot.com/|/local/js/cookiebot/|g' \
    -e 's|https://www.googletagmanager.com/|/local/js/google/|g' \
    -e 's|https://script.crazyegg.com/|/local/js/crazyegg/|g' \
    -e 's|https://cscoreproweustor.blob.core.windows.net/|/local/js/cswidget/|g' \
    -e 's|https://www.youtube.com/|/local/videos/youtube/|g' \
    -e 's|https://www.linkedin.com/|/local/social/linkedin/|g' \
    -e 's|https://www.instagram.com/|/local/social/instagram/|g' \
    -e 's|https://www.home-kueppersbusch.com/|/|g'
}

# Create necessary directories
mkdir -p local/js/cookiebot
mkdir -p local/js/google
mkdir -p local/js/crazyegg
mkdir -p local/js/cswidget
mkdir -p local/videos/youtube
mkdir -p local/social/linkedin
mkdir -p local/social/instagram

echo "Running search and replace for JavaScript URLs..."
replace_js_urls

echo "JavaScript localization complete!"