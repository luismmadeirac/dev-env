#!/bin/bash

detect_macos_architecture() {
    local arch="$(uname -m)"
    case "$arch" in
    arm64) echo "apple_silicon" ;;
    x86_64) echo "intel" ;;
    *) echo "unknown" ;;
    esac
}
