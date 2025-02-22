#!/usr/bin/env bash

dry_run="0"

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

execute() {
    log "execute: $@"
    if [[ $dry == "1" ]]; then
        return
    fi

    "$@"
}

log "--------- dev-env ---------"

cd $script_dir

copy_dir() {
    pushd $1
    to=$2
    dirs=$(find . -maxdepth 1 -mindepth 1 -type d)
    for dir in $dirs; do
        execute rm -rf $to/$dir
        execute cp -r $dir $to/$dir
    done
    popd
}

# copy_dir .config $XDG_CONFIG_HOME

copy_file() {
    from=$1
    to=$2
    name=$(basename $from)
    execute rm $to/$name
    execute cp $from $to/$name
}

# copy_file .specialrc $HOME

# update_files $DEV_ENV/env/.config $XDG_CONFIG_HOME
# update_files $DEV_ENV/env/.local $HOME/.local

# copy $DEV_ENV/tmux-sessionizer/tmux-sessionizer $HOME/.local/scripts/tmux-sessionizer
copy $DEV_ENV/env/.zsh_profile $HOME/.zsh_profile
copy $DEV_ENV/env/.zshrc $HOME/.zshrc
# copy $DEV_ENV/env/.tmux-sessionizer $HOME/.tmux-sessionizer
# copy $DEV_ENV/dev-env $HOME/.local/scripts/dev-env
