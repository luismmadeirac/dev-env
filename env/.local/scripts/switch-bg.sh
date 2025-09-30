#!/bin/bash

WALLPAPER_DIR="$HOME/.local/backgrounds"

if [ ! -d "$WALLPAPER_DIR" ]; then
    echo "dir not found"
    echo "  '$WALLPAPER_DIR'"
    exit 1
fi

declare -a wallpaper_paths

while IFS= read -r -d $'\0' file_path; do
    wallpaper_paths+=("$file_path")
done < <(find "$WALLPAPER_DIR" -maxdepth 1 -type f \( -iname \*.jpg -o -iname \*.jpeg -o -iname \*.png -o -iname \*.heic -o -iname \*.webp \) -print0 2>/dev/null)

if [ ${#wallpaper_paths[@]} -eq 0 ]; then
    echo "Error: No files in '$WALLPAPER_DIR'"
    find_command_used='find "$WALLPAPER_DIR" -maxdepth 1 -type f'
    exit 1
fi

declare -a wallpaper_names
for full_path in "${wallpaper_paths[@]}"; do
    wallpaper_names+=("$(basename "$full_path")")
done

PS3="Enter the number of the wallpaper to set (or 'q' to quit): "

select choice in "${wallpaper_names[@]}" "Quit"; do
    if [[ "$REPLY" == "q" || "$REPLY" == "Q" || "$choice" == "Quit" ]]; then
        echo "Exiting."
        break
    fi

    if [[ "$REPLY" =~ ^[0-9]+$ ]] && [ "$REPLY" -ge 1 ] && [ "$REPLY" -le ${#wallpaper_names[@]} ]; then
        chosen_index=$((REPLY - 1))
        chosen_path="${wallpaper_paths[$chosen_index]}"
        chosen_name="${wallpaper_names[$chosen_index]}"

        echo "You chose: $chosen_name"
        echo "Setting background to: $chosen_path"

        osascript -e "tell application \"System Events\" to tell every desktop to set picture to POSIX file \"$chosen_path\""

        if [ $? -eq 0 ]; then
            echo "Desktop background successfully set!"
        else
            # Use current date from system
            current_date=$(date)
            echo "Error setting desktop background via osascript (Attempted on: $current_date)."
        fi
        break
    else
        echo "Invalid choice '$REPLY'. Please enter a number from 1 to $((${#wallpaper_names[@]} + 1))."
    fi
done

exit 0
