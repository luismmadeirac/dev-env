#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
export UTILS_DIR="$SCRIPT_DIR/../../utils"
export SETUP_DIR="$SCRIPT_DIR"

source "$UTILS_DIR/core.sh"
source "$UTILS_DIR/logging.sh"
source "$UTILS_DIR/commands.sh"

load_setup_steps() {
    log_debug "Loading bootstrap setup steps" "BOOTSTRAP"

    add_step "Configure macOS System - UI" \
        "setup/macOS/02-system/ui.sh" \
        "Configure macOS UI preferences" \
        false

    add_step "Configure macOS System - Dock" \
        "setup/macOS/02-system/dock.sh" \
        "Configure Dock appearance and behavior" \
        false

    add_step "Configure macOS System - Finder" \
        "setup/macOS/02-system/finder.sh" \
        "Configure Finder preferences" \
        false

    add_step "Configure macOS System - Desktop" \
        "setup/macOS/02-system/desktop.sh" \
        "Configure Desktop preferences" \
        false

    add_step "Configure macOS System - Screenshots" \
        "setup/macOS/02-system/screenshots.sh" \
        "Configure screenshot settings" \
        false

    add_step "Configure macOS System - Terminal" \
        "setup/macOS/02-system/terminal.sh" \
        "Configure Terminal settings" \
        false

    add_step "Configure macOS System - Activity Monitor" \
        "setup/macOS/02-system/activity-monitor.sh" \
        "Configure Activity Monitor" \
        false

    add_step "Configure macOS System - Calendar" \
        "setup/macOS/02-system/calendar.sh" \
        "Configure Calendar settings" \
        false

    add_step "Configure macOS System - Peripherals" \
        "setup/macOS/02-system/peripherals.sh" \
        "Configure keyboard and trackpad settings" \
        false

    add_step "Configure macOS System - Energy" \
        "setup/macOS/02-system/engergy.sh" \
        "Configure energy settings" \
        false

    add_step "Configure macOS System - Preferences" \
        "setup/macOS/02-system/sys-preferences.sh" \
        "Configure system preferences" \
        false

    add_step "Remove Default macOS Apps" \
        "setup/macOS/02-system/nuke-os-apps.sh" \
        "Remove unwanted default macOS applications" \
        false

    add_step "Install Xcode Command Line Tools" \
        "setup/macOS/01-prerequisites/xcode-cmd-tools.sh" \
        "Install Xcode Command Line Tools (required for Homebrew)" \
        false

    add_step "Install Homebrew" \
        "setup/macOS/01-prerequisites/homebrew.sh" \
        "Install Homebrew package manager" \
        false

    add_step "Setup Directory Structure" \
        "setup/macOS/03-directories/setup-dirs.sh" \
        "Create personal and development directories" \
        false

    add_step "Install Applications" \
        "setup/macOS/04-applications/install-apps.sh" \
        "Install applications and tools via Homebrew" \
        false

    add_step "Install Git" \
        "setup/macOS/05-git-github/install-git.sh" \
        "Install and configure Git" \
        false

    add_step "Setup GitHub SSH" \
        "setup/macOS/05-git-github/setup-github-ssh.sh" \
        "Configure GitHub SSH credentials" \
        false

    add_step "Clone dev-env Repository" \
        "setup/macOS/06-repository/clone-repo.sh" \
        "Clone the dev-env repository" \
        false

    add_step "Install Shell Tools" \
        "setup/macOS/07-tools/install-shell-tools.sh" \
        "Install Oh My Zsh and asdf" \
        false

    add_step "Install tmux" \
        "setup/macOS/07-tools/install-tmux.sh" \
        "Install tmux terminal multiplexer" \
        false

    add_step "Install Neovim" \
        "setup/macOS/07-tools/install-neovim.sh" \
        "Install Neovim text editor" \
        false

    add_step "Deploy dev-env Configurations" \
        "setup/macOS/08-dev-env/run-dev-env.sh" \
        "Deploy personal dotfiles and configurations" \
        false

    log_debug "Loaded bootstrap setup steps" "BOOTSTRAP"
}

bootstrap_main() {
    log_info "Starting macOS development environment bootstrap" "BOOTSTRAP"

    if [[ "$(uname)" != "Darwin" ]]; then
        log_error "This bootstrap script is designed for macOS only"
        exit 1
    fi

    log_step "Initializing setup framework..."
    cmd_init

    log_step "Generating execution plan..."
    cmd_plan

    if [[ "$AUTO_APPROVE" != "true" ]]; then
        echo ""
        read -p "Do you want to apply this setup plan? (y/N): " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            log_info "Bootstrap cancelled by user"
            exit 0
        fi
    fi

    log_step "Applying setup..."

    cmd_apply

    log_success "Bootstrap completed!" "BOOTSTRAP"
    log_info "Your macOS development environment has been fully configured"
    echo ""
    log_warn "IMPORTANT: A restart is required for all changes to take effect"

    if [[ "$AUTO_APPROVE" != "true" ]]; then
        echo ""
        read -p "Do you want to restart now? (y/N): " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            log_info "Restarting system..."
            sudo shutdown -r now
        else
            log_info "Please restart your system manually when ready"
        fi
    else
        log_info "Auto-approve enabled - skipping automatic restart"
        log_info "Please restart your system manually for changes to take effect"
    fi
}

# Show usage information
show_bootstrap_usage() {
    cat <<EOF
Bootstrap Script - macOS Development Environment Setup

USAGE:
    ./bootstrap.sh [options]

OPTIONS:
    --help, -h       DisDisplay this help message
    --auto-approve   Skip interactive confirmation and apply automatically
    --plan-only      Only show the execution plan, don't apply changes
    --verbose        Enable verbose logging

DESCRIPTION:
    This script bootstraps your macOS development environment by:
    1. Configuring macOS system settings (Dock, Finder, UI, etc.)
    2. Installing Xcode Command Line Tools
    3. Installing Homebrew package manager
    4. Setting up directory structure
    5. Installing applications via Homebrew
    6. Setting up Git and GitHub SSH credentials
    7. Cloning the dev-env repository
    8. Deploying personal dotfiles and configurations
    10. Restarting the system (optional but required for some change to be applied)

EXAMPLES:
    ./bootstrap.sh                    # Interactive bootstrap
    ./bootstrap.sh --auto-approve     # Automatic bootstrap
    ./bootstrap.sh --plan-only        # Show plan without applying
    ./bootstrap.sh --verbose          # Enable detailed logging

EOF
}

AUTO_APPROVE=false
PLAN_ONLY=false
VERBOSE=false

while [[ $# -gt 0 ]]; do
    case $1 in
    --auto-approve)
        AUTO_APPROVE=true
        export CLI_AUTO_APPROVE=true
        ;;
    --plan-only)
        PLAN_ONLY=true
        ;;
    --verbose | -v)
        VERBOSE=true
        export CLI_VERBOSE=true
        export LOG_LEVEL=$LOG_DEBUG
        ;;
    --help | -h)
        show_bootstrap_usage
        exit 0
        ;;
    *)
        log_error "Unknown option: $1"
        show_bootstrap_usage
        exit 1
        ;;
    esac
    shift
done

if [[ "$PLAN_ONLY" == "true" ]]; then
    log_info "Plan-only mode enabled" "BOOTSTRAP"
    cmd_init
    cmd_plan
    exit 0
fi

if [[ "$VERBOSE" == "true" ]]; then
    export LOG_LEVEL=$LOG_DEBUG
fi

bootstrap_main
