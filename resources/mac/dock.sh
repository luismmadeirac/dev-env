#!/usr/bin/env bash

echo "------------------- Dock  ---------------------"

# Enabale command tracking

set -x

dock_settings=(
    # Set Dock to auto-hide
    "autohide -bool true"
    # Dock Auto hide delay
    "autohide-delay -float 0"
    # Change Dock icons size
    "tilesize -int 25"
    # Change Dock Location to the right
    "orientation -string right"
    # Disable show recent apps in dock
    "show-recents -bool false"
    # Disable magnification
    "magnification -bool false"
)

for setting in "${dock_settings[@]}"; do
    defaults write com.apple.dock $setting
done

killall Dock

set +x
