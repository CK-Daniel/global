# Directory Structure Overview

This document outlines the unified directory structure after removing wp-content references.

## Main Asset Directories

- **/assets/** - Main assets directory containing uploads and other assets
  - **/assets/css/** - CSS files
  - **/assets/js/** - JavaScript files
  - **/assets/fonts/** - Font files
  - **/assets/images/** - Image files
  - **/assets/uploads/** - User uploads, organized by date

- **/css/** - CSS files
  - **/css/divi/** - Divi theme CSS files

- **/js/** - JavaScript files
  - **/js/divi/** - Divi theme JS files
  - **/js/select2/** - Select2 library
  - **/js/slick/** - Slick slider
  - **/js/jssocials/** - JS Socials library
  - **/js/tooltipster/** - Tooltipster library
  - **/js/featherlight/** - Featherlight lightbox

- **/fonts/** - Font files
  - **/fonts/divi/** - Divi theme fonts

- **/img/** - Image files
  - **/img/divi/** - Divi theme images
  - **/img/favicon/** - Favicon images

- **/plugins/** - WordPress plugin files

## Backward Compatibility

For backward compatibility with any remaining wp-content references, symbolic links have been created:

- **/wp-content/themes/kueppersbusch/img/** → **/img/**
- **/wp-content/themes/Divi/images/** → **/img/divi/**
- **/wp-content/themes/Divi/includes/builder/images/** → **/img/divi/builder/**

This ensures that any missed references continue to work while the codebase transitions to the new structure.

## Benefits of the New Structure

1. **Simplified Paths** - All asset paths are shorter and more intuitive
2. **Improved Organization** - Assets are organized by type rather than by WordPress structure
3. **Non-WordPress Compatibility** - Site structure no longer requires WordPress knowledge to navigate
4. **Future-Proofing** - Structure is independent of the CMS and more portable
