#!/usr/bin/env bash

brew update

# jq      - https://jqlang.org/
# fzf     - https://github.com/junegunn/fzf
# ripgrep - https://github.com/BurntSushi/ripgrep

brew install ripgrep jq fzf

# Install fzf extras
$(brew --prefix)/opt/fzf/install
