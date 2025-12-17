#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
UTILS_DIR="$(cd "$SCRIPT_DIR/../../../utils" && pwd)"

[[ -z "$CORE_CONFIG_LOADED" ]] && source "$UTILS_DIR/core.sh"
source "$UTILS_DIR/logging.sh"

main() {
    init_logging

    log_info "Running dev-env deployment" "DEV-ENV"

    if [[ ! -f "$DEV_ENV/dev-env.sh" ]]; then
        log_error "dev-env.sh not found at: $DEV_ENV/dev-env.sh"
        log_info "Make sure the repository was cloned correctly"
        exit 1
    fi

    log_info "Deploying configurations from: $DEV_ENV/env"

    "$DEV_ENV/dev-env.sh" --verbose

    log_success "dev-env deployment complete" "DEV-ENV"
}

main
