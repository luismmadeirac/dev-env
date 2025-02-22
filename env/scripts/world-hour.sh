#!/bin/bash

# List of timezones
timezones=("America/New_York" "Europe/London" "Europe/Paris" "Asia/Tokyo" "Australia/Sydney")

# Function to display current time in a given timezone
show_time_in_timezone() {
    local timezone="$1"
    local current_time=$(TZ="${timezone}" date +"%A %Y-%m-%d %H:%M:%S %Z")
    printf "| %-20s | %-25s |\n" "${timezone}" "${current_time}"
}

# Display formatted table header
echo "+----------------------+---------------------------+\n"
echo "|      Timezone        |           Current Time     |\n"
echo "+----------------------+---------------------------+\n"

# Display current time in each timezone
for timezone in "${timezones[@]}"; do
    show_time_in_timezone "${timezone}"
done

# Display formatted table footer
echo "+----------------------+---------------------------+\n"
