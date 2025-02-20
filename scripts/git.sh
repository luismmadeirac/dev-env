#!/usr/bin/env bash

# Script to install and configure Git on macOS
# Usage examples:
#   ./setup_git.sh --name="John Doe" --email="john@example.com"
#   ./setup_git.sh --name="John Doe" --email="john@example.com" --dry
#   ./setup_git.sh --dry

script_dir=$(cd $(dirname "${BASH_SOURCE[0]}") && pwd)
cd "$script_dir"

# Default values
name=""
email=""
dry="0"

# Parse command line arguments
while [[ $# > 0 ]]; do
    case "$1" in
    --name=*)
        name="${1#*=}"
        ;;
    --email=*)
        email="${1#*=}"
        ;;
    --dry)
        dry="1"
        ;;
    *)
        echo "Unknown parameter: $1"
        echo "Usage: ./setup_git.sh --name=\"Your Name\" --email=\"your.email@example.com\" [--dry]"
        exit 1
        ;;
    esac
    shift
done

# Logging function
log() {
    if [[ $dry == "1" ]]; then
        echo "[DRY_RUN]: $@"
    else
        echo "$@"
    fi
}

# Execute function - runs commands or just logs them in dry run mode
execute() {
    log "execute: $@"
    if [[ $dry == "1" ]]; then
        return
    fi
    "$@"
}

# Prompt for name and email if not provided
if [[ -z "$name" ]]; then
    read -p "Enter your name: " name
fi

if [[ -z "$email" ]]; then
    read -p "Enter your email: " email
fi

execute brew update
execute brew install git

# Verify Git installation
if [[ $dry == "0" ]]; then
    if ! command -v git &>/dev/null; then
        log "Error: Git installation failed."
        exit 1
    fi
fi

Configure Git
log "Configuring Git with name=$name, email=$email"
execute git config --global user.name "$name"
execute git config --global user.email "$email"

# Configure default branch name to main
execute git config --global init.defaultBranch main

# Configure common Git settings
execute git config --global core.editor "nano"
execute git config --global color.ui auto
execute git config --global pull.rebase false

# Display Git configuration
log "------------------- Git configuration complete ------------------"

if [[ $dry == "0" ]]; then
    log "Git version: $(git --version)"
    log "Git configuration:"
    git config --global --list
else
    log "Git version would be displayed here"
    log "Git configuration would be displayed here"
fi
