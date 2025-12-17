# Dev Environment - Getting Started

This guide walks you through setting up and using the development environment deployment system.

## Prerequisites

Before running the dev-env script, ensure you have:

- **Git** - For cloning the repository
- **Zsh** - Default shell on macOS (recommended)
- **Repository Cloned** - This repository at `~/Developer/dev-env` (or custom location)

## First-Time Setup

### 1. Clone the Repository

```bash
# Clone to the default location
cd ~/$HOME/Developer/dev-env & git clone https://github.com/luismmadeirac/dev-env.git ~/Developer/dev-env
cd ~/Developer/dev-env
```

### 2. Review the Deployment Plan

Before making any changes, review what will be deployed:

```bash
./dev-env.sh --plan-only
```

### 3. Deploy Your Configuration

Run the deployment interactively:

```bash
./dev-env.sh
```

Or automatically without prompts:

```bash
./dev-env.sh --auto-approve
```

### 4. Reload Your Shell

After deployment, reload your shell configuration:

```bash
source ~/.zshrc
```

### 5. Verify Installation

Check that everything is working:

```bash
# Test the dev-env alias
dev-env --help

# Check XDG directories
ls ~/.config
ls ~/.local/state

# Verify environment variables
echo $DEV_ENV
echo $XDG_CONFIG_HOME
```

## What Gets Deployed

### Dotfiles (Root Level)

These files are copied from `env/` to your `$HOME`:

```
.zshrc                # Main Zsh configuration
.zshrc_profile        # Environment variables and XDG paths
.zshrc_alias          # Shell aliases
.zshrc_alias_scripts  # Script-based aliases
.tmux-sessionizer     # Tmux sessionizer configuration
```

### XDG Config Files

These directories are synced from `env/.config/` to `~/.config/`:

```
~/.config/aerospace/  # Window manager configuration
~/.config/ghostty/    # Terminal emulator configuration
~/.config/nvim/       # Neovim configuration
~/.config/tmux/       # Tmux configuration
```

### Custom Scripts

Scripts from `env/.local/scripts/` are copied to `~/.local/scripts/`:

```
~/.local/scripts/dev-env.sh         # The dev-env script itself
~/.local/scripts/tmux-sessionizer.sh
~/.local/scripts/batman.sh
~/.local/scripts/bg-black.sh
~/.local/scripts/dev-tooling.sh
~/.local/scripts/switch-bg.sh
```

### Backgrounds

Wallpaper files from `env/.local/backgrounds/` are copied to `~/.local/backgrounds/`.

## XDG Migration

The script automatically migrates legacy dotfile locations to XDG-compliant paths:

### Config Directories

```
~/.nvm        ’ ~/.config/nvm
~/.oh-my-zsh  ’ ~/.config/oh-my-zsh
~/.vim        ’ ~/.config/vim
~/.yarn       ’ ~/.config/yarn
~/.npm        ’ ~/.config/npm
~/.gitconfig  ’ ~/.config/git/config
```

### State Files

```
~/.zsh_history    ’ ~/.local/state/zsh/history
~/.zcompdump*     ’ ~/.local/state/zsh/zcompdump*
~/.zsh_sessions/  ’ ~/.local/state/zsh/sessions/
```

Migration only occurs if:

1. The source exists
2. The destination doesn't exist
3. The migration hasn't been completed before

## Usage

### Command Options

```bash
# Show deployment plan (no changes)
./dev-env.sh --plan-only

# Deploy with confirmation prompt
./dev-env.sh

# Deploy without confirmation
./dev-env.sh --auto-approve

# Enable verbose logging
./dev-env.sh --verbose

# Show help
./dev-env.sh --help
```

### Using the Alias

After first deployment, use the `dev-env` alias:

```bash
dev-env --plan-only
dev-env --auto-approve
```

The alias works from any directory because it uses the `$DEV_ENV` environment variable.
# Safety Features

### Automatic Backups

Before modifying any file, a timestamped backup is created:

```
~/.zshrc ’ ~/.zshrc.backup.20250930_123456
```

Backups are stored in the same directory as the original file.

### Change Detection

The script only updates files that have actually changed. If a file's content is identical, it's skipped.

### Dry Run Mode

Use `--plan-only` to see exactly what would change without applying any modifications.

### Logging

All operations are logged to `logs/` directory with session IDs for tracking.

## Environment Variables

These variables are set in `.zshrc_profile` and should be sourced early:

```bash
# Repository location
export DEV_ENV="$HOME/Developer/dev-env"

# XDG Base Directory paths
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"

# Tool-specific XDG paths
export NVM_DIR="$XDG_CONFIG_HOME/nvm"
export NPM_CONFIG_CACHE="$XDG_CONFIG_HOME/npm"
export YARN_CACHE_FOLDER="$XDG_CONFIG_HOME/yarn"
export VIM_HOME="$XDG_CONFIG_HOME/vim"
export ZSH="$XDG_CONFIG_HOME/oh-my-zsh"
export HISTFILE="$XDG_STATE_HOME/zsh/history"

# Zsh state directory for compdump files
export ZSH_STATE_DIR="$XDG_STATE_HOME/zsh"
```

## Troubleshooting

### dev-env alias not found

**Problem**: `command not found: dev-env`

**Solution**:
1. Make sure you've deployed at least once: `./dev-env.sh`
2. Reload your shell: `source ~/.zshrc`
3. Check that `DEV_ENV` is set: `echo $DEV_ENV`

### Changes not visible after deployment

**Problem**: Changes deployed but not taking effect

**Solution**:
1. Reload zsh: `source ~/.zshrc` or open a new terminal
2. For Neovim: Restart Neovim
3. For tmux: Reload config: `tmux source-file ~/.config/tmux/tmux.conf`

### XDG migration failed

**Problem**: Legacy directories still in `$HOME`

**Solution**:
1. Check if destination already exists: `ls -la ~/.config/nvm`
2. Manually move if safe: `mv ~/.nvm ~/.config/nvm`
3. Update paths in shell config
4. Re-run dev-env: `dev-env --auto-approve`

### Permission denied errors

**Problem**: Cannot create files or directories

**Solution**:
1. Check directory permissions: `ls -la ~/`
2. Ensure you own the directories: `ls -ld ~/.config ~/.local`
3. Fix ownership if needed: `sudo chown -R $USER:staff ~/.config ~/.local`

### Script cannot find utils

**Problem**: `utils/core.sh: No such file or directory`

**Solution**:
1. Ensure `DEV_ENV` is set correctly: `echo $DEV_ENV`
2. Check repository is complete: `ls $DEV_ENV/utils/`
3. Re-clone if necessary

## Next Steps

- Read [XDG Setup Guide](XDG-Setup.md) for detailed XDG information
- Explore [Cheat Sheets](../cheat-sheets/) for tool-specific shortcuts
- Check [Bootstrap Guide](../macOS/README.md) for full system setup

## Getting Help

- Check logs: `ls -l ~/Developer/dev-env/logs/`
- View recent log: `cat ~/Developer/dev-env/logs/latest.log`
- Run with verbose mode: `dev-env --verbose`
