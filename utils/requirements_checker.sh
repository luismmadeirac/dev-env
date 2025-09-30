#!/bin/bash

check_macos_required() {
    [[ "$(uname)" == "Darwin" ]]
}

check_xcode_tools() {
    xcode-select -p >/dev/null 2>&1
}

validate_macos_requirements() {
    check_macos_required || {
        log_error "macOS required"
        return 1
    }
    check_xcode_tools || {
        log_error "Xcode tools required"
        return 1
    }
    command_exists curl || {
        log_error "curl required"
        return 1
    }
}

detect_macos_architecture() {
    local arch="$(uname -m)"
    case "$arch" in
    arm64) echo "apple_silicon" ;;
    x86_64) echo "intel" ;;
    *) echo "unknown" ;;
    esac
}
