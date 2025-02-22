#!/usr/bin/env bash

# Script to install Tilt on macOS
# Usage examples:
#   ./install_tilt.sh
#   ./install_tilt.sh --version="v0.30.12"
#   ./install_tilt.sh --dry
#   ./install_tilt.sh --version="v0.30.12" --dry

script_dir=$(cd $(dirname "${BASH_SOURCE[0]}") && pwd)
cd "$script_dir"

# Default values
version="latest"
dry="0"

# Parse command line arguments
while [[ $# > 0 ]]; do
    case "$1" in
        --version=*)
            version="${1#*=}"
            ;;
        --dry)
            dry="1"
            ;;
        *)
            echo "Unknown parameter: $1"
            echo "Usage: ./install_tilt.sh [--version=\"version\"] [--dry]"
            exit 1
            ;;
    esac
    shift
done

# Logging function
log() {
    if [[ $dry == "1" ]]; then
        echo "[DRY_RUN]: $@"
    else
        echo "$@"
    fi
}

# Execute function - runs commands or just logs them in dry run mode
execute() {
    log "execute: $@"
    if [[ $dry == "1" ]]; then
        return
    fi
    "$@"
}

log "=== Starting Tilt installation ==="
log "Config: version=$version"

# Check if Homebrew is installed
if ! command -v brew &>/dev/null; then
    log "Installing Homebrew..."
    if [[ $dry == "0" ]]; then
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        
        # Add Homebrew to PATH
        log "Adding Homebrew to PATH..."
        if [[ $(uname -m) == "arm64" ]]; then
            echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
            eval "$(/opt/homebrew/bin/brew shellenv)"
        else
            echo 'eval "$(/usr/local/bin/brew shellenv)"' >> ~/.zprofile
            eval "$(/usr/local/bin/brew shellenv)"
        fi
    fi
else
    log "Homebrew is already installed."
fi

# Update Homebrew
log "Updating Homebrew..."
execute brew update

# Install Tilt
log "Installing Tilt..."
if [[ "$version" == "latest" ]]; then
    execute brew install tilt-dev/tap/tilt
else
    # For specific versions, we use the official installation script
    log "Installing specific version: $version"
    if [[ $dry == "0" ]]; then
        curl -fsSL "https://raw.githubusercontent.com/tilt-dev/tilt/master/scripts/install.sh" | bash -s -- "$version"
    else
        log "Would run: curl -fsSL 'https://raw.githubusercontent.com/tilt-dev/tilt/master/scripts/install.sh' | bash -s -- '$version'"
    fi
fi

# Verify Tilt installation
if [[ $dry == "0" ]]; then
    if ! command -v tilt &>/dev/null; then
        log "Error: Tilt installation failed."
        exit 1
    fi
fi

# Check for dependencies
log "Checking for required dependencies..."
deps=("docker" "kubectl")
missing_deps=()

for dep in "${deps[@]}"; do
    if ! command -v "$dep" &>/dev/null; then
        missing_deps+=("$dep")
    fi
done

if [[ ${#missing_deps[@]} -gt 0 ]]; then
    log "Warning: The following dependencies are missing:"
    for dep in "${missing_deps[@]}"; do
        log "  - $dep"
    fi
    
    log "Installing missing dependencies..."
    for dep in "${missing_deps[@]}"; do
        case "$dep" in
            "docker")
                log "Docker Desktop is recommended. Please install from https://www.docker.com/products/docker-desktop"
                ;;
            "kubectl")
                execute brew install kubectl
                ;;
        esac
    done
else
    log "All dependencies are installed."
fi

# Display Tilt information
log "=== Tilt installation complete ==="
if [[ $dry == "0" ]]; then
    tilt_version=$(tilt version)
    log "Tilt version: $tilt_version"
    
    log "Installed dependencies:"
    for dep in "${deps[@]}"; do
        if command -v "$dep" &>/dev/null; then
            version=$("$dep" version 2>&1 | head -n 1)
            log "  - $dep: $version"
        fi
    done
else
    log "Tilt version would be displayed here"
    log "Installed dependencies would be listed here"
fi

log "=== Post-installation steps ==="
log "To verify your installation, run: tilt version"
log "To start using Tilt, navigate to your project directory and run: tilt up"
log "For more information, visit the Tilt documentation at: https://docs.tilt.dev/"

log "=== Tilt installation completed successfully ==="
