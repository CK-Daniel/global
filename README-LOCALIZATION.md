# Küppersbusch Website Localization

This document explains how the website has been localized to work without external dependencies.

## Localization Process

The website has been localized using several scripts:

1. `localize.sh` - Replaces common external resource URLs in HTML, CSS, and JS files
2. `localize-fonts.sh` - Replaces font URLs with local versions
3. `localize-js.sh` - Replaces URLs in JavaScript files
4. `localize-final.sh` - Catches any remaining external URLs and creates local placeholders

## Local Resource Structure

All localized resources are stored in the following directory structure:

```
/local
├── css/                  # Local CSS files
├── external/             # Domain-based external resources
│   ├── api.channelsight.com/
│   ├── daneden.me/
│   ├── facebook.com/
│   ├── github.com/
│   ├── teka.b-cdn.net/   # Product images are stored locally but kept in original URLs
│   └── ...
├── fonts/                # Local font files
│   ├── bunny/
│   └── google/
├── images/               # Local image files
├── js/                   # Local JavaScript files
│   ├── cookiebot/
│   ├── crazyegg/
│   ├── cswidget/
│   └── google/
├── social/               # Local social media resources
└── videos/               # Local video resources
```

## External Resources Replaced

The following types of external resources have been replaced with local versions:

### JavaScript
- Cookiebot (consent.cookiebot.com)
- Google Tag Manager (googletagmanager.com)
- CrazyEgg (script.crazyegg.com)
- CSWidget Loader (cscoreproweustor.blob.core.windows.net)
- Various jQuery plugins and libraries

### Fonts
- Bunny Fonts (fonts.bunny.net)
- Google Fonts (fonts.googleapis.com)
- Font Awesome (fontawesome.com)

### Social Media
- YouTube links
- LinkedIn links
- Instagram links
- Facebook links
- Pinterest links

### Product Images
- All product images from teka.b-cdn.net are now referenced locally
- Image paths maintain original structure for compatibility

## Notes

- Product images have been localized as requested
- All external resources now point to local placeholder files
- Social media links have been replaced with anchor links
- External font links have been replaced with local CSS files
- W3C specification URLs (http://www.w3.org/) have been preserved

## Usage

To properly use the localized website:

1. Download all the external resources using a crawler or manually
2. Place them in the corresponding directory structure
3. Test thoroughly in a local environment to ensure all assets load correctly

## Maintenance

If new external resources are added to the website:

1. Run the localization scripts again
2. Check for any new external URLs
3. Update the local resource structure as needed