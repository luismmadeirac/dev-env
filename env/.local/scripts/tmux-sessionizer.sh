#!/usr/bin/env bash

if [[ $# -eq 1 ]]; then
    selected=$1
else
    projects=(
        ~/Developer
        ~/Developer/dev-env
        ~/personal
        ~/work
        ~/.config
        ~/.local/scripts
    )

    selected_dirs=""
    for project in "${projects[@]}"; do
        if [[ -d "$project" ]]; then
            selected_dirs+="$project"$'\n'
        fi
    done

    find ~/Developer -mindepth 1 -maxdepth 2 -type d 2>/dev/null | head -20 >/tmp/tmux_dirs
    echo "$selected_dirs" >>/tmp/tmux_dirs

    selected=$(cat /tmp/tmux_dirs | sort -u | fzf --height=40% --reverse --prompt="Select project: ")
    rm -f /tmp/tmux_dirs
fi

if [[ -z $selected ]]; then
    exit 0
fi

selected_name=$(basename "$selected" | tr . _)
tmux_running=$(pgrep tmux)

# If not in tmux and tmux is not running, create new session
if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
    tmux new-session -s $selected_name -c $selected
    exit 0
fi

# If no tmux session, create it
if ! tmux has-session -t=$selected_name 2>/dev/null; then
    tmux new-session -d -s $selected_name -c $selected
fi

# Switch to the session
if [[ -z $TMUX ]]; then
    tmux attach-session -t $selected_name
else
    tmux switch-client -t $selected_name
fi
