# XDG Base Directory Setup

This repository automatically migrates your development environment to follow the [XDG Base Directory Specification](https://specifications.freedesktop.org/basedir-spec/latest/).

## What is XDG Base Directory?

The XDG Base Directory spec defines standard locations for:
- **Config files**: `~/.config/` (replaces dotfiles in `$HOME`)
- **State/data**: `~/.local/state/` (caches, history, logs)
- **User binaries**: `~/.local/bin/` (scripts and executables)

## Automatic Migration

When you run `./dev-env.sh`, it automatically migrates these directories:

### Config Directories
- `~/.nvm` → `~/.config/nvm`
- `~/.oh-my-zsh` → `~/.config/oh-my-zsh`
- `~/.vim` → `~/.config/vim`
- `~/.yarn` → `~/.config/yarn`
- `~/.npm` → `~/.config/npm`
- `~/.gitconfig` → `~/.config/git/config`

### State Files
- `~/.zsh_history` → `~/.local/state/zsh/history`
- `~/.zcompdump*` → `~/.local/state/zsh/zcompdump*`
- `~/.zsh_sessions/` → `~/.local/state/zsh/sessions/`

## Tool Configuration

```bash
# In .zshrc_profile:
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_STATE_HOME="$HOME/.local/state"
export NVM_DIR="$XDG_CONFIG_HOME/nvm"
export NPM_CONFIG_CACHE="$XDG_CONFIG_HOME/npm"
export YARN_CACHE_FOLDER="$XDG_CONFIG_HOME/yarn"
export VIM_HOME="$XDG_CONFIG_HOME/vim"
export ZSH="$XDG_CONFIG_HOME/oh-my-zsh"
export HISTFILE="$XDG_STATE_HOME/zsh/history"
```

```bash
# Backup and remove legacy directories
mkdir -p ~/backups/xdg-cleanup-$(date +%Y%m%d)
mv ~/.npm ~/.vim ~/backups/xdg-cleanup-$(date +%Y%m%d)/
```

## Useful Aliases

```bash
dev-env          # Run dev environment deployment
dev-env --help   # Show available options
sz               # Reload zsh configuration
de               # Jump to dev-env directory
```
