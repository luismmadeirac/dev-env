#!/usr/bin/env bash

# Script to install Kubernetes CLI (kubectl) on macOS
# Usage examples:
#   ./install_kubectl.sh
#   ./install_kubectl.sh --version="v1.28.4"
#   ./install_kubectl.sh --dry
#   ./install_kubectl.sh --version="v1.28.4" --completion=zsh --dry

script_dir=$(cd $(dirname "${BASH_SOURCE[0]}") && pwd)
cd "$script_dir"

# Default values
version="latest"
completion="none" # Options: none, bash, zsh
dry="0"

# Parse command line arguments
while [[ $# > 0 ]]; do
    case "$1" in
    --version=*)
        version="${1#*=}"
        ;;
    --completion=*)
        completion="${1#*=}"
        ;;
    --dry)
        dry="1"
        ;;
    *)
        echo "Unknown parameter: $1"
        echo "Usage: ./install_kubectl.sh [--version=\"version\"] [--completion=\"bash|zsh\"] [--dry]"
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

log "=== Starting Kubernetes CLI (kubectl) installation ==="
log "Config: version=$version, completion=$completion"

# Detect shell
if [[ "$completion" == "none" ]]; then
    current_shell=$(basename "$SHELL")
    if [[ "$current_shell" == "zsh" || "$current_shell" == "bash" ]]; then
        log "Detected shell: $current_shell"
        log "You can enable shell completion with --completion=$current_shell"
    fi
fi

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

# Install kubectl
if ! command -v kubectl &>/dev/null; then
    log "Installing kubectl..."
    if [[ "$version" == "latest" ]]; then
        execute brew install kubectl
    else
        log "Installing specific version: $version (without version prefix 'v')"
        # Remove 'v' prefix if present
        clean_version=${version#v}
        execute brew install "kubectl@$clean_version"
    fi
else
    current_version=$(kubectl version --client -o yaml | grep -m 1 gitVersion | cut -d ':' -f 2 | tr -d ' "')
    log "kubectl is already installed (Current version: $current_version)"

    if [[ "$version" != "latest" && "$current_version" != "$version" ]]; then
        log "Updating kubectl to version $version..."
        # Remove 'v' prefix if present
        clean_version=${version#v}

        # Unlink current version if it's linked
        execute brew unlink kubectl

        # Install specific version
        execute brew install "kubectl@$clean_version"
    fi
fi

# Verify kubectl installation
if [[ $dry == "0" ]]; then
    if ! command -v kubectl &>/dev/null; then
        log "Error: kubectl installation failed."
        exit 1
    fi
fi

# Set up shell completion
if [[ "$completion" != "none" ]]; then
    log "Setting up kubectl completion for $completion shell..."

    case "$completion" in
    "bash")
        completion_file=~/.bash_completion
        if [[ ! -f "$completion_file" ]]; then
            execute touch "$completion_file"
        fi

        if ! grep -q "kubectl completion bash" "$completion_file"; then
            execute echo "source <(kubectl completion bash)" >>"$completion_file"
            log "Added kubectl completion to $completion_file"

            # Add source to ~/.bashrc if not already present
            if ! grep -q "source ~/.bash_completion" ~/.bashrc 2>/dev/null; then
                execute echo "source ~/.bash_completion" >>~/.bashrc
                log "Added source command to ~/.bashrc"
            fi
        else
            log "kubectl completion already configured for bash"
        fi
        ;;

    "zsh")
        # Create the completion directory if it doesn't exist
        execute mkdir -p ~/.zsh/completion

        # Generate the completion script and save it
        if [[ $dry == "0" ]]; then
            kubectl completion zsh >~/.zsh/completion/_kubectl
            log "Generated kubectl completion script at ~/.zsh/completion/_kubectl"
        else
            log "Would generate kubectl completion script at ~/.zsh/completion/_kubectl"
        fi

        # Make sure the completion directory is in the fpath
        zshrc_file=~/.zshrc
        if ! grep -q "fpath=(~/.zsh/completion \$fpath)" "$zshrc_file" 2>/dev/null; then
            execute echo "fpath=(~/.zsh/completion \$fpath)" >>"$zshrc_file"
            execute echo "autoload -U compinit && compinit" >>"$zshrc_file"
            log "Added completion directory to fpath in $zshrc_file"
        else
            log "Completion directory already in fpath"
        fi
        ;;

    *)
        log "Unsupported shell for completion: $completion"
        log "Supported shells: bash, zsh"
        ;;
    esac
fi

# Display kubectl information
log "=== kubectl installation complete ==="
if [[ $dry == "0" ]]; then
    kubectl_version=$(kubectl version --client)
    log "kubectl version: $kubectl_version"
else
    log "kubectl version would be displayed here"
fi

# Install bash-completion if needed and using bash
if [[ "$completion" == "bash" && $dry == "0" ]]; then
    if ! brew list bash-completion &>/dev/null; then
        log "Installing bash-completion..."
        execute brew install bash-completion
    fi
fi

# Add kubectl aliases to make life easier
alias_file=""
case "$SHELL" in
*/zsh)
    alias_file=~/.zshrc
    ;;
*/bash)
    alias_file=~/.bashrc
    ;;
esac

if [[ -n "$alias_file" && $dry == "0" ]]; then
    log "Adding useful kubectl aliases to $alias_file..."

    # Only add aliases if they don't already exist
    if ! grep -q "# kubectl aliases" "$alias_file"; then
        cat <<'EOF' >>"$alias_file"

# kubectl aliases
alias k='kubectl'
alias kg='kubectl get'
alias kgp='kubectl get pods'
alias kgs='kubectl get services'
alias kgd='kubectl get deployments'
alias kdp='kubectl describe pod'
alias kds='kubectl describe service'
alias kdd='kubectl describe deployment'
alias kl='kubectl logs'
alias kex='kubectl exec -it'
alias kns='kubectl config set-context --current --namespace'
alias kcgc='kubectl config get-contexts'
alias kcuc='kubectl config use-context'
alias ktop='kubectl top'
EOF
        log "Added kubectl aliases to $alias_file"
    else
        log "kubectl aliases already exist in $alias_file"
    fi
elif [[ $dry == "1" && -n "$alias_file" ]]; then
    log "Would add kubectl aliases to $alias_file"
fi

log "=== Post-installation steps ==="
log "To verify your installation, run:"
log "  kubectl version --client"
log "To check if kubectl can connect to a cluster, run:"
log "  kubectl cluster-info"
log "For more information, visit: https://kubernetes.io/docs/tasks/tools/"

if [[ "$completion" != "none" ]]; then
    log "Shell completion has been configured. Please restart your shell or run:"
    case "$completion" in
    "bash")
        log "  source ~/.bash_completion"
        ;;
    "zsh")
        log "  source ~/.zshrc"
        ;;
    esac
fi

log "=== kubectl installation completed successfully ==="
