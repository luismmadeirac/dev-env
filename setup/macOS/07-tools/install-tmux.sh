#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
UTILS_DIR="$(cd "$SCRIPT_DIR/../../../utils" && pwd)"

[[ -z "$CORE_CONFIG_LOADED" ]] && source "$UTILS_DIR/core.sh"
source "$UTILS_DIR/logging.sh"

main() {
    init_logging

    log_info "Installing tmux" "TOOLS"

    if command -v tmux &>/dev/null; then
        local tmux_version=$(tmux -V)
        log_success "tmux already installed: $tmux_version"
        return 0
    fi

    if ! command -v brew &>/dev/null; then
        log_error "Homebrew required for tmux installation"
        exit 1
    fi

    brew install tmux

    if command -v tmux &>/dev/null; then
        local tmux_version=$(tmux -V)
        log_success "tmux installed: $tmux_version"
    else
        log_error "tmux installation failed"
        exit 1
    fi
}

main
