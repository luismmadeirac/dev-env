#!/usr/bin/env bash

echo "------------------- MacOS Setup  ---------------------"

max_attempts=3
attempt=1
sudo_success=false

read -p "Do you want to continue executing all scripts? (y/n): " choice

case "$choice" in
y | Y | yes | Yes | YES)
    # Keep sudo alive throughout script execution
    while [ $attempt -le $max_attempts ] && [ "$sudo_success" = false ]; do
        sudo -v

        if [ $? -eq 0 ]; then
            sudo_success=true
        else
            if [ $attempt -lt $max_attempts ]; then
                echo "Incorrect Password. Please try again."
                attempt=$((attempt + 1))
            else
                echo "Error: Failed to obtain sudo privileges after $max_attempts attempts. Exiting."
                exit 1
            fi
        fi
    done

    # Close any open System Preferences panes, to prevent them from overriding
    # settings we’re about to change
    osascript -e 'tell application "System Preferences" to quit'

    # Execture MacOS Scripts
    ./nuke-init-apps.sh
    ./sys-preferences.sh
    ./energy.sh

    ./Finder.sh

    ./ActivityMonitor.sh
    ./peripherals.sh

    ./ui.sh
    ./dock.sh
    ./desktop.sh
    ./screenshots.sh

    ./terminal.sh
    ./Safari.sh
    ./mail.sh
    ./calendar.sh

    ;;
*)
    echo "Execution skipped. Exiting."
    exit 0
    ;;
esac
