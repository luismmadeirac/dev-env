#!/usr/bin/env bash

brew update
brew install ripgrep jq fzf

# Install fzf extras
$(brew --prefix)/opt/fzf/install
