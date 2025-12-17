#!/bin/bash

set -e

# Source nvm if available (it's a shell function, not a binary)
if [ -f "$HOME/.config/nvm/nvm.sh" ]; then
    source "$HOME/.config/nvm/nvm.sh"
fi

declare -a results

check_version() {
    local tool=$1
    local cmd=$2
    local version

    if command -v "${tool}" &>/dev/null; then
        version=$(eval "${cmd}" 2>&1 | head -n 1 | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')
        results+=("✓|${tool}|${version}")
    else
        results+=("✗|${tool}|not installed")
    fi
}

# Languages & Runtimes
check_version "node" "node --version"
check_version "nvm" "nvm --version"
check_version "npm" "npm --version"
check_version "yarn" "yarn --version"
check_version "pnpm" "pnpm --version"
check_version "go" "go version"

# Cloud & Infrastructure
check_version "aws" "aws --version"
check_version "terraform" "terraform --version"
check_version "docker" "docker --version"
check_version "kubectl" "kubectl version --client"

# Development Tools
check_version "git" "git --version"
check_version "gh" "gh --version"
check_version "nvim" "nvim --version"
check_version "vim" "vim --version"
check_version "tmux" "tmux -V"
check_version "zsh" "zsh --version"

# Build Tools
check_version "make" "make --version"
check_version "cmake" "cmake --version"

# Print table
printf "%-8s %-15s %s\n" "Status" "Tool" "Version"
printf "%-8s %-15s %s\n" "------" "----" "-------"

for result in "${results[@]}"; do
    IFS='|' read -r status tool version <<<"$result"
    printf "%-8s %-15s %s\n" "$status" "$tool" "$version"
done
