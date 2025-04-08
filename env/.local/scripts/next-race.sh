#!/bin/bash

#
# Lazyness at its best
#
# The purpose of this script is absolutly worthless this is just for me to avoid going online looking for shit
# This script is meant to tell me based on the current date and timzeone of my laptop on when the next F1 Race is
# Where its take place, list the sessions and time of each session and also includes some helpful links.
#
# Also was just to brush on some bash since not been doing it for a while, feel free to copy and use it
# there is an alias for this script in my .zsh_alias called "next-race".

COLOR_BLUE='\e[34m'
COLOR_YELLOW='\e[33m'
COLOR_RED='\e[31m'
COLOR_MAGENTA='\e[35m'
COLOR_RESET='\e[0m'

schedule_file="$HOME/.local/scripts/f1_schedule.txt"

sessions=()

if [[ ! -f "$schedule_file" ]]; then
    echo "Error: Schedule data file '$schedule_file' not found in the current directory."
    echo "Please create it and populate it with session data."
    exit 1
fi

while IFS= read -r line || [[ -n "$line" ]]; do # Process lines, handle last line without newline
    # Skip comments and empty lines
    if [[ "$line" =~ ^\s*# || -z "$line" || "$line" =~ ^\s+$ ]]; then
        continue
    fi
    # Add the valid line to the sessions array
    sessions+=("$line")
done < "$schedule_file"

# Check if any data was actually loaded
if [[ ${#sessions[@]} -eq 0 ]]; then
    echo "Error: No valid session data found in '$schedule_file'."
    echo "Please ensure the file is not empty and contains valid session lines."
    exit 1
fi
# --- End Reading Schedule Data ---


# Get current time as Unix timestamp (seconds since epoch)
current_ts=$(date +%s)

# Get current time and timezone for display
current_time_info=$(date +"%Y-%m-%d %H:%M:%S %Z (%z)")

# --- Function to convert GMT date string to timestamp ---
get_timestamp() {
    local datetime_str="$1"
    local ts=""
    # IMPORTANT: Choose ONE - uncomment the correct line for your OS (Linux/macOS)
    #            Comment out the other line. Add back '2>/dev/null' if desired.

    # ** Option 1: For Linux systems (using GNU date) **
    # ts=$(date -d "$datetime_str" +%s 2>/dev/null)

    # ** Option 2: For macOS / BSD systems **
    ts=$(date -j -f "%Y-%m-%d %H:%M %Z" "$datetime_str" "+%s" 2>/dev/null)

    # --- End of choices ---
    echo "$ts" # Return timestamp (or empty string on failure)
}
# --- End Function ---

# --- Find the next upcoming event ---
target_event_name=""
first_future_session_found=false

# Now loop through the 'sessions' array populated from the file
for session_entry in "${sessions[@]}"; do
    # Skip lines that might be empty somehow (belt-and-braces)
    [[ -z "$session_entry" ]] && continue

    session_datetime_gmt=$(echo "$session_entry" | awk '{print $1" "$2" "$3}')
    event_and_session=$(echo "$session_entry" | cut -d' ' -f4-)
    session_type=$(echo "$event_and_session" | awk -F ' - ' '{print $NF}')
    event_name=$(echo "$event_and_session" | sed "s/ - ${session_type}$//")

    session_ts=$(get_timestamp "$session_datetime_gmt")

    if [[ -n "$session_ts" ]]; then
        if [[ "$session_ts" -ge "$current_ts" ]]; then
            target_event_name="$event_name"
            first_future_session_found=true
            break # Found the first future session, identified the target event
        fi
    fi
done
# --- End Finding next event ---

# --- Output ---
echo "------------------------------------------------------------------"
echo "Current Time: $current_time_info"
echo "------------------------------------------------------------------"

if ! $first_future_session_found; then
    echo "No upcoming F1 sessions found based on data in '$schedule_file'."
    echo " (Check if the file contains future events with valid dates, and ensure"
    echo "  the correct 'date' command is active in the 'get_timestamp' function.)"
    echo "-------------------------------------"
    exit 0
fi

# --- Gather all sessions for the target event into individual variables ---
session_FP1=""
session_FP2=""
session_FP3=""
session_SprintShootout=""
session_Sprint=""
session_Qualifying=""
session_Race=""

for session_entry in "${sessions[@]}"; do
     [[ -z "$session_entry" ]] && continue

    current_event_and_session=$(echo "$session_entry" | cut -d' ' -f4-)
    current_session_type=$(echo "$current_event_and_session" | awk -F ' - ' '{print $NF}')
    current_event_name=$(echo "$current_event_and_session" | sed "s/ - ${current_session_type}$//")

    if [[ "$current_event_name" == "$target_event_name" ]]; then
        current_session_datetime_gmt=$(echo "$session_entry" | awk '{print $1" "$2" "$3}')
        current_session_ts=$(get_timestamp "$current_session_datetime_gmt")

        if [[ -n "$current_session_ts" ]]; then
            local_session_start=$(date -d "@$current_session_ts" +"%A, %B %d, %Y at %H:%M %Z (%z)" 2>/dev/null)
            if [[ -z "$local_session_start" || "$local_session_start" == *"Invalid date"* ]]; then
                 local_session_start=$(date -r "$current_session_ts" +"%A, %B %d, %Y at %H:%M %Z (%z)")
            fi

            case "$current_session_type" in
                "FP1")             session_FP1="$local_session_start" ;;
                "FP2")             session_FP2="$local_session_start" ;;
                "FP3")             session_FP3="$local_session_start" ;;
                "Sprint Shootout") session_SprintShootout="$local_session_start" ;;
                "Sprint")          session_Sprint="$local_session_start" ;;
                "Qualifying")      session_Qualifying="$local_session_start" ;;
                "Race")            session_Race="$local_session_start" ;;
                *)                 ;;
            esac
        fi
    fi
done
# --- End Gathering sessions ---


# --- Print the formatted output for the target event WITH COLORS ---
echo "Next Upcoming F1 Event:"
echo "Event:        $target_event_name"
echo # Blank line

has_non_race_sessions=false

# Print each session if its variable is not empty (with consistent padding and colors)
# The padding width (-18s) might need slight adjustment depending on terminal font
# but usually works okay as escape codes are non-printing.
if [[ -n "$session_FP1" ]]; then
    printf "${COLOR_BLUE}%-18s${COLOR_RESET} %s\n" "FP1:" "$session_FP1"
    has_non_race_sessions=true
fi
if [[ -n "$session_SprintShootout" ]]; then
    printf "${COLOR_MAGENTA}%-18s${COLOR_RESET} %s\n" "Sprint Qualifying:" "$session_SprintShootout"
    has_non_race_sessions=true
fi
if [[ -n "$session_FP2" ]]; then
    printf "${COLOR_BLUE}%-18s${COLOR_RESET} %s\n" "FP2:" "$session_FP2"
    has_non_race_sessions=true
fi
if [[ -n "$session_Sprint" ]]; then
    printf "${COLOR_MAGENTA}%-18s${COLOR_RESET} %s\n" "Sprint Race:" "$session_Sprint"
    has_non_race_sessions=true
fi
if [[ -n "$session_FP3" ]]; then
    printf "${COLOR_BLUE}%-18s${COLOR_RESET} %s\n" "FP3:" "$session_FP3"
    has_non_race_sessions=true
fi
if [[ -n "$session_Qualifying" ]]; then
    printf "${COLOR_YELLOW}%-18s${COLOR_RESET} %s\n" "Qualifying:" "$session_Qualifying"
    has_non_race_sessions=true
fi
if [[ -n "$session_Race" ]]; then
    printf "${COLOR_RED}%-18s${COLOR_RESET} %s\n" "Race:" "$session_Race"
fi

echo "------------------------------------------------------------------------------------"
if $has_non_race_sessions; then
  echo "(Note: Session times other than Race may need confirmation or are estimates.)"
fi

f1_url="https://www.formula1.com/en/racing/2025.html"
link_text="Visit Official F1 Schedule"
printf '\e]8;;%s\e\\%s\e]8;;\e\\\n' "$f1_url" "$link_text"
echo "F1 Schedule Link: $f1_url"
echo "------------------------------------------------------------------------------------"