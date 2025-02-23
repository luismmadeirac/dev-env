#!/usr/bin/env bash

# Check if Homebrew is installed, install if not
if ! command -v brew &>/dev/null; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Install Node.js using Homebrew
brew install node

# Install nvm (Node Version Manager)
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash

# Add nvm to shell configuration
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# Configure npm prefix
npm config set prefix ~/.local/npm

# Install n (Node version manager)
npm i -g n

# Install latest LTS version of Node
n lts

# Install Deno
# curl -fsSL https://deno.land/install.sh | sh

# Install Bun
# curl -fsSL https://bun.sh/install | bash

# Add the following to your ~/.zshrc or ~/.bash_profile (if not already present):
echo 'export PATH="$HOME/.local/npm/bin:$PATH"' >>~/.zshrc
echo 'export NVM_DIR="$HOME/.nvm"' >>~/.zshrc
echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"' >>~/.zshrc
