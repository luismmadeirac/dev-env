#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
UTILS_DIR="$(cd "$SCRIPT_DIR/../../../utils" && pwd)"

[[ -z "$CORE_CONFIG_LOADED" ]] && source "$UTILS_DIR/core.sh"
source "$UTILS_DIR/logging.sh"

main() {
    init_logging

    log_info "Installing shell tools" "TOOLS"

    log_info "Installing Oh My Zsh..." "SHELL"

    if [[ -d "$XDG_CONFIG_HOME/oh-my-zsh" ]] || [[ -d "$HOME/.oh-my-zsh" ]]; then
        log_success "Oh My Zsh already installed"
        return 0
    fi

    export ZSH="$XDG_CONFIG_HOME/oh-my-zsh"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

    log_success "Oh My Zsh installed"

    log_success "Shell tools installation complete" "TOOLS"
}

main
