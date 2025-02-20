#!/usr/bin/env bash

script_dir=$(cd $(dirname "${BASH_SOURCE[0]}") && pwd)
filter=""
requested_dry="0"

cd $script_dir
scripts=$(find ./scripts -maxdepth 1 -mindepth 1 -type f)

while [[ $# > 0 ]]; do
    if [[ "$1" == "--dry" ]]; then
        requested_dry="1"
    else
        filter="$1"
    fi
    shift
done

log() {
    if [[ $1 == "DRY" ]]; then
        echo "[DRY_RUN]: ${@:2}"
    else
        echo "${@:1}"
    fi
}

execute() {
    log "$1" "execute: ${@:2}"
    if [[ $1 == "DRY" ]]; then
        return
    fi
    "${@:2}"
}

# Always do a dry run first
log "DRY" "run: filter=$filter"
for script in $scripts; do
    if echo "$script" | grep -qv "$filter"; then
        log "DRY" "filtered: $filter -- $script"
        continue
    fi
    log "DRY" "running script: $script"
    # Don't actually execute in dry run
done

# Ask for confirmation if not explicitly in dry mode
if [[ $requested_dry != "1" ]]; then
    echo ""
    echo "Dry run completed. Do you want to proceed with actual execution? (y/n)"
    read -r response
    if [[ ! "$response" =~ ^[Yy]$ ]]; then
        echo "Execution canceled."
        exit 0
    fi

    # Execute for real
    log "run: filter=$filter"
    for script in $scripts; do
        if echo "$script" | grep -qv "$filter"; then
            log "filtered: $filter -- $script"
            continue
        fi
        log "running script: $script"
        execute "REAL" ./$script
    done
else
    echo "Dry run completed. No actual execution requested."
fi
