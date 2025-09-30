#!/bin/bash

show_usage() {
    cat <<EOF
dev-env Configurations

USAGE:
    ./dev-env.sh [options]

OPTIONS:
    --plan-only         Show what changes will be made without applying them
    --auto-approve      Skip interactive confirmation and apply automatically
    --verbose, -v       Enable verbose logging
    --help, -h          Show this help message

WHAT WILL HAPPEN:
    1. Shows you a plan of what changes will be made (dry-run)
    2. Asking for confirmation to proceed (unless --auto-approve flag is passed)
    3. Copies config dirs from env/.config to ~/.config
    4. Copies local scripts from env/.local to ~/.local
    5. Copies shell configuration files (.zshrc, .zsh_profile, .zsh_alias)

ENVIRONMENT VARIABLES:
    DEV_ENV             Path to development environment (default: $HOME/personal/dev-env-v2)
    XDG_CONFIG_HOME     Path to config directory (default: $HOME/.config)

EXAMPLES:
    ./dev-env.sh                    # Show plan, then ask to deploy
    ./dev-env.sh --plan-only        # Only show what would be deployed
    ./dev-env.sh --auto-approve     # Deploy without confirmation
    ./dev-env.sh --verbose          # Deploy with detailed logging

EOF
}
