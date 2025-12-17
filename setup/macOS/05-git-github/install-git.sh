#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
UTILS_DIR="$(cd "$SCRIPT_DIR/../../../utils" && pwd)"

[[ -z "$CORE_CONFIG_LOADED" ]] && source "$UTILS_DIR/core.sh"
source "$UTILS_DIR/logging.sh"

main() {
    init_logging

    log_info "Checking Git installation" "GIT"

    if command -v git &>/dev/null; then
        local git_version=$(git --version)
        log_success "Git already installed: $git_version"
        return 0
    fi

    log_info "Installing Git via Homebrew..."

    if ! command -v brew &>/dev/null; then
        log_error "Homebrew not found. Please install Homebrew first."
        exit 1
    fi

    brew install git

    if command -v git &>/dev/null; then
        local git_version=$(git --version)
        log_success "Git installed successfully: $git_version"
    else
        log_error "Git installation failed"
        exit 1
    fi
}

main
