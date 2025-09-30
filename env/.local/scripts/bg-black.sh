#!/bin/bash

SYSTEM_SOLID_BLACK_PATH="/System/Library/Desktop Pictures/Solid Colors/Black.png"

if [ ! -f "$SYSTEM_SOLID_BLACK_PATH" ]; then
    ALT_PATH="/System/Library/Desktop Pictures/Solid Colors/Black.heic"
    if [ -f "$ALT_PATH" ]; then
        SYSTEM_SOLID_BLACK_PATH="$ALT_PATH"
    else
        echo "Error: The system's solid black background image was not found at:"
        echo "$SYSTEM_SOLID_BLACK_PATH"
        echo "$ALT_PATH"
        exit 1
    fi
fi

echo "$SYSTEM_SOLID_BLACK_PATH"
osascript -e "tell application \"System Events\" to tell every desktop to set picture to POSIX file \"$SYSTEM_SOLID_BLACK_PATH\""

if [ $? -eq 0 ]; then
    echo "Desktop background successfully set to black."
else
    echo "Error: Failed to set the desktop background using osascript."
    exit 1
fi

exit 0
