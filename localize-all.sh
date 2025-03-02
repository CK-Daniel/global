#!/bin/bash

# Run all localization scripts in the correct order

echo "Starting website localization process..."

# Fix line endings if needed
sed -i 's/\r$//' localize.sh
sed -i 's/\r$//' localize-fonts.sh
sed -i 's/\r$//' localize-js.sh
sed -i 's/\r$//' localize-final.sh

# Make scripts executable
chmod +x localize.sh
chmod +x localize-fonts.sh
chmod +x localize-js.sh
chmod +x localize-final.sh

# Run localization scripts
echo "Step 1: Basic localization..."
./localize.sh

echo "Step 2: Font localization..."
./localize-fonts.sh

echo "Step 3: JavaScript localization..."
./localize-js.sh

echo "Step 4: Final cleanup..."
./localize-final.sh

echo "All done! Website is now fully localized."
echo "See README-LOCALIZATION.md for details on the localization process."