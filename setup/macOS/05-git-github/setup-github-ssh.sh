#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
UTILS_DIR="$(cd "$SCRIPT_DIR/../../../utils" && pwd)"

[[ -z "$CORE_CONFIG_LOADED" ]] && source "$UTILS_DIR/core.sh"
source "$UTILS_DIR/logging.sh"

main() {
    init_logging

    log_info "Setting up GitHub SSH credentials" "GITHUB"

    if [[ -f "$HOME/.ssh/id_ed25519" ]] || [[ -f "$HOME/.ssh/id_rsa" ]]; then
        log_success "SSH key already exists"

        if ssh -T git@github.com 2>&1 | grep -q "successfully authenticated"; then
            log_success "GitHub SSH connection verified"
            return 0
        else
            log_warn "SSH key exists but GitHub connection failed"
            log_info "Please add your SSH key to GitHub: https://github.com/settings/keys"
        fi
    else
        log_info "No SSH key found"

        echo ""
        read -p "Enter your GitHub email address: " github_email

        if [[ -z "$github_email" ]]; then
            log_error "Email address is required"
            exit 1
        fi

        log_info "Generating SSH key..."
        ssh-keygen -t ed25519 -C "$github_email" -f "$HOME/.ssh/id_ed25519" -N ""

        eval "$(ssh-agent -s)"
        ssh-add "$HOME/.ssh/id_ed25519"

        log_success "SSH key generated successfully"
        log_info "Public key:"
        cat "$HOME/.ssh/id_ed25519.pub"

        echo ""
        log_warn "ACTION REQUIRED:"
        log_info "1. Copy the public key above"
        log_info "2. Go to https://github.com/settings/keys"
        log_info "3. Click 'New SSH key'"
        log_info "4. Paste your key and save"
        echo ""
        read -p "Press Enter when you've added the key to GitHub..."

        if ssh -T git@github.com 2>&1 | grep -q "successfully authenticated"; then
            log_success "GitHub SSH connection verified"
        else
            log_error "GitHub SSH connection failed"
            exit 1
        fi
    fi

    if ! git config --global user.name &>/dev/null; then
        echo ""
        read -p "Enter your Git username: " git_username
        git config --global user.name "$git_username"
        log_success "Git username set to: $git_username"
    else
        log_info "Git username already configured: $(git config --global user.name)"
    fi

    if ! git config --global user.email &>/dev/null; then
        echo ""
        read -p "Enter your Git email: " git_email
        git config --global user.email "$git_email"
        log_success "Git email set to: $git_email"
    else
        log_info "Git email already configured: $(git config --global user.email)"
    fi

    log_success "GitHub SSH setup complete" "GITHUB"
}

main
