#!/bin/bash

# Source dependencies
source "$(dirname "${BASH_SOURCE[0]}")/colors.sh"

ask_yes_no() {
    local prompt="$1"
    local default="${2:-n}" # Default to 'n' if not specified

    if [[ "$default" == "y" ]]; then
        local prompt_suffix="[Y/n]"
    else
        local prompt_suffix="[y/N]"
    fi

    while true; do
        read -p "${prompt} ${prompt_suffix}: " choice

        # Use default if no input
        if [[ -z "$choice" ]]; then
            choice="$default"
        fi

        case "$choice" in
        [yY] | [yY][eE][sS])
            return 0
            ;;
        [nN] | [nN][oO])
            return 1
            ;;
        *)
            echo "${COLOR_WARNING}Please answer yes (y) or no (n).${RESET}"
            ;;
        esac
    done
}

ask_choice() {
    local prompt="$1"
    shift
    local options=("$@")

    echo "$prompt"
    for i in "${!options[@]}"; do
        echo "  $((i + 1))) ${options[$i]}"
    done

    while true; do
        read -p "Choose an option [1-${#options[@]}]: " choice

        if [[ "$choice" =~ ^[0-9]+$ ]] && [[ "$choice" -ge 1 && "$choice" -le "${#options[@]}" ]]; then
            return $((choice - 1))
        else
            echo "${COLOR_WARNING}Please enter a number between 1 and ${#options[@]}.${RESET}"
        fi
    done
}

confirm_warning() {
    local message="$1"
    local confirm_text="${2:-proceed}"

    echo "${COLOR_WARNING}⚠️  WARNING: $message${RESET}"
    echo ""
    ask_yes_no "Are you sure you want to $confirm_text?"
}

pause_for_user() {
    local message="${1:-Press any key to continue...}"
    echo "${COLOR_INFO}$message${RESET}"
    read -n 1 -s -r
}

show_menu() {
    local title="$1"
    shift
    local options=("$@")

    echo "${COLOR_INFO}$title${RESET}"
    echo ""

    ask_choice "Please select an option:" "${options[@]}"
    return $?
}
