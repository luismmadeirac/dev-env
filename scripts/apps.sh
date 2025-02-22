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
    # https://htop.dev/
    htop
    # https://github.com/ajeetdsouza/zoxide
    zoxide
    # https://github.com/laurikari/tre
    tree
)

BREW_APPS=(
    # https://github.com/keycastr/keycastr
    keycastr
    # https://raycast.com/
    raycast
    # https://obsidian.md/
    obsidian
    # https://www.google.com/chrome/
    google-chrome
    # https://ghostty.org/
    ghostty
    # https://www.figma.com/
    figma
    # https://www.docker.com/
    docker
    # https://www.postman.com/
    postman
    # https://developer.apple.com/design/human-interface-guidelines/sf-symbols/overview/
    sf-symbols
    # https://tableplus.com/
    tableplus
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
