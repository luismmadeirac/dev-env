#!/usr/bin/env bash

echo "------------------- Finder  ---------------------"

# Enable Command Tracking

set -x

finder_settings=(
    "QuitMenuItem -bool true"
    "DisableAllAnimations -bool true"

    # Show icons for hard drives, servers, and removable media on the desktop
    "ShowExternalHardDrivesOnDesktop -bool true"
    "ShowHardDrivesOnDesktop -bool true"
    "ShowMountedServersOnDesktop -bool true"
    "ShowRemovableMediaOnDesktop -bool true"

    # Finder: show hidden files by default
    "AppleShowAllFiles -bool true"
    # Finder: show status bar
    "ShowStatusBar -bool true"
    # Finder: show path bar
    "ShowPathbar -bool true"

    # Display full POSIX path as Finder window title
    "_FXShowPosixPathInTitle -bool true"
    # Keep folders on top when sorting by name
    "_FXSortFoldersFirst -bool true"
    # When performing a search, search the current folder by default
    "FXDefaultSearchScope -string "SCcf""
    # Disable the warning when changing a file extension
    "FXEnableExtensionChangeWarning -bool false"
)

for setting in "${finder_settings[@]}"; do
    defaults write com.apple.finder $setting
done

# Enable spring loading for directories
defaults write NSGlobalDomain com.apple.springing.enabled -bool true

# Remove the spring loading delay for directories
defaults write NSGlobalDomain com.apple.springing.delay -float 0

# Avoid creating .DS_Store files on network or USB volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Disable disk image verification
defaults write com.apple.frameworks.diskimages skip-verify -bool true
defaults write com.apple.frameworks.diskimages skip-verify-locked -bool true
defaults write com.apple.frameworks.diskimages skip-verify-remote -bool true

# Automatically open a new Finder window when a volume is mounted
defaults write com.apple.frameworks.diskimages auto-open-ro-root -bool true
defaults write com.apple.frameworks.diskimages auto-open-rw-root -bool true
defaults write com.apple.finder OpenWindowForNewRemovableDisk -bool true

# Use list view in all Finder windows by default
# Four-letter codes for the other view modes: `icnv`, `clmv`, `glyv`
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# Disable the warning before emptying the Trash
defaults write com.apple.finder WarnOnEmptyTrash -bool false

# Enable AirDrop over Ethernet and on unsupported Macs running Lion
defaults write com.apple.NetworkBrowser BrowseAllInterfaces -bool true

# Show the ~/Library folder
chflags nohidden ~/Library && xattr -d com.apple.FinderInfo ~/Library

# Show the /Volumes folder
sudo chflags nohidden /Volumes

killall Finder

set +x
