#!/usr/bin/env bash

echo "Bootstraping configuration for new mac..."


# Look for homebrew and if not found install it
if ! command -v brew &>/dev/null; then
    echo "Homebrew not found. Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    # Ensure brew is in the PATH for the current script session
    if [ -x "/opt/homebrew/bin/brew" ]; then # Apple Silicon
         eval "$(/opt/homebrew/bin/brew shellenv)"
    elif [ -x "/usr/local/bin/brew" ]; then # Intel
         eval "$(/usr/local/bin/brew shellenv)"
    fi
else
    echo "Homebrew found."
fi


# Look for git and if not found install it
if ! command -v git &>/dev/null; then
    echo "Git not found. Installing Git via Homebrew..."
    # Ensure brew command is available
    if command -v brew &>/dev/null; then
        brew install git
    else
        echo "Error: Homebrew command ('brew') not found. Cannot install Git."
        exit 1 # Exit if brew isn't available
    fi
else
    echo "Git found."
fi

# Verify git installation
if ! command -v git &>/dev/null; then
    echo "Error: Git command ('git') not found even after attempting installation."
    exit 1 # Exit if git still isn't available
fi

# Create personal directory if it doesn't exist
PERSONAL_DIR="$HOME/personal"
if [ ! -d "$PERSONAL_DIR" ]; then
    echo "Creating directory $PERSONAL_DIR..."
    mkdir "$PERSONAL_DIR"
else
    echo "Directory $PERSONAL_DIR already exists."
fi

DEV_ENV_DIR="$HOME/personal/dev"

if [ ! -d "$DEV_ENV_DIR/.git" ]; then # Check for .git to be more specific for a repo
    echo "Cloning dev-env repository into $DEV_ENV_DIR..."
    git clone https://github.com/luismmadeirac/dev-env "$DEV_ENV_DIR"
else
    echo "Directory $DEV_ENV_DIR already exists and appears to be a git repository. Skipping clone."
fi


if [ ! -d "$DEV_ENV_DIR" ]; then
    echo "Error: Failed to clone or find repository at $DEV_ENV_DIR."
    exit 1
fi


# MacOS Configuration
MAC_INIT_SCRIPT="./resources/mac/init.sh"

if [ -f "$MAC_INIT_SCRIPT" ] && [ -x "$MAC_INIT_SCRIPT" ]; then
    echo "Running MacOS Configuration ($MAC_INIT_SCRIPT)..."
    "$MAC_INIT_SCRIPT"
else
    echo "Warning: MacOS init script ($MAC_INIT_SCRIPT) not found or not executable. Skipping."
fi


# Init dev configuration
echo "Changing to $DEV_ENV_DIR to run dev setup..."
pushd "$DEV_ENV_DIR" > /dev/null # Suppress pushd output

RUN_SCRIPT="./run"
DEV_ENV_SCRIPT="./env/dev-env.sh" # Corrected path (removed trailing slash)

if [ -f "$RUN_SCRIPT" ] && [ -x "$RUN_SCRIPT" ]; then
    echo "Executing ./run script..."
    "$RUN_SCRIPT"
else
    echo "Warning: ./run script not found or not executable in $DEV_ENV_DIR. Skipping."
fi

if [ -f "$DEV_ENV_SCRIPT" ] && [ -x "$DEV_ENV_SCRIPT" ]; then
    echo "Executing ./env/dev-env.sh script..."
    "$DEV_ENV_SCRIPT"
else
    echo "Warning: ./env/dev-env.sh script not found or not executable in $DEV_ENV_DIR. Skipping."
fi

echo "Returning to original directory..."
popd > /dev/null # Suppress popd output


# --- Force Restart ---
echo "-----------------------------------------------------"
echo "Bootstrap script complete."
echo "WARNING: The system will now be restarted immediately!"
echo "You will be prompted for your administrator password."
echo "-----------------------------------------------------"
sleep 5 # Give the user a few seconds to read the message

sudo shutdown -r now

# The script will likely not reach here as the system restarts.
echo "Restart command issued."
exit 0