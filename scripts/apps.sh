#!/usr/bin/env bash

# Check if it is install if not install it
xcode-select --install

# Check for updates

# This script goes through the list of apps (brew casks) and checks if they are install if not it installs them
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run with sudo."
    exit 1
fi

BREW_PACKAGES=(
    wget
    htop
)

BREW_PACKAGES=(
    wget
    htop
)

BREW_APPS=(
    raycast
    obsidian
    google-chrome
    ghostty
    figma
    docker
    postman
    sf-symbols
    ray
    nikitabobko/tap/aerospace
)

# Update and upgrade Homebrew
brew update
brew upgrade

for package in "${BREW_PACKAGES[@]}"; do
    if ! brew list --formula | grep -q "^$package\$"; then
        brew install "$package"
    else
        echo "$package is already installed."
    fi
done

for app in "${CASK_APPS[@]}"; do
    if ! brew list --cask | grep -q "^$app\$"; then
        brew install --cask "$app"
    else
        echo "$app is already installed."
    fi
done

# Cleanup outdated versions
brew cleanup
