#!/usr/bin/env bash

BREW_PACKAGES=(
    htop
    zoxide
    tree
    mkcert
    terraform
    fzf
    go-task
    lazygit
    lazydocker
    protobuf
    kind
    git
    gh
    nvm
    node
    asdf
)

BREW_APPS=(
    raycast
    obsidian
    google-chrome
    ghostty
    figma
    docker
    sf-symbols
    slack
    discord
    aerospace
    postman
    whatsapp
)

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

brew cleanup
