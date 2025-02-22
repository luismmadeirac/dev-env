#!/usr/bin/env bash

echo "Bootstraping configuration for new mac..."

# MacOS Configuration
./resources/mac/init.sh

# Look for homebrew and if not found install it
if ! command -v brew &>/dev/null; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Look for git and if not found install it
if !command -v git &>/dev/null; then
    # install git if command git not found
    brew install git
fi

if [ ! -d $HOME/personal ]; then
    mkdir $HOME/personal
fi

git clone https://github.com/luismmadeirac/dev-env $HOME/personal/dev

# Init dev configuration
pushd $HOME/personal/dev
./run
./env/dev-env.sh/
popd
