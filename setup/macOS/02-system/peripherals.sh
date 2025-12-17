#!/usr/bin/env bash

source "../../utils/logging.sh"
source "../../utils/script-analysis.sh"

log_info "Configuring trackpad, mouse, and keyboard settings..."

trackpad_settings=(
    "com.apple.trackpad.scaling 9|Set trackpad to faster speed"
    "com.apple.mouse.scaling 2.5|Set mouse to faster speed"
)

bluetooth_settings=(
    "Apple Bitpool Min (editable) -int 40|Increase Bluetooth audio quality"
)

keyboard_settings=(
    "AppleKeyboardUIMode -int 3|Enable full keyboard access"
    "KeyRepeat -int 1|Set fast key repeat rate"
    "InitialKeyRepeat -int 10|Set fast initial key repeat delay"
)

log_step "Applying ${#trackpad_settings[@]} trackpad and mouse settings..."

for setting_info in "${trackpad_settings[@]}"; do
    setting="${setting_info%%|*}"
    description="${setting_info##*|}"
    apply_global_setting "$setting" "$description"
done

log_step "Applying ${#bluetooth_settings[@]} Bluetooth settings..."

for setting_info in "${bluetooth_settings[@]}"; do
    setting="${setting_info%%|*}"
    description="${setting_info##*|}"
    apply_setting "com.apple.BluetoothAudioAgent" "$setting" "$description"
done

log_step "Applying ${#keyboard_settings[@]} keyboard settings..."

for setting_info in "${keyboard_settings[@]}"; do
    setting="${setting_info%%|*}"
    description="${setting_info##*|}"
    apply_global_setting "$setting" "$description"
done

show_script_summary "Peripherals configuration"
