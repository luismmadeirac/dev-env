#!/bin/bash

GHOSTTY_CONFIG="$HOME/.config/ghostty/config"
SYSTEM_SOLID_BLACK_PATH="/System/Library/Desktop Pictures/Solid Colors/Black.png"

if [ ! -f "$SYSTEM_SOLID_BLACK_PATH" ]; then
    ALT_PATH="/System/Library/Desktop Pictures/Solid Colors/Black.png"
    if [ -f "$ALT_PATH" ]; then
        SYSTEM_SOLID_BLACK_PATH="$ALT_PATH"
    else
        echo "Image not found in System"
        echo " - $SYSTEM_SOLID_BLACK_PATH"
        exit 1
    fi
fi

echo "$SYSTEM_SOLID_BLACK_PATH"

osascript -e "tell application \"System Events\" to tell every desktop to set picture to POSIX file \"$SYSTEM_SOLID_BLACK_PATH\""
osascript -e "tell application \"System Events\" to tell appearance preferences to set dark mode to true"

if [ $? -eq 0 ]; then
    echo "Desk BG black and dark-mode true"

    # Mod Ghostty config
    if [ -f "$GHOSTTY_CONFIG" ]; then
        cp "$GHOSTTY_CONFIG" "$GHOSTTY_CONFIG.bak"

        sed -i '' 's/^# background=000/background=000/' "$GHOSTTY_CONFIG"

        sed -i '' 's/^background-opacity=1.0/background-opacity=0.8/' "$GHOSTTY_CONFIG"

        echo "🦇 Batman mode activated!"
        echo "Run: Cmd + Shift + , to pass activate mode on ghostty"
    else
        echo "Ghostty config file not found at $GHOSTTY_CONFIG"
        echo "Batman mode partially activated (desktop and macOS only)"
    fi
else
    echo "Failed to set desktop background to black"
    exit 1
fi

exit 0
