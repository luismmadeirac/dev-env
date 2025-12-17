#!/usr/bin/env bash

source "../../utils/logging.sh"
source "../../utils/script-analysis.sh"

log_info "Configuring UI and system interface settings..."

ui_settings=(
    "NSUseAnimatedFocusRing -bool false|Disable focus ring animation"
    "NSToolbarTitleViewRolloverDelay -float 0|Remove toolbar title rollover delay"
    "NSAutomaticCapitalizationEnabled -bool false|Disable automatic capitalization"
    "NSAutomaticDashSubstitutionEnabled -bool false|Disable smart dashes"
    "NSAutomaticPeriodSubstitutionEnabled -bool false|Disable automatic period substitution"
    "NSAutomaticQuoteSubstitutionEnabled -bool false|Disable smart quotes"
    "NSAutomaticSpellingCorrectionEnabled -bool false|Disable auto-correct"
)

login_settings=(
    "AdminHostInfo HostName|Show system info in login window"
)

sound_settings=(
    "SystemAudioVolume|Disable boot sound effects"
)

log_step "Applying ${#ui_settings[@]} UI settings..."

for setting_info in "${ui_settings[@]}"; do
    setting="${setting_info%%|*}"
    description="${setting_info##*|}"
    apply_global_setting "$setting" "$description"
done

log_step "Applying login window settings..."

for setting_info in "${login_settings[@]}"; do
    setting="${setting_info%%|*}"
    description="${setting_info##*|}"
    apply_setting "/Library/Preferences/com.apple.loginwindow" "$setting" "$description"
done

log_step "Applying system sound settings..."

# Disable boot sound (Apple Silicon compatible)
if [[ $IS_APPLE_SILICON == true ]]; then
    execute_command 'sudo nvram SystemAudioVolume=" " 2>/dev/null || true' "Disable boot sound effects"
else
    execute_command 'sudo nvram SystemAudioVolume=" "' "Disable boot sound effects"
fi

log_step "Applying Finder display settings..."

# This was duplicated in the original UI script - fixing the logic error
apply_setting "com.apple.finder" "AppleShowAllFiles -bool true" "Display all hidden files"

show_script_summary "UI configuration"
