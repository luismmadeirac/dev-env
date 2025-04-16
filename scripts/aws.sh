#!/usr/bin/env bash

# Global variables
filter=""
DRY_RUN=false

# Logging function
log() {
  if [[ $1 == "DRY" ]]; then
    echo "[DRY_RUN]: ${@:2}"
  else
    echo "${@:1}"
  fi
}

# Check if a command exists
command_exists() {
  command -v "$1" >/dev/null 2>&1
}

# Execute command with logging
execute() {
  log "$1" "execute: ${@:2}"
  if [[ $1 == "DRY" ]]; then
    return
  fi
  "${@:2}"
}

# Get current AWS CLI version
get_current_version() {
  aws --version | cut -d ' ' -f 1 | cut -d '/' -f 2
}

install_aws_cli() {
  log "Installing AWS CLI..."

  # Create temporary directory
  local temp_dir=$(mktemp -d)
  cd "$temp_dir"

  # Download AWS CLI package
  log "Downloading AWS CLI installer..."
  curl -s "https://awscli.amazonaws.com/AWSCLIV2.pkg" -o "AWSCLIV2.pkg"

  if [ $? -eq 0 ]; then
    log "Installing AWS CLI package..."
    sudo installer -pkg AWSCLIV2.pkg -target /
    if [ $? -eq 0 ]; then
      log "AWS CLI installed successfully!"
      aws --version
    else
      log "Failed to install AWS CLI package. Please check the error message above."
      exit 1
    fi
  else
    log "Failed to download AWS CLI package. Please check your internet connection."
    exit 1
  fi

  # Cleanup
  cd - >/dev/null
  rm -rf "$temp_dir"
}

check_aws_cli_update() {
  local current_version=$(get_current_version)

  # Get latest version from AWS
  log "Checking for updates..."
  local latest_version=$(curl -s https://raw.githubusercontent.com/aws/aws-cli/v2/CHANGELOG.rst | grep -m 1 '^[0-9]' | cut -d ' ' -f 1)

  if [[ "$current_version" != "$latest_version" ]]; then
    log "New AWS CLI version available: $latest_version (current: $current_version)"
    read -p "Do you want to update to the latest version? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
      install_aws_cli
    else
      log "Keeping current version: $current_version"
    fi
  else
    log "AWS CLI is up to date (version $current_version)"
  fi
}

if [[ "$DRY_RUN" == true ]]; then
  log "DRY" "Running in dry-run mode"
  log "DRY" "Filter: $filter"
fi

if command_exists aws; then
  current_version=$(aws --version)
  log "AWS CLI is already installed: $current_version"
  check_aws_cli_update
else
  log "AWS CLI not found. Starting installation process..."
  install_aws_cli
fi
