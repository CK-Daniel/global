#!/bin/bash

# Create local directories if they don't exist
mkdir -p local/js
mkdir -p local/css
mkdir -p local/fonts
mkdir -p local/images

# Function to replace external URLs in HTML files
replace_external_links() {
  find . -name "*.html" -o -name "*.css" -o -name "*.js" | xargs sed -i -E \
    -e 's|https://consent.cookiebot.com/uc.js|/local/js/cookiebot.js|g' \
    -e 's|https://www.googletagmanager.com/gtm.js|/local/js/gtm.js|g' \
    -e 's|https://script.crazyegg.com/pages/scripts/0113/4991.js|/local/js/crazyegg.js|g' \
    -e 's|https://cscoreproweustor.blob.core.windows.net/widget/scripts/cswidget.loader.js|/local/js/cswidget.loader.js|g' \
    -e 's|https://fonts.bunny.net|/local/fonts/bunny|g' \
    -e 's|http://www.kuppersbusch.com.cn|#|g' \
    -e 's|https://www.home-kueppersbusch.com/wp-content/themes/kueppersbusch/img/kuppersbusch-white.svg|/img/kuppersbusch-white.svg|g' \
    -e 's|https://www.home-kueppersbusch.com/es-es/wp-content/uploads/sites/2/2022/07/KPH-youtube-.png|/local/images/youtube.png|g' \
    -e 's|https://www.home-kueppersbusch.com/es-es/wp-content/uploads/sites/2/2022/07/KPH-linkedin-.png|/local/images/linkedin.png|g' \
    -e 's|https://www.home-kueppersbusch.com/es-es/wp-content/uploads/sites/2/2022/07/KPH-IG-.png|/local/images/instagram.png|g' \
    -e 's|https://www.youtube.com/channel/UCaRoMAFkv5XWgWDPwObus4g|#youtube|g' \
    -e 's|https://www.linkedin.com/company/k%C3%BCppersbusch-hausger%C3%A4te-gmbh/|#linkedin|g' \
    -e 's|https://www.instagram.com/kueppersbusch.international/|#instagram|g'
}

# Create placeholder files for external resources
echo "// Local version of Cookiebot JS" > local/js/cookiebot.js
echo "// Local version of Google Tag Manager JS" > local/js/gtm.js
echo "// Local version of CrazyEgg JS" > local/js/crazyegg.js
echo "// Local version of CSWidget Loader JS" > local/js/cswidget.loader.js

# Create placeholder images for social media
touch local/images/youtube.png
touch local/images/linkedin.png
touch local/images/instagram.png

# Create placeholder for fonts.bunny.net
mkdir -p local/fonts/bunny
touch local/fonts/bunny/fonts-bunny.css

echo "Running search and replace to localize external resources..."
replace_external_links

echo "Creating local CSS file for fonts"
echo "/* Local version of fonts.bunny.net CSS */" > local/fonts/bunny/fonts-bunny.css

echo "Localization complete!"