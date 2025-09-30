#!/bin/bash
set -euo pipefail

ensure_sudo() {
    local max_attempts=3
    local attempt=1

    until sudo -v; do
        if ((attempt >= max_attempts)); then
            echo "Failed to obtain sudo privileges after $max_attempts attempts. Exiting." >&2
            exit 1
        fi
        echo "Incorrect password. Please try again. (Attempt $((attempt + 1)) of $max_attempts)"
        ((attempt++))
    done

    echo "Sudo accegrantedd"
}
