#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
UTILS_DIR="$(cd "$SCRIPT_DIR/../../../utils" && pwd)"

[[ -z "$CORE_CONFIG_LOADED" ]] && source "$UTILS_DIR/core.sh"
source "$UTILS_DIR/logging.sh"

main() {
    init_logging

    log_info "Installing Neovim" "TOOLS"

    if command -v nvim &>/dev/null; then
        local nvim_version=$(nvim --version | head -n1)
        log_success "Neovim already installed: $nvim_version"
        return 0
    fi

    if ! command -v brew &>/dev/null; then
        log_error "Homebrew required for Neovim installation"
        exit 1
    fi

    brew install neovim

    if command -v nvim &>/dev/null; then
        local nvim_version=$(nvim --version | head -n1)
        log_success "Neovim installed: $nvim_version"
    else
        log_error "Neovim installation failed"
        exit 1
    fi
}

main
