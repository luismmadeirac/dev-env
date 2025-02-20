#!/usr/bin/env bash

echo "------------------- Terminal  ---------------------"

# Enabale Command Tracking
set -x

screenshoot_settings=(
)

terminal_settings=(
    # ----------------- Appearance-----------------
    # Enable window transparency
    "UseTransparency -bool true"

    # Set transparency level (0.0 to 1.0, where 1.0 is fully opaque)
    "WindowAlpha -float 0.3"

    # Set initial window width (number of text columns)
    "StartupWindowSettings -dict-add columnCount -int 120"

    # Set initial window height (number of text rows)
    "StartupWindowSettings -dict-add rowCount -int 120"

    # Set window title format (%d = directory, %n = shell name)
    # "TitleFormat -string \"%d — %n\""

    # Show scrollbar
    "ScrollbarInfo -dict-add Visible -bool false"

    # ----------------- Text & Cursor -----------------
    # Set font size in points
    "NSFontSize -int 12"

    # Set cursor type (0=block, 1=underline, 2=vertical bar)
    "CursorType -int 2"

    # Enable cursor blinking
    "CursorBlink -bool false"

    # Enable text antialiasing (smoother text)
    "AntiAliasing -bool true"

    # ----------------- Sound & Notifications -----------------
    # Disable terminal bell sound
    "Bell -bool true"

    # Enable visual bell (screen flash instead of sound)
    "VisualBell -bool false"

    # Set notification behavior (0=never, 1=when in background, 2=always)
    "NotifyOnCompletion -int 0"

    # ----------------- Tabs  -----------------
    # Enable tab bar (0=disabled, 1=enabled)
    "TabViewType -int 1"

    # Set tab position (0=top, 1=bottom)
    "TabPosition -int 1"

    # ----------------- Shell Behavior  -----------------
    # Close window behavior on shell exit (0=never, 1=clean exit, 2=always)
    "ShellExitAction -int 1"

    # Working directory behavior (1=default login dir, 2=custom dir, 3=same as previous)
    "NewWindowWorkingDirectoryBehavior -int 2"

    # ----------------- Advanced  -----------------
    # Enable secure keyboard entry (prevents other apps from capturing keystrokes)
    "SecureKeyboardEntry -bool true"

    # Prompt before closing window with running processes
    "PromptOnClose -bool true"

    # Automatically resize window to fit terminal output
    "SizeToFit -bool true"

    # Set scroll buffer size (number of lines to keep in history)
    "ScrollbackLines -int 10000"

    # Don't restore previous window groups on startup
    "RestoreWindowsState -bool false"
)

# Apply
for setting in "${terminal_settings[@]}"; do
    defaults write com.apple.Terminal $setting
done

# Restart SystemUIServer to apply changes
killall SystemUIServer

set +x
