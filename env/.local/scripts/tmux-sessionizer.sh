#!/usr/bin/env bash

if [[ $# -eq 1 ]]; then
    selected=$1
else
    projects=(
        ~/Developer
        ~/personal
        ~/work
        ~/.config
        ~/.local/scripts
    )

    >/tmp/tmux_dirs

    for project in "${projects[@]}"; do
        if [[ -d "$project" ]]; then
            echo "$project" >>/tmp/tmux_dirs
            find "$project" -mindepth 1 -maxdepth 2 -type d 2>/dev/null >>/tmp/tmux_dirs
        fi
    done

    selected=$(cat /tmp/tmux_dirs | sort -u | fzf --height=40% --reverse --prompt="Select project: ")
    rm -f /tmp/tmux_dirs
fi

if [[ -z $selected ]]; then
    exit 0
fi

selected_name=$(basename "$selected" | tr . _)
tmux_running=$(pgrep tmux)

if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
    tmux new-session -s $selected_name -c $selected
    exit 0
fi

if ! tmux has-session -t=$selected_name 2>/dev/null; then
    # IaC Mode
    if [[ $selected_name =~ ^(infra|iac|cloud) ]]; then
        tmux new-session -d -s $selected_name -n vim -c $selected
        tmux new-window -t $selected_name -n k9s -c $selected
        tmux new-window -t $selected_name -n runners -c $selected
        tmux new-window -t $selected_name -n git -c $selected
    else
        # Dev mode
        tmux new-session -d -s $selected_name -n vim -c $selected
        tmux new-window -t $selected_name -n runners -c $selected
        tmux new-window -t $selected_name -n git -c $selected
        tmux new-window -t $selected_name -n term -c $selected
    fi

    tmux select-window -t $selected_name:1
fi

if [[ -z $TMUX ]]; then
    tmux attach-session -t $selected_name
else
    tmux switch-client -t $selected_name
fi
