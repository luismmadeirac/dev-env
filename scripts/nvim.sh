#!/usr/bin/env bash

version="v0.10.2"

if [ ! -z $NVIM_VERSION ]; then
    version="$NVIM_VERSION"
fi

echo "version: \"$version\""

# Install dependencies
brew install cmake gettext lua@5.1

# Clone and build neovim
if [ ! -d $HOME/neovim ]; then
    git clone https://github.com/neovim/neovim.git $HOME/neovim
fi

git -C ~/neovim fetch --all
git -C ~/neovim checkout $version
make -C ~/neovim clean
make -C ~/neovim CMAKE_BUILD_TYPE=RelWithDebInfo
sudo make -C ~/neovim install
