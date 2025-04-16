#!/usr/bin/env bash

# This Script is meant to be used for configuration of aws cli on your local machine, you can opt from the traditional IAM Configuration file or the SSO IAM option.
# This script will prompt you which option you want to configure and guide your through configuring everything, you can also opt to use the aws wizard. Due to the nature
# of how I currently have aws config, there are different profiles, accounts, etc for (dev, staging, prod, testing) so this script will ask you to set those all up. If you
# want to skip all that make sure to select single profile when you start this script.

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



