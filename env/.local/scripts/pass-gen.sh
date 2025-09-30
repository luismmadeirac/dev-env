#!/bin/bash

set -euo pipefail

readonly DEFAULT_LENGTH=32
readonly MIN_LENGTH=16
readonly MAX_LENGTH=128
readonly UPPER="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
readonly LOWER="abcdefghijklmnopqrstuvwxyz"
readonly NUMBERS="0123456789"
readonly SPECIAL='!@#$%^&*()_+-=[]{}|;:,.<>?'
readonly ALL_CHARS="${UPPER}${LOWER}${NUMBERS}${SPECIAL}"

usage() {
    echo "Usage: $0 [length]" >&2
    echo "length: Password length (default: $DEFAULT_LENGTH, min: $MIN_LENGTH, max: $MAX_LENGTH)" >&2
    echo "Example: $0 20" >&2
    exit 1
}

secure_random_index() {
    local max_index=$1
    local random_byte
    random_byte=$(od -An -t u1 -N1 </dev/urandom)
    echo $((random_byte % max_index))
}

password=""

char_sets=("$UPPER" "$LOWER" "$NUMBERS" "$SPECIAL")
for set in "${char_sets[@]}"; do
    len=${#set}
    idx=$(secure_random_index "$len")
    password+="${set:$idx:1}"
done

remaining_length=$((DEFAULT_LENGTH - ${#password}))
for ((i = 0; i < remaining_length; i++)); do
    len=${#ALL_CHARS}
    idx=$(secure_random_index "$len")
    password+="${ALL_CHARS:$idx:1}"
done

shuffled_password=""
temp_pass="$password"
for ((i = DEFAULT_LENGTH; i > 0; i--)); do
    len=${#temp_pass}
    idx=$(secure_random_index "$len")
    shuffled_password+="${temp_pass:$idx:1}"
    temp_pass="${temp_pass:0:$idx}${temp_pass:$((idx + 1))}"
done

PASSWORD="$shuffled_password"

CLIPBOARD_CMD=""
if command -v pbcopy >/dev/null 2>&1; then
    echo -n "$PASSWORD" | pbcopy
    CLIPBOARD_CMD="pbcopy (macOS)"
elif command -v xclip >/dev/null 2>&1; then
    echo -n "$PASSWORD" | xclip -selection clipboard
    CLIPBOARD_CMD="xclip (Linux)"
elif command -v xsel >/dev/null 2>&1; then
    echo -n "$PASSWORD" | xsel --clipboard --input
    CLIPBOARD_CMD="xsel (Linux)"
fi

if [ -n "$CLIPBOARD_CMD" ]; then
    echo "✓ Secure ${DEFAULT_LENGTH}-character password generated and copied to clipboard." >&2
    echo "✓ Used clipboard command: ${CLIPBOARD_CMD}" >&2
else
    echo "pbcopy, xclip, xsel or clip utils not found." >&2
fi

unset PASSWORD
