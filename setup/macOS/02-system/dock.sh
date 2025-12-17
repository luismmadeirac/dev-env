#!/usr/bin/env bash

source "../../utils/logging.sh"
source "../../utils/script-analysis.sh"

log_info "Configuring Dock settings..."

dock_settings=(
    "autohide -bool true|Auto-hide Dock"
    "autohide-delay -float 0|Remove auto-hide delay"
    "tilesize -int 25|Set icon size to 25px"
    "orientation -string right|Move Dock to right side"
    "show-recents -bool false|Disable recent apps"
    "magnification -bool false|Disable magnification"
)

successful_settings=0
total_settings=${#dock_settings[@]}

log_step "Applying ${total_settings} Dock settings..."

for setting_info in "${dock_settings[@]}"; do
    setting="${setting_info%%|*}"
    description="${setting_info##*|}"

    log_info "Setting: $description"

    if defaults write com.apple.dock $setting; then
        log_success "✓ $description"
        ((successful_settings++))
    else
        log_error "✗ Failed: $description"
    fi
done

log_step "Restarting Dock to apply changes..."
if killall Dock 2>/dev/null; then
    log_success "Dock restarted successfully"
else
    log_warning "Failed to restart Dock (it may restart automatically)"
fi

if [[ $successful_settings -eq $total_settings ]]; then
    log_success "All Dock settings applied successfully ($successful_settings/$total_settings)"
else
    log_warning "Some Dock settings failed ($successful_settings/$total_settings applied)"
fi

log_info "Dock configuration completed!"
