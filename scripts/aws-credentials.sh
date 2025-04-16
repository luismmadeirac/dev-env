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


#
# WARNING
# Implementation Deprecated currently using aws sso
# Need to update this script to use both older credentials file or new sso implementation from IAM
#
#
# configure_aws_cli() {
#   log "Would you like to configure AWS CLI credentials?"
#   log "You can also run (aws configure sso) for configuring aws credentials with your IAM Identity Center profile"
#   read -p "Configure AWS CLI now? (y/n) " -n 1 -r
#   echo
#   if [[ $REPLY =~ ^[Yy]$ ]]; then
#     aws configure
#     if [ $? -eq 0 ]; then
#       log "AWS CLI configured successfully!"
#     else
#       log "Failed to configure AWS CLI. Please try again manually using 'aws configure'"
#     fi
#   fi
# }


