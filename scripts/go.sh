#!/usr/bin/env bash

go_version="1.24.0"

echo "version: \"$go_version\""

set -e

check_sudo() {
    if [ "$EUID" -ne 0 ]; then
        print_error "Please run as root or with sudo"
        exit 1
    fi
}

# Detect OS and architecture
detect_os_arch() {
    # Detect OS
    OS="$(uname -s)"
    case "${OS}" in
    Linux*) OS="linux" ;;
    Darwin*) OS="darwin" ;;
    FreeBSD*) OS="freebsd" ;;
    *)
        echo "Unsupported OS: ${OS}"
        exit 1
        ;;
    esac

    # Detect architecture
    ARCH="$(uname -m)"
    case "${ARCH}" in
    x86_64*) ARCH="amd64" ;;
    i*86*) ARCH="386" ;;
    aarch64*) ARCH="arm64" ;;
    armv8*) ARCH="arm64" ;;
    armv7*) ARCH="armv7l" ;;
    armv6*) ARCH="armv6l" ;;
    *)
        echo "Unsupported architecture by this script: ${ARCH}"
        exit 1
        ;;
    esac

    # Special case for Apple Silicon (M1/M2)
    if [ "$OS" = "darwin" ] && [ "$ARCH" = "arm64" ]; then
        echo "Detected macOS ARM (Apple Silicon)"
        OS_ARCH="darwin-arm64"
    elif [ "$OS" = "darwin" ] && [ "$ARCH" = "amd64" ]; then
        echo "Detected macOS Intel"
        OS_ARCH="darwin-amd64"
    else
        echo "Detected $OS $ARCH"
        OS_ARCH="$OS-$ARCH"
    fi
}

install_go() {
    print_status "Preparing to install Go $go_version for $OS_ARCH..."

    # Set download URL
    DOWNLOAD_URL="https://dl.google.com/go/go${go_version}.${OS_ARCH}.tar.gz"

    # Set install location based on OS
    if [ "$OS" = "darwin" ]; then
        INSTALL_DIR="/usr/local"
    else
        INSTALL_DIR="/usr/local"
    fi

    # Create temporary directory
    TMP_DIR=$(mktemp -d)

    print_status "Downloading Go from $DOWNLOAD_URL"
    if command -v curl &>/dev/null; then
        curl -L "$DOWNLOAD_URL" -o "$TMP_DIR/go.tar.gz"
    else
        wget -O "$TMP_DIR/go.tar.gz" "$DOWNLOAD_URL"
    fi

    # Remove existing Go installation if it exists
    if [ -d "$INSTALL_DIR/go" ]; then
        echo "Removing existing Go installation..."
        rm -rf "$INSTALL_DIR/go"
    fi

    print_status "Extracting Go to $INSTALL_DIR..."
    tar -C "$INSTALL_DIR" -xzf "$TMP_DIR/go.tar.gz"

    # Clean up
    rm -rf "$TMP_DIR"

    echo "Go $LATEST_VERSION installed successfully!"
}

configure_environment() {
    echo "Configuring environment variables..."

    # Determine shell config file
    if [ -n "$BASH_VERSION" ]; then
        if [ -f "$HOME/.bashrc" ]; then
            SHELL_CONFIG="$HOME/.bashrc"
        elif [ -f "$HOME/.bash_profile" ]; then
            SHELL_CONFIG="$HOME/.bash_profile"
        fi
    elif [ -n "$ZSH_VERSION" ]; then
        SHELL_CONFIG="$HOME/.zshrc"
    else
        echo "Could not determine shell config file. You may need to set PATH manually."
        return
    fi

    # Add Export path to .zsh-profile
    if [ -n "$SHELL_CONFIG" ]; then
        # Check if PATH already contains Go
        if ! grep -q "export PATH=.*\/go\/bin" "$SHELL_CONFIG"; then
            echo 'export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin' >>"$SHELL_CONFIG"
            echo 'export GOPATH=$HOME/go' >>"$SHELL_CONFIG"
            echo "Environment variables configured in $SHELL_CONFIG"
        else
            echo "Go PATH configuration already exists in $SHELL_CONFIG"
        fi
    fi

    # Create Go workspace if it doesn't exist
    if [ ! -d "$HOME/go" ]; then
        mkdir -p "$HOME/go/bin" "$HOME/go/pkg" "$HOME/go/src"
        print_success "Created Go workspace at $HOME/go"
    fi
}

# Verify installation
verify_installation() {
    print_status "Verifying installation..."

    # We need to use the absolute path as the environment variables might not be loaded yet
    GO_PATH="/usr/local/go/bin/go"

    if [ -x "$GO_PATH" ]; then
        VERSION=$("$GO_PATH" version)
        echo "Go installation verified: $VERSION"
    else
        echo "Go installation verification failed. Please check the installation."
        exit 1
    fi

    echo "To use Go in your current session, run:"
    echo "    export PATH=\$PATH:/usr/local/go/bin:\$HOME/go/bin"
    echo "    export GOPATH=\$HOME/go"
    echo "Go $LATEST_VERSION has been successfully installed!"
}

# Main function
main() {
    echo "---------------------- Install Go ----------------------"

    # Check for sudo if not on macOS
    if [ "$(uname -s)" != "Darwin" ]; then
        check_sudo
    fi

    detect_os_arch
    install_go
    configure_environment
    verify_installation

    echo ""
    echo "Installation complete! You may need to restart your terminal or run 'source $SHELL_CONFIG'"
}

# Excute
main
