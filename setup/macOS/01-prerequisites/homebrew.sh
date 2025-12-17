#!/bin/bash

source_util "core"
source_util "logging"
source_util "network_utils"
source_util "shell_utils"
source_util "requirements_checker"

main() {
    init_logging

    if ! validate_macos_requirements; then
        exit 1
    fi

    local arch="$(detect_macos_architecture)"
    log_info "Detected architecture: $arch"

    if ! check_internet_connection; then
        log_error "No internet connection"
        exit 1
    fi

    if command_exists brew; then
        log_success "Homebrew already installed"
        return 0
    fi

    install_homebrew
    configure_homebrew_environment
    verify_homebrew

    add_homebrew_to_shell_config
}
