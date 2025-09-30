#!/bin/bash

GHOSTTY_CONFIG="$HOME/.config/ghostty/config"
NORMAL_WALLPAPER="$HOME/.local/backgrounds/swiss.jpg"

osascript -e "tell application \"System Events\" to tell appearance preferences to set dark mode to false"
osascript -e "tell application \"System Events\" to tell every desktop to set picture to POSIX file \"$NORMAL_WALLPAPER\""

if [ -f "$GHOSTTY_CONFIG" ]; then
    cp "$GHOSTTY_CONFIG" "$GHOSTTY_CONFIG.bak"

    sed -i '' 's/^background=000/# background=000/' "$GHOSTTY_CONFIG"
    sed -i '' 's/^background-opacity=0.8/background-opacity=1.0/' "$GHOSTTY_CONFIG"
    sed -i '' 's/^theme = .*/theme = catppuccin-frappe/' "$GHOSTTY_CONFIG"

    echo "Ghostty config updated:"
    echo ""
    echo "☀️Light Normal mode activated!"
    echo "Run: Cmd + Shift + , to pass activate mode on ghostty"
else
    echo "Ghostty config file not found at $GHOSTTY_CONFIG"
    echo "Normal mode partially activated (desktop and macOS only)"
fi

exit 0
