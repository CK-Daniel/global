# Reorganization Plan to Remove wp-content References

## Strategy Overview

1. Move files from wp-content to appropriate existing directories
2. Update references in HTML/CSS/JS files
3. Maintain relative proximity of related files
4. Avoid duplicating files that already exist in non-wp-content locations

## File Movement Plan

### Theme Files (wp-content/themes/)

- **Divi Theme**:
  - Move JS files → `/js/divi/`
  - Move CSS files → `/css/divi/` (already partially exists)
  - Move fonts → `/fonts/divi/`
  - Move images → `/img/divi/`

- **Kueppersbusch Theme**:
  - Move JS files → `/js/` (already contains many of these files)
  - Move CSS files → `/css/`
  - Move fonts → `/fonts/` (already contains many of these files)
  - Move images → `/img/`

### Plugin Files (wp-content/plugins/)

- Create `/plugins/` directory at root level
- Move all plugin files there maintaining internal structure
- Example: `wp-content/plugins/wp-pagenavi/` → `/plugins/wp-pagenavi/`

### Uploads (wp-content/uploads/)

- Move to `/assets/uploads/` (already exists)
- Maintain date-based folder structure

## Reference Update Strategy

1. Create a search and replace map for all wp-content paths
2. Update all HTML files to reference new locations
3. Update all CSS files to reference new locations
4. Update all JS files to reference new locations

## Potential Challenges

1. Some files may already exist in both locations (wp-content and non-wp-content)
2. Relative paths may need adjustment based on file location
3. WordPress-specific functionality might expect the wp-content structure

## Implementation Approach

1. First copy files to new locations (preserving originals)
2. Update references
3. Test site functionality
4. Once validated, remove wp-content directory