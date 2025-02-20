#!/usr/bin/env bash

echo "------------------- Safari ---------------------"

# Enable Command Tracking

set -x

safari_settings=(
    "IncludeInternalDebugMenu -bool true"
    "IncludeInternalDebugMenu -bool true"
)

for setting in "${safari_settings[@]}"; do
    defaults write com.apple.Safari $setting
done

killall Safari

set +x
