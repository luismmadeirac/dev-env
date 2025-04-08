#!/bin/bash

# --- Configuration ---
# Set the directory containing your personal wallpaper images.
WALLPAPER_DIR="$HOME/personal/dev/backgrounds"
# --- End Configuration ---

# --- Check if the specified directory exists ---
if [ ! -d "$WALLPAPER_DIR" ]; then
  echo "Error: Your wallpaper directory was not found at:"
  echo "  '$WALLPAPER_DIR'"
  echo "Please make sure this directory exists and the path is correct in the script."
  exit 1
fi

# --- Find wallpaper files (Bash 3 compatible method) ---
echo "Looking for images in: $WALLPAPER_DIR"
declare -a wallpaper_paths # Declare the array

# Use a while loop with process substitution to read NULL-delimited filenames from find
# This is compatible with Bash 3.x found on macOS by default
while IFS= read -r -d $'\0' file_path; do
    # Add each found path to the array
    wallpaper_paths+=("$file_path")
done < <(find "$WALLPAPER_DIR" -maxdepth 1 -type f \( -iname \*.jpg -o -iname \*.jpeg -o -iname \*.png -o -iname \*.heic -o -iname \*.webp \) -print0 2>/dev/null)
# Important options for find:
# -maxdepth 1: Remove this part if your images are in subfolders you want to include.
# -print0:     Crucial for handling filenames with spaces/special chars (used with read -d $'\0').

# --- Check if any wallpapers were found ---
# This check runs AFTER the loop has attempted to populate the array
if [ ${#wallpaper_paths[@]} -eq 0 ]; then
  echo "Error: No suitable image files (.jpg, .jpeg, .png, .heic, .webp) found directly in '$WALLPAPER_DIR'"
  # Check if find command likely included maxdepth (simple string check)
  find_command_used='find "$WALLPAPER_DIR" -maxdepth 1 -type f' # Reflects the command in the loop
  if grep -q -- '-maxdepth 1' <<< "$find_command_used"; then
      echo "Tip: If your images ARE in subfolders within that directory,"
      echo "     edit this script and remove '-maxdepth 1' from the line starting with 'done < <(find...)'."
  fi
  exit 1
fi

# --- Create an array of just filenames for the menu display ---
# (This part remains the same)
declare -a wallpaper_names
for full_path in "${wallpaper_paths[@]}"; do
  wallpaper_names+=("$(basename "$full_path")")
done

# --- Display the menu using 'select' ---
# (This part remains the same)
echo # Add a blank line for better spacing
echo "=== Wallpapers in Your Folder ==="
PS3="Enter the number of the wallpaper to set (or 'q' to quit): "

select choice in "${wallpaper_names[@]}" "Quit"; do
  # (Select loop logic remains the same)
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