#!/usr/bin/env bash

echo "------------------- ScreenShots  ---------------------"

# Enabale Command Tracking
set -x

screenshoot_settings=(
    "location -string \"$HOME/Documents/ScreenShots/\""
    "type -string png"
    "disable-shadow -bool true"
)

# Apply
for setting in "${screenshoot_settings@]}"; do
    defaults write com.apple.screencapture $setting
done

# Restart SystemUIServer to apply changes
killall SystemUIServer

set +x
