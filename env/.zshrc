
# Load zsh profile early for XDG variables
source ~/.zshrc_profile

# path to zsh (XDG compliant)
export ZSH="$XDG_CONFIG_HOME/oh-my-zsh"

# Set custom compdump location before oh-my-zsh loads
export ZSH_COMPDUMP="$ZSH_STATE_DIR/zcompdump"

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Plugins
plugins=(git asdf)

source $ZSH/oh-my-zsh.sh

source ~/.zshrc_alias
source ~/.zshrc_alias_scripts

GOPATH=$HOME/go  PATH=$PATH:/usr/local/go/bin:$GOPATH/bin

export NVM_DIR="$XDG_CONFIG_HOME/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

export PNPM_HOME="$HOME/.local/shared/pnpm"
export PATH="$PNPM_HOME:$PATH"
export PATH="/opt/homebrew/bin:$PATH"

