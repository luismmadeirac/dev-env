# Personal Dev Env (macOS) v2

> **Automated macOS development environment setup and personal configuration management**

This repository provides comprehensive automation for setting up a fresh Mac from scratch, including system configuration, application installation, and personal dotfiles deployment. Built with a modular bash framework, it supports both full system bootstrap and granular development environment updates.

## 📑 Table of Contents

- [Features](#-features)
- [Quick Start](#-quick-start)
- [Bootstrap Setup](#-bootstrap-setup-fresh-mac)
- [Dev Environment](#-dev-environment-existing-setup)
- [Repository Structure](#-repository-structure)
- [Documentation](#-documentation)

## ✨ Features

- **🚀 One-Command Setup** - Bootstrap a fresh Mac with a single command
- **📦 Idempotent Scripts** - Run multiple times safely, only applies changes needed
- **🔍 Plan & Apply Workflow** - Review changes before applying them
- **🔄 XDG Compliant** - Clean `$HOME` directory with proper XDG Base Directory structure
- **🛠️ Modular Framework** - Reusable bash utilities for logging, file operations, and commands
- **📊 Progress Tracking** - Clear logging and error reporting throughout execution
- **🔐 Safe Operations** - Automatic backups before modifications
- **🎯 Dependency-Aware** - Scripts execute in proper order with all dependencies met

## 🚀 Quick Start

### Fresh Mac (Full Bootstrap)

```bash
# Clone the repository (requires Git)
git clone https://github.com/luismmadeirac/dev-env.git ~/Developer/dev-env
cd ~/Developer/dev-env

# Review what will be installed/configured
./setup/macOS/macos-bootstrap.sh --plan-only

# Run interactive bootstrap
./setup/macOS/macos-bootstrap.sh

# Or run with auto-approve (no prompts)
./setup/macOS/macos-bootstrap.sh --auto-approve
```

### Existing Setup (Dev Environment Only)

```bash
# Review configuration changes
./dev-env.sh --plan-only

# Apply changes interactively
./dev-env.sh

# Apply changes automatically
./dev-env.sh --auto-approve
```

## 🔧 Bootstrap Setup (Fresh Mac)

The bootstrap process configures a new Mac from scratch with a dependency-aware 10-step flow:

### What Gets Installed/Configured

1. **System Configuration** - macOS settings (Dock, Finder, UI, keyboard, trackpad, etc.)
2. **Xcode Command Line Tools** - Required for development tools
3. **Homebrew** - Package manager for macOS
4. **Directory Structure** - Personal and development directories
5. **Applications** - Essential apps and tools via Homebrew
6. **Git & GitHub** - Git installation and SSH credential setup (interactive)
7. **Repository Clone** - Clones this repo to `$DEV_ENV_DIR` (interactive)
8. **Development Tools** - Node.js (via NVM), pnpm, Yarn, tmux, Neovim, Oh My Zsh
9. **Personal Configurations** - Deploys dotfiles from `env/` directory
10. **System Restart** - Optional restart to apply all changes

### Bootstrap Usage

```bash
# Show execution plan (no changes)
./setup/macOS/macos-bootstrap.sh --plan-only

# Interactive mode (prompts for confirmation)
./setup/macOS/macos-bootstrap.sh

# Automatic mode (no prompts)
./setup/macOS/macos-bootstrap.sh --auto-approve

# Verbose logging
./setup/macOS/macos-bootstrap.sh --verbose

# Get help
./setup/macOS/macos-bootstrap.sh --help
```

### Remote Bootstrap (Fresh Mac)

If you don't have Git installed yet, use curl:

```bash
curl -fsSL https://raw.githubusercontent.com/luismmadeirac/dev-env/main/setup/macOS/macos-bootstrap.sh | bash
```

> ⚠️ **WARNING**: This bootstrap script makes extensive system changes including:
>
> - Modifying system preferences and settings
> - Removing default macOS applications
> - Installing specific applications and tools
> - Configuring custom keybindings and shortcuts
>
> **Do not run unless you understand and want these specific changes.**

## 💻 Dev Environment (Existing Setup)

The `dev-env.sh` script deploys personal configurations from the `env/` directory to your home directory. It handles dotfiles, XDG config files, and custom scripts.

### What Gets Deployed

- **Dotfiles** - `.zshrc`, `.zshrc_profile`, `.zshrc_alias`, `.zshrc_alias_scripts`, `.tmux-sessionizer`
- **XDG Configs** - `~/.config/` (aerospace, ghostty, nvim, tmux)
- **Scripts** - `~/.local/scripts/` (custom utilities)
- **XDG Migration** - Automatic migration of legacy dotfile locations

### Dev Environment Usage

```bash
# Show deployment plan (no changes)
./dev-env.sh --plan-only

# Deploy with confirmation prompt
./dev-env.sh

# Deploy automatically (no prompts)
./dev-env.sh --auto-approve

# Verbose logging
./dev-env.sh --verbose

# Use alias (after first deployment)
dev-env --plan-only
```

### Environment Variables

The following variables are automatically set:

```bash
DEV_ENV="$HOME/Developer/dev-env"  # Repository location
XDG_CONFIG_HOME="$HOME/.config"    # XDG config directory
XDG_STATE_HOME="$HOME/.local/state" # XDG state directory
```

## 📁 Repository Structure

```
.
├── dev-env.sh                    # Main dev environment deployment script
├── setup/
│   └── ubuntu/
│       └── bootstrap.sh          # Main bootstrap orchestration for ubuntu
│   └── macOS/
│       ├── prerequisites/        # Xcode CLI Tools, Homebrew
│       ├── apps/                 # Apps install
│       ├── dtd/                  # Personal
│       ├── os/                   # macOS system settings
│       └── macos-bootstrap.sh    # Main bootstrap orchestration for macOS
├── utils/                        # Bash framework utilities
│   ├── core.sh                   # Core configuration
│   ├── logging.sh                # Logging system
│   ├── file_ops.sh               # Safe file operations
│   ├── commands.sh               # Commands utils
│   └── step-runner.sh            # Setup step execution
├── env/                          # Personal configurations to deploy
│   ├── .config/                  # XDG config files
│   ├── .local/                   # Local scripts and resources
│   └── .*                        # Dotfiles (.zshrc, etc.)
├── docs/                         # Documentation
│   ├── dev-env/                  # Dev environment docs
│   ├── macOS/                    # macOS bootstrap docs
│   └── cheat-sheets/             # Tool cheat sheets
└── logs/                         # Runtime logs (gitignored)
```

## 📚 Documentation

### Core Documentation

- [Dev Environment Getting Started](docs/dev-env/Getting-Started.md) - Development environment setup guide
- [XDG Base Directory Setup](docs/dev-env/XDG-Setup.md) - XDG compliance and migration
- [macOS Bootstrap Guide](docs/macOS/README.md) - Full bootstrap process documentation
- [macOS Getting Started](docs/macOS/Getting-Started.md) - Quick start for macOS setup

### Cheat Sheets

- [Aerospace](docs/cheat-sheets/aerospace.md) - Window manager shortcuts
- [Git](docs/cheat-sheets/git.md) - Git commands and workflows
- [Neovim](docs/cheat-sheets/nvim.md) - Neovim shortcuts and config
- [tmux](docs/cheat-sheets/tmux.md) - tmux commands and shortcuts
- [Aliases](docs/cheat-sheets/alias.md) - Custom shell aliases

## 🎨 Customization

### Adding New Applications

Edit `setup/macOS/04-applications/install-apps.sh`:

```bash
BREW_PACKAGES=(
    htop
    zoxide
    your-package  # Add here
)

BREW_APPS=(
    raycast
    docker
    your-app  # Add here
)
```

### Modifying System Settings

Edit scripts in `setup/macOS/02-system/`:

```bash
# Example: setup/macOS/02-system/dock.sh
defaults write com.apple.dock tilesize -int 48
defaults write com.apple.dock autohide -bool true
```

## 🛠️ Framework Utilities

This repository includes a custom bash framework located in `utils/`:

- **core.sh** - Central configuration, paths, environment variables
- **logging.sh** - Structured logging with levels and colors
- **file_ops.sh** - Safe file operations with backups
- **commands.sh** - Command framework for setup steps
- **step-runner.sh** - Execution engine for bootstrap steps

### Using the Framework in Scripts

```bash
#!/usr/bin/env bash
set -euo pipefail

# Source utilities
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
UTILS_DIR="$(cd "$SCRIPT_DIR/../../utils" && pwd)"
source "$UTILS_DIR/core.sh"
source "$UTILS_DIR/logging.sh"

# Use logging
log_info "Starting installation..."
log_success "Installation complete!"
log_error "Something went wrong"
```

