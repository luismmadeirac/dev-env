#!/usr/bin/env bash

check_terraform() {
  if command -v terraform &>/dev/null; then
    # Get the current installed version
    current_version=$(terraform version -json | grep -o '"terraform_version":"[^"]*"' | cut -d'"' -f4)
    echo "Terraform is installed. Current version: $current_version"

    # Get the latest version from HashiCorp releases
    latest_version=$(curl -s https://releases.hashicorp.com/terraform/ | grep -o 'href="/terraform/[0-9]*\.[0-9]*\.[0-9]*/' | head -n 1 | cut -d'/' -f3)
    echo "Latest available version: $latest_version"

    # Compare versions
    if [ "$current_version" = "$latest_version" ]; then
      echo "Terraform is up to date."
      return 0
    else
      echo "Terraform needs to be updated."
      read -p "Do you want to update Terraform? (y/n): " choice
      if [[ $choice =~ ^[Yy]$ ]]; then
        echo "Updating Terraform..."
        brew upgrade terraform
        if [ $? -eq 0 ]; then
          echo "Terraform has been updated to version $(terraform version | head -n 1 | cut -d 'v' -f 2)."
          return 0
        else
          echo "Failed to update Terraform."
          return 1
        fi
      else
        echo "Update skipped."
        return 0
      fi
    fi
  else
    echo "Terraform is not installed."
    return 1
  fi
}

install_terraform() {
  echo "Installing Terraform..."
  brew install terraform

  if [ $? -eq 0 ]; then
    echo "Terraform has been installed successfully. Version: $(terraform version | head -n 1 | cut -d 'v' -f 2)"
    return 0
  else
    echo "Failed to install Terraform."
    return 1
  fi
}

echo "Checking Terraform status..."

# Check if Terraform is installed and up to date
if ! check_terraform; then
  # If not installed or update failed
  read -p "Do you want to install Terraform? (y/n): " choice
  if [[ $choice =~ ^[Yy]$ ]]; then
    install_terraform
  else
    echo "Installation skipped."
  fi
fi
