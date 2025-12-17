#!/usr/bin/env bash

echo "------------------- Activity Monitor  ---------------------"

set -x

activity_monitor_settings=(
    "QuitMenuItem -bool true"
)

for setting in "${activity_monitor_settings[@]}"; do
    defaults write com.apple.ActivityMonitor $setting
done

killall Finder

set +x
