#!/bin/bash

# Define the path to the system's pre-defined solid black background image.
# macOS typically uses a PNG or HEIC file located here for solid colors.
SYSTEM_SOLID_BLACK_PATH="/System/Library/Desktop Pictures/Solid Colors/Black.png"

# Double-check if the file exists at the primary path.
# If not, check for a .heic version as a fallback (less common for solids, but possible).
if [ ! -f "$SYSTEM_SOLID_BLACK_PATH" ]; then
  ALT_PATH="/System/Library/Desktop Pictures/Solid Colors/Black.heic"
  if [ -f "$ALT_PATH" ]; then
    SYSTEM_SOLID_BLACK_PATH="$ALT_PATH"
  else
    echo "Error: The system's solid black background image was not found at:"
    echo "  - $SYSTEM_SOLID_BLACK_PATH"
    echo "  - $ALT_PATH"
    echo "Your macOS version might store these differently. Cannot proceed."
    exit 1
  fi
fi

# Use osascript to tell System Events to set the picture for every desktop
# to the system's solid black image file.
echo "Setting desktop background to black using the system's solid color file:"
echo "$SYSTEM_SOLID_BLACK_PATH"

osascript -e "tell application \"System Events\" to tell every desktop to set picture to POSIX file \"$SYSTEM_SOLID_BLACK_PATH\""

# Check if the osascript command was successful
if [ $? -eq 0 ]; then
  echo "Desktop background successfully set to black."
else
  echo "Error: Failed to set the desktop background using osascript."
  exit 1
fi

exit 0