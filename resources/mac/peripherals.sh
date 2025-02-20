#!/usr/bin/env bash

echo "------------------- TrackPad, Mouse, Keyboard  ---------------------"

# Enable Command Tracking

set -x

# Setting trackpad & mouse to faster speeed
defaults write -g com.apple.trackpad.scaling 9
defaults write -g com.apple.mouse.scaling 2.5

# Increase sound quality for Bluetooth headphones/headsets
defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int 40

# Enable full keyboard access for all controls
# (e.g. enable Tab in modal dialogs)
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# Fast Keyboard
defaults write NSGlobalDomain KeyRepeat -int 1
defaults write NSGlobalDomain InitialKeyRepeat -int 10

set +x
