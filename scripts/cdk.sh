#!/usr/bin/env bash

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
}

install_cdk() {
  log "Installing AWS CDK..."
  npm install -g aws-cdk
  if [ $? -eq 0 ]; then
    log "AWS CDK installed successfully!"
    cdk --version
  else
    log "Failed to install AWS CDK. Please check your npm configuration and try again."
    exit 1
  fi
}

check_cdk_update() {
  local current_version=$(cdk --version | cut -d ' ' -f 1)
  local latest_version=$(npm view aws-cdk version)

  if [[ "$current_version" != "$latest_version" ]]; then
    log "New AWS CDK version available: $latest_version (current: $current_version)"
    read -p "Do you want to update to the latest version? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
      log "Updating AWS CDK..."
      npm install -g aws-cdk@latest
      if [ $? -eq 0 ]; then
        log "AWS CDK updated successfully to version $(cdk --version)"
      else
        log "Failed to update AWS CDK. Please try again."
        exit 1
      fi
    else
      log "Keeping current version: $current_version"
    fi
  else
    log "AWS CDK is up to date (version $current_version)"
  fi
}

log ""
log "------------------ AWS CDK Install ------------------"
log ""

if [[ "$DRY_RUN" == true ]]; then
  log "DRY" "Running in dry-run mode"
  log "DRY" "Filter: $filter"
fi

if command_exists cdk; then
  current_version=$(cdk --version)
  log "AWS CDK is already installed: $current_version"
  check_cdk_update
else
  log "AWS CDK not found. Starting installation process..."
  install_cdk
fi
