#!/bin/bash

if ! xcode-select -p &>/dev/null; then
    echo "Xcode Command Line Tools..."
    xcode-select --install
    until xcode-select -p &>/dev/null; do
        sleep 5
    done
    echo "Xcode Command Line Tools intall done."
else
    echo "Xcode Command Line Tools already installed."
fi
