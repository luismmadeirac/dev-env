#!/usr/bin/env bash

source "../../utils/logging.sh"
source "../../utils/script-analysis.sh"

log_info "Configuring screenshot settings..."

# Ensure Screenshots directory exists
screenshots_dir="$HOME/Documents/ScreenShots"
execute_command "mkdir -p \"$screenshots_dir\"" "Create screenshots directory"

screenshot_settings=(
    "location -string \"$screenshots_dir\"|Set screenshots location to ~/Documents/ScreenShots/"
    "type -string png|Set screenshot format to PNG"
    "disable-shadow -bool true|Disable shadow in screenshots"
)

log_step "Applying ${#screenshot_settings[@]} screenshot settings..."

for setting_info in "${screenshot_settings[@]}"; do
    setting="${setting_info%%|*}"
    description="${setting_info##*|}"
    apply_setting "com.apple.screencapture" "$setting" "$description"
done

restart_service "SystemUIServer"

show_script_summary "Screenshot configuration"
