#!/usr/bin/env bash

set -euo pipefail

if [[ -n "${DEV_ENV:-}" ]] && [[ -d "$DEV_ENV/utils" ]]; then
    REPO_DIR="$DEV_ENV"
else
    SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    if [[ -d "$SCRIPT_DIR/utils" ]]; then
        REPO_DIR="$SCRIPT_DIR"
    else
        echo "ERROR: Cannot locate dev-env repository utils directory"
        echo "Please ensure DEV_ENV environment variable is set or run from repository root"
        exit 1
    fi
fi

UTILS_DIR="$REPO_DIR/utils"

source "$UTILS_DIR/core.sh"
source "$UTILS_DIR/logging.sh"
source "$UTILS_DIR/file_ops.sh"
source "$UTILS_DIR/dev-env/dev-env-help.sh"

PLAN_ONLY=false
AUTO_APPROVE=false
VERBOSE=false

while [[ $# -gt 0 ]]; do
    case $1 in
    --plan-only)
        PLAN_ONLY=true
        ;;
    --auto-approve)
        AUTO_APPROVE=true
        ;;
    --verbose | -v)
        VERBOSE=true
        export LOG_LEVEL=$LOG_DEBUG
        ;;
    --help | -h)
        show_usage
        exit 0
        ;;
    *)
        log_error "Unknown option: $1"
        show_usage
        exit 1
        ;;
    esac
    shift
done

validate_environment() {
    log_info "Validating environment..." "DEV-ENV"

    if [[ -z "$DEV_ENV" ]]; then
        log_error "Environment variable DEV_ENV needs to be set"
        exit 1
    fi

    if [[ ! -d "$DEV_ENV" ]]; then
        log_error "DEV_ENV directory does not exist: $DEV_ENV"
        exit 1
    fi

    log_success "Environment validated"
    log_info "DEV_ENV: $DEV_ENV"
    log_info "XDG_CONFIG_HOME: $XDG_CONFIG_HOME"
}

deploy_environment() {
    local is_dry_run="${1:-false}"

    if [[ "$is_dry_run" == "true" ]]; then
        log_plan "Showing deployment plan - no changes will be made" "DEV-ENV"
        export DRY_RUN=true
    else
        log_info "Starting development environment deployment" "DEV-ENV"
        export DRY_RUN=false
    fi

    migrate_to_xdg

    update_dotfiles "$DEV_ENV/env" "$HOME" "$XDG_CONFIG_HOME"
    local result=$?

    log_step "cp dev-env script..."
    safe_copy "$REPO_DIR/dev-env.sh" "$HOME/.local/scripts/dev-env.sh" false

    if [[ "$is_dry_run" == "true" ]]; then
        log_success "Plan completed - no changes were made" "DEV-ENV"
    else
        if [[ $result -eq 0 ]]; then
            log_success "Completed!" "DEV-ENV"

            log_step "Verifying zsh configuration"
            if [[ -f "$HOME/.zshrc" ]]; then
                if zsh -c 'source ~/.zshrc' 2>/dev/null; then
                    log_success "Zsh configuration is valid"
                    log_info "Reload your shell or run: source ~/.zshrc"
                else
                    log_warn "Zsh configuration may have issues - please check manually"
                fi
            else
                log_warn "No .zshrc file found"
            fi
        else
            log_warn "Development environment deployment completed with some errors" "DEV-ENV"
        fi
    fi

    return $result
}

main() {
    init_logging

    if [[ "$VERBOSE" == "true" ]]; then
        export LOG_LEVEL=$LOG_DEBUG
    fi

    validate_environment

    if [[ "$PLAN_ONLY" == "true" ]]; then
        log_info "Plan-only mode" "DEV-ENV"
        deploy_environment "true"
        exit 0
    fi

    log_step "Step 1: Deployment plan..."
    deploy_environment "true"

    if [[ "$AUTO_APPROVE" != "true" ]]; then
        echo ""
        read -p "Apply these changes? (y/N): " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            log_info "Deployment cancelled" "DEV-ENV"
            exit 0
        fi
    else
        log_info "Auto-approve enabled" "DEV-ENV"
    fi

    echo ""
    log_step "Step 2: Reviewing changes..."
    deploy_environment "false"
}

main
