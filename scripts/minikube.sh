#!/usr/bin/env bash

# Script to install Minikube on macOS
# Usage examples:
#   ./install_minikube.sh
#   ./install_minikube.sh --version="v1.32.0"
#   ./install_minikube.sh --driver="docker"
#   ./install_minikube.sh --dry
#   ./install_minikube.sh --version="v1.32.0" --driver="hyperkit" --memory="4g" --cpus="4" --dry

script_dir=$(cd $(dirname "${BASH_SOURCE[0]}") && pwd)
cd "$script_dir"

# Default values
version="latest"
driver="docker" # Default driver
memory="2g"     # Default memory allocation
cpus="2"        # Default CPU allocation
dry="0"

# Parse command line arguments
while [[ $# > 0 ]]; do
    case "$1" in
    --version=*)
        version="${1#*=}"
        ;;
    --driver=*)
        driver="${1#*=}"
        ;;
    --memory=*)
        memory="${1#*=}"
        ;;
    --cpus=*)
        cpus="${1#*=}"
        ;;
    --dry)
        dry="1"
        ;;
    *)
        echo "Unknown parameter: $1"
        echo "Usage: ./install_minikube.sh [--version=\"version\"] [--driver=\"driver\"] [--memory=\"memory\"] [--cpus=\"cpus\"] [--dry]"
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

log "=== Starting Minikube installation ==="
log "Config: version=$version, driver=$driver, memory=$memory, cpus=$cpus"

# Check if Homebrew is installed
if ! command -v brew &>/dev/null; then
    log "Installing Homebrew..."
    if [[ $dry == "0" ]]; then
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

        # Add Homebrew to PATH
        log "Adding Homebrew to PATH..."
        if [[ $(uname -m) == "arm64" ]]; then
            echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >>~/.zprofile
            eval "$(/opt/homebrew/bin/brew shellenv)"
        else
            echo 'eval "$(/usr/local/bin/brew shellenv)"' >>~/.zprofile
            eval "$(/usr/local/bin/brew shellenv)"
        fi
    fi
else
    log "Homebrew is already installed."
fi

# Update Homebrew
log "Updating Homebrew..."
execute brew update

# Check for and install required dependencies based on the chosen driver
log "Checking for required dependencies based on driver: $driver"
case "$driver" in
"hyperkit")
    if ! command -v hyperkit &>/dev/null; then
        log "Installing hyperkit driver..."
        execute brew install hyperkit
        execute brew install minikube
        execute minikube config set driver hyperkit
    fi
    ;;
"virtualbox")
    if ! command -v VBoxManage &>/dev/null; then
        log "VirtualBox is required for the virtualbox driver."
        log "Please install VirtualBox from https://www.virtualbox.org/wiki/Downloads"
        if [[ $dry == "0" ]]; then
            read -p "Press Enter to continue once VirtualBox is installed or Ctrl+C to abort..."
        fi
    fi
    ;;
"docker")
    if ! command -v docker &>/dev/null; then
        log "Docker is required for the docker driver."
        log "Installing Docker..."
        execute brew install --cask docker
        log "Please start Docker Desktop and ensure it's running."
        if [[ $dry == "0" ]]; then
            read -p "Press Enter to continue once Docker is running or Ctrl+C to abort..."
        fi
    else
        log "Docker is already installed."
        # Check if Docker is running
        if [[ $dry == "0" ]]; then
            if ! docker info &>/dev/null; then
                log "Docker is installed but not running."
                log "Please start Docker Desktop and ensure it's running."
                read -p "Press Enter to continue once Docker is running or Ctrl+C to abort..."
            fi
        fi
    fi
    ;;
*)
    log "Using custom driver: $driver"
    log "Please ensure any prerequisites for this driver are installed."
    ;;
esac

# Install kubectl if not already installed
if ! command -v kubectl &>/dev/null; then
    log "Installing kubectl..."
    execute brew install kubectl
else
    log "kubectl is already installed."
fi

# Install Minikube
if ! command -v minikube &>/dev/null; then
    log "Installing Minikube..."
    if [[ "$version" == "latest" ]]; then
        execute brew install minikube
    else
        log "Installing specific version: $version"
        if [[ $dry == "0" ]]; then
            curl -LO "https://storage.googleapis.com/minikube/releases/$version/minikube-darwin-amd64"
            sudo install minikube-darwin-amd64 /usr/local/bin/minikube
            rm minikube-darwin-amd64
        else
            log "Would download and install Minikube version $version"
        fi
    fi
else
    current_version=$(minikube version --short 2>/dev/null)
    log "Minikube is already installed (Current version: $current_version)"

    if [[ "$version" != "latest" && "$current_version" != "$version" ]]; then
        log "Updating Minikube to version $version..."
        if [[ $dry == "0" ]]; then
            curl -LO "https://storage.googleapis.com/minikube/releases/$version/minikube-darwin-amd64"
            sudo install minikube-darwin-amd64 /usr/local/bin/minikube
            rm minikube-darwin-amd64
        else
            log "Would update Minikube to version $version"
        fi
    fi
fi

# Verify Minikube installation
if [[ $dry == "0" ]]; then
    if ! command -v minikube &>/dev/null; then
        log "Error: Minikube installation failed."
        exit 1
    fi
fi

# Set default driver if needed
log "Setting default driver to: $driver"
execute minikube config set driver $driver

# Display Minikube configuration
log "=== Minikube installation complete ==="
if [[ $dry == "0" ]]; then
    minikube_version=$(minikube version)
    log "Minikube version: $minikube_version"
    log "Kubectl version: $(kubectl version --client --short)"
    log "Current Minikube configuration:"
    minikube config view
else
    log "Minikube version would be displayed here"
    log "Kubectl version would be displayed here"
    log "Minikube configuration would be displayed here"
fi

# Instructions for starting Minikube
log "=== Post-installation steps ==="
log "To start Minikube with your configuration, run:"
log "  minikube start --driver=$driver --memory=$memory --cpus=$cpus"
log "To verify your installation, run:"
log "  minikube status"
log "To access the Kubernetes dashboard, run:"
log "  minikube dashboard"
log "To stop Minikube, run:"
log "  minikube stop"
log "For more information, visit: https://minikube.sigs.k8s.io/docs/"

log "=== Minikube installation completed successfully ==="
