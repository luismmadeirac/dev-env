#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
UTILS_DIR="$(cd "$SCRIPT_DIR/../../../utils" && pwd)"

[[ -z "$CORE_CONFIG_LOADED" ]] && source "$UTILS_DIR/core.sh"

if ! declare -f source_util >/dev/null; then
    source_util() {
        local util_name="$1"
        source "$UTILS_DIR/${util_name}.sh"
    }
fi

source_util "colors"
source_util "logging"
source_util "file_ops"

ensure_directory "$PERSONAL_DIR"
ensure_directory "$DEVELOPER_DIR"
ensure_directory "$DEV_ENV_DIR"
ensure_directory "$WORK_DIR"
ensure_directory "$VAULTS_DIR"
ensure_directory "$HOME/Archive"
