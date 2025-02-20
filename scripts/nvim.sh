#!/usr/bin/env bash

version="v0.10.2"
if [ ! -z $NVIM_VERSION ]; then
    version="$NVIM_VERSION"
fi

echo "version: \"$version\""

if [ ! -d $HOME/neovim ]; then
    git clone https://github.com/neovim/neovim.git $HOME/neovim
fi
