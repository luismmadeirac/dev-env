#!/usr/bin/env bash

# Usefull sometimes when the computer wifi and network ethernet port conflict due to the dock on laptop
#
# todo to make this more effecient since i find myself doing this way to often:
# - create the alias for the script
# - create flag options for the script:
#       - S to get the status if its on or off
#       - F Off
#       - O On
#
#  alias = "ns" Wifi Status
#  alias = "nso" wifi on
#  alias = "nsf" wifi off
#

# To get the wifi internface on macos `networksetup -listallhardwareports`
WIFI_INTERFACE="en0"

# Check current Wi-Fi status
WIFI_STATUS=$(networksetup -getairportpower "$WIFI_INTERFACE" | awk '{print $NF}')

echo "Wifi Status: $WIFI_STATUS"

if [[ "$WIFI_STATUS" == "Off" ]]; then

    read -p "Do you want to unable wifi? (y/n): " choice

    case $choice in
    y | Y | yes | YES)
        echo "turning on wifi..."
        networksetup -setairportpower "$WIFI_INTERFACE" on
        ;;
    n | N | no | NO)
        echo "you selected no"
        ;;
    *)
        echo "Exit"
        exit 0
        ;;
    esac

else
    read -p "Do you want to turn off wifi? (y/n): " choice

    case $choice in
    y | Y | yes | YES)
        echo "turning off wifi..."
        networksetup -setairportpower "$WIFI_INTERFACE" off
        ;;
    n | N | no | NO)
        echo "you selected no"
        ;;
    *)
        echo "Exit"
        exit 0
        ;;
    esac
fi

# if [[ "$WIFI_STATUS" == "On" ]]; then
#    networksetup -setairportpower "$WIFI_INTERFACE" off
# else
#    networksetup -setairportpower "$WIFI_INTERFACE" on
# fi
