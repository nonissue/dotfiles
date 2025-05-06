#!/bin/bash

# Script to install Fish shell and set it as the default for the current user

# Improved error handling: exit immediately if a command exits with a non-zero status
set -e

echo "Starting Fish shell installation..."

# Update package lists (doing it early can prevent issues)
echo "Updating package lists..."
sudo apt-get update

# Install software-properties-common if it's not already installed
if ! dpkg -s software-properties-common >/dev/null 2>&1; then
  echo "Installing software-properties-common..."
  sudo apt-get install -y software-properties-common
else
  echo "software-properties-common is already installed."
fi

# Add the Fish shell PPA
echo "Adding Fish shell PPA..."
sudo apt-add-repository -y ppa:fish-shell/release-3

# Update package lists again to include the Fish PPA
echo "Updating package lists after adding PPA..."
sudo apt-get update

# Install Fish shell
echo "Installing Fish shell..."
sudo apt-get install -y fish

echo "Fish shell installed successfully."

# Prompt the user to set Fish as the default shell
read -p "Do you want to set Fish shell as your default shell? (y/N): " -n 1 -r
echo    # Add a newline after the user's response

if [[ "$REPLY" =~ ^[Yy]$ ]]; then
  echo "Changing default shell to Fish for the current user..."
  chsh -s /usr/bin/fish "$USER"
  echo "Default shell changed to Fish. You may need to log out and back in for the change to take effect."
else
  echo "Leaving the current default shell unchanged."
fi