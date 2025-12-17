#!/usr/bin/env bash

source "../../utils/logging.sh"
source "../../utils/script-analysis.sh"

log_info "Configuring Finder settings..."

finder_settings=(
    "QuitMenuItem -bool true|Enable Finder quit menu item"
    "DisableAllAnimations -bool true|Disable all animations"
    "ShowExternalHardDrivesOnDesktop -bool true|Show external drives on desktop"
    "ShowHardDrivesOnDesktop -bool true|Show hard drives on desktop"
    "ShowMountedServersOnDesktop -bool true|Show mounted servers on desktop"
    "ShowRemovableMediaOnDesktop -bool true|Show removable media on desktop"
    "AppleShowAllFiles -bool true|Show hidden files by default"
    "ShowStatusBar -bool true|Show status bar"
    "ShowPathbar -bool true|Show path bar"
    "_FXShowPosixPathInTitle -bool true|Show full POSIX path in title"
    "_FXSortFoldersFirst -bool true|Keep folders on top when sorting"
    "FXDefaultSearchScope -string SCcf|Search current folder by default"
    "FXEnableExtensionChangeWarning -bool false|Disable extension change warning"
    "FXPreferredViewStyle -string Nlsv|Use list view by default"
    "WarnOnEmptyTrash -bool false|Disable trash empty warning"
    "OpenWindowForNewRemovableDisk -bool true|Open window for new removable disk"
)

global_settings=(
    "com.apple.springing.enabled -bool true|Enable spring loading for directories"
    "com.apple.springing.delay -float 0|Remove spring loading delay"
)

desktopservices_settings=(
    "DSDontWriteNetworkStores -bool true|Avoid .DS_Store on network volumes"
    "DSDontWriteUSBStores -bool true|Avoid .DS_Store on USB volumes"
)

diskimages_settings=(
    "skip-verify -bool true|Disable disk image verification"
    "skip-verify-locked -bool true|Disable locked disk image verification"
    "skip-verify-remote -bool true|Disable remote disk image verification"
    "auto-open-ro-root -bool true|Auto-open read-only root volumes"
    "auto-open-rw-root -bool true|Auto-open read-write root volumes"
)

networkbrowser_settings=(
    "BrowseAllInterfaces -bool true|Enable AirDrop over Ethernet"
)

log_step "Applying ${#finder_settings[@]} Finder settings..."

for setting_info in "${finder_settings[@]}"; do
    setting="${setting_info%%|*}"
    description="${setting_info##*|}"
    apply_setting "com.apple.finder" "$setting" "$description"
done

log_step "Applying ${#global_settings[@]} global settings..."

for setting_info in "${global_settings[@]}"; do
    setting="${setting_info%%|*}"
    description="${setting_info##*|}"
    apply_global_setting "$setting" "$description"
done

log_step "Applying ${#desktopservices_settings[@]} desktop services settings..."

for setting_info in "${desktopservices_settings[@]}"; do
    setting="${setting_info%%|*}"
    description="${setting_info##*|}"
    apply_setting "com.apple.desktopservices" "$setting" "$description"
done

log_step "Applying ${#diskimages_settings[@]} disk image settings..."

for setting_info in "${diskimages_settings[@]}"; do
    setting="${setting_info%%|*}"
    description="${setting_info##*|}"
    apply_setting "com.apple.frameworks.diskimages" "$setting" "$description"
done

log_step "Applying ${#networkbrowser_settings[@]} network browser settings..."

for setting_info in "${networkbrowser_settings[@]}"; do
    setting="${setting_info%%|*}"
    description="${setting_info##*|}"
    apply_setting "com.apple.NetworkBrowser" "$setting" "$description"
done

log_step "Applying special file system settings..."

# Show the ~/Library folder
execute_command "chflags nohidden ~/Library && xattr -d com.apple.FinderInfo ~/Library 2>/dev/null || true" "Show ~/Library folder"

# Show the /Volumes folder (Apple Silicon compatible)
if [[ $IS_APPLE_SILICON == true ]]; then
    execute_command "sudo chflags nohidden /Volumes 2>/dev/null || true" "Show /Volumes folder"
else
    execute_command "sudo chflags nohidden /Volumes" "Show /Volumes folder"
fi

restart_service "Finder"

show_script_summary "Finder configuration"
