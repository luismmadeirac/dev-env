#!/usr/bin/env bash

# Install sketchybar
brew tap FelixKratz/formulae
brew install sketchybar

mkdir -p ~/.config/sketchybar/plugins
cp $(brew --prefix)/share/sketchybar/examples/sketchybarrc ~/.config/sketchybar/sketchybarrc
cp -r $(brew --prefix)/share/sketchybar/examples/plugins/ ~/.config/sketchybar/plugins/

# Enables Automatically hide of macos menu bar
defaults write NSGlobalDomain _HIHideMenuBar -bool true

killall SystemUIServer

brew services start sketchybar
