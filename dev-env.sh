#!/usr/bin/env bash

dry_run="0"

DEV_ENV="$HOME/personal/dev"

if [ -z "$XDG_CONFIG_HOME" ]; then
  echo "no xdg config hom"
  echo "using ~/.config"
  XDG_CONFIG_HOME=$HOME/.config
fi

if [ -z "$DEV_ENV" ]; then
  echo "env var DEV_ENV needs to be present"
  exit 1
fi

if [[ $1 == "--dry" ]]; then
  dry_run="1"
fi

log() {
  if [[ $dry == "1" ]]; then
    echo "[DRY_RUN]: $@"
  else
    echo "$@"
  fi
}

log "env: $DEV_ENV"
log "------------------ dev-env ------------------"
log ""

update_files() {
  log "copying over files from: $1"
  pushd $1 &>/dev/null
  (
    configs=$(find . -mindepth 1 -maxdepth 1 -type d)
    for c in $configs; do
      directory=${2%/}/${c#./}
      log "    removing: rm -rf $directory"

      if [[ $dry_run == "0" ]]; then
        rm -rf $directory
      fi

      log "    copying env: cp $c $2"
      if [[ $dry_run == "0" ]]; then
        cp -r ./$c $2
      fi
    done

  )
  popd &>/dev/null
}

copy() {
  log "removing: $2"
  if [[ $dry_run == "0" ]]; then
    rm $2
  fi
  log "copying: $1 to $2"
  if [[ $dry_run == "0" ]]; then
    cp $1 $2
  fi
}

# Essentially all the contents in here would be already in personal/dev becasue of the git clone
# So the update_files woudl take the contents in personal/dev inton $HOME/ becoming $HOME/.local/scripts
# ZSH alias will the clal this scripts in that location

update_files $DEV_ENV/env/.config $XDG_CONFIG_HOME
update_files $DEV_ENV/env/.local $HOME/.local

copy $DEV_ENV/dev-env.sh $HOME/.local/scripts

copy $DEV_ENV/env/.zsh_profile $HOME/.zsh_profile
copy $DEV_ENV/env/.zsh_alias $HOME/.zsh_alias
copy $DEV_ENV/env/.zshrc $HOME/.zshrc
