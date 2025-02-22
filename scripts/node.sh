#!/usr/bin/env bash

# Install node into the system
sudo apt install nodejs npm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
npm config set prefix ~/.local/npm
npm i -g n
n lts

# curl -fsSL https://deno.land/install.sh | sh
# curl -fsSL https://bun.sh/install | bash
