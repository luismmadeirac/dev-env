#!/usr/bin/env bash

source "../../utils/logging.sh"
source "../../utils/script-analysis.sh"

log_info "Configuring Terminal.app settings..."

appearance_settings=(
    "UseTransparency -bool true|Enable window transparency"
    "WindowAlpha -float 0.3|Set transparency level"
)

window_settings=(
    "StartupWindowSettings -dict-add columnCount -int 120|Set initial window width"
    "StartupWindowSettings -dict-add rowCount -int 120|Set initial window height"
)

scrollbar_settings=(
    "ScrollbarInfo -dict-add Visible -bool false|Hide scrollbar"
)

text_settings=(
    "NSFontSize -int 12|Set font size to 12pt"
    "AntiAliasing -bool true|Enable text antialiasing"
)

cursor_settings=(
    "CursorType -int 2|Set cursor to vertical bar"
    "CursorBlink -bool false|Disable cursor blinking"
)

sound_settings=(
    "Bell -bool true|Enable terminal bell"
    "VisualBell -bool false|Disable visual bell"
    "NotifyOnCompletion -int 0|Disable completion notifications"
)

tab_settings=(
    "TabViewType -int 1|Enable tab bar"
    "TabPosition -int 1|Set tabs to bottom"
)

shell_settings=(
    "ShellExitAction -int 1|Close on clean shell exit"
    "NewWindowWorkingDirectoryBehavior -int 2|Use custom working directory"
)

advanced_settings=(
    "SecureKeyboardEntry -bool true|Enable secure keyboard entry"
    "PromptOnClose -bool true|Prompt before closing with running processes"
    "SizeToFit -bool true|Auto-resize window to fit output"
    "ScrollbackLines -int 10000|Set scroll buffer to 10,000 lines"
    "RestoreWindowsState -bool false|Don't restore previous windows on startup"
)

log_step "Applying ${#appearance_settings[@]} appearance settings..."

for setting_info in "${appearance_settings[@]}"; do
    setting="${setting_info%%|*}"
    description="${setting_info##*|}"
    apply_setting "com.apple.Terminal" "$setting" "$description"
done

log_step "Applying ${#window_settings[@]} window settings..."

for setting_info in "${window_settings[@]}"; do
    setting="${setting_info%%|*}"
    description="${setting_info##*|}"
    apply_setting "com.apple.Terminal" "$setting" "$description"
done

log_step "Applying ${#scrollbar_settings[@]} scrollbar settings..."

for setting_info in "${scrollbar_settings[@]}"; do
    setting="${setting_info%%|*}"
    description="${setting_info##*|}"
    apply_setting "com.apple.Terminal" "$setting" "$description"
done

log_step "Applying ${#text_settings[@]} text settings..."

for setting_info in "${text_settings[@]}"; do
    setting="${setting_info%%|*}"
    description="${setting_info##*|}"
    apply_setting "com.apple.Terminal" "$setting" "$description"
done

log_step "Applying ${#cursor_settings[@]} cursor settings..."

for setting_info in "${cursor_settings[@]}"; do
    setting="${setting_info%%|*}"
    description="${setting_info##*|}"
    apply_setting "com.apple.Terminal" "$setting" "$description"
done

log_step "Applying ${#sound_settings[@]} sound settings..."

for setting_info in "${sound_settings[@]}"; do
    setting="${setting_info%%|*}"
    description="${setting_info##*|}"
    apply_setting "com.apple.Terminal" "$setting" "$description"
done

log_step "Applying ${#tab_settings[@]} tab settings..."

for setting_info in "${tab_settings[@]}"; do
    setting="${setting_info%%|*}"
    description="${setting_info##*|}"
    apply_setting "com.apple.Terminal" "$setting" "$description"
done

log_step "Applying ${#shell_settings[@]} shell settings..."

for setting_info in "${shell_settings[@]}"; do
    setting="${setting_info%%|*}"
    description="${setting_info##*|}"
    apply_setting "com.apple.Terminal" "$setting" "$description"
done

log_step "Applying ${#advanced_settings[@]} advanced settings..."

for setting_info in "${advanced_settings[@]}"; do
    setting="${setting_info%%|*}"
    description="${setting_info##*|}"
    apply_setting "com.apple.Terminal" "$setting" "$description"
done

# Restart SystemUIServer to apply changes (Apple Silicon compatible)
if [[ $IS_APPLE_SILICON == true ]]; then
    execute_command "killall SystemUIServer 2>/dev/null || true" "Restart SystemUIServer"
else
    restart_service "SystemUIServer"
fi

show_script_summary "Terminal configuration"
