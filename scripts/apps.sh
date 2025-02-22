#!/usr/bin/env bash

# Check if Xcode Command Line Tools are installed
if ! xcode-select -p &>/dev/null; then
    echo "Installing Xcode Command Line Tools..."
    xcode-select --install
    # Wait for installation to complete
    until xcode-select -p &>/dev/null; do
        sleep 5
    done
    echo "Xcode Command Line Tools installation completed."
else
    echo "Xcode Command Line Tools already installed."
fi

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

for app in "${BREW_APPS[@]}"; do
    if ! brew list --cask | grep -q "^${app##*/}\$"; then
        brew install --cask "$app"
    else
        echo "$app is already installed."
    fi
done

# Cleanup outdated versions
brew cleanup
