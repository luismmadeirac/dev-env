#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
UTILS_DIR="$(cd "$SCRIPT_DIR/../../../utils" && pwd)"

[[ -z "$CORE_CONFIG_LOADED" ]] && source "$UTILS_DIR/core.sh"
source "$UTILS_DIR/logging.sh"

main() {
    init_logging

    log_info "Checking dev-env repository" "REPO"

    if [[ -d "$DEV_ENV_DIR/.git" ]]; then
        log_success "Repository already cloned at: $DEV_ENV_DIR"

        # Update to latest
        log_info "Pulling latest changes..."
        cd "$DEV_ENV_DIR"
        git pull origin main || git pull origin master || log_warn "Could not pull latest changes"

        log_success "Repository up to date"
        return 0
    fi

    log_info "Cloning dev-env repository to: $DEV_ENV_DIR"

    mkdir -p "$(dirname "$DEV_ENV_DIR")"

    echo ""
    log_info "Enter your dev-env repository URL"
    log_info "Example: git@github.com:username/dev-env-v2.git"
    read -p "Repository URL: " repo_url

    if [[ -z "$repo_url" ]]; then
        log_error "Repository URL is required"
        exit 1
    fi

    # Clone the repository
    if git clone "$repo_url" "$DEV_ENV_DIR"; then
        log_success "Repository cloned successfully to: $DEV_ENV_DIR"
    else
        log_error "Failed to clone repository"
        exit 1
    fi

    # Export DEV_ENV for immediate use
    export DEV_ENV="$DEV_ENV_DIR"
    log_info "DEV_ENV set to: $DEV_ENV"
}

main
