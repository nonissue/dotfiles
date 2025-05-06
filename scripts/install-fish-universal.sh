#!/bin/bash

# This script installs fish shell on Ubuntu (20.04+) or macOS (using Homebrew).
# It checks for an existing installation and interactively prompts to set fish as the default shell.

# Function to check if a command exists
command_exists() {
  command -v "$1" >/dev/null 2>&1
}

echo "Checking your operating system..."

# Detect operating system
OS="$(uname -s)"

case "${OS}" in
    Linux*)
        if command_exists apt; then
            PACKAGE_MANAGER="apt"
            echo "Detected Ubuntu/Debian. Using apt for package management."
        else
            echo "Error: apt not found. This script is intended for Ubuntu 20.04+."
            exit 1
        fi
        ;;
    Darwin*)
        if command_exists brew; then
            PACKAGE_MANAGER="brew"
            echo "Detected macOS. Using Homebrew for package management."
        else
            echo "Error: Homebrew not found. Please install Homebrew (https://brew.sh/) to proceed with fish installation on macOS."
            exit 1
        fi
        ;;
    *)
        echo "Error: Unsupported operating system: ${OS}"
        exit 1
        ;;
esac

# Check if fish is already installed
echo "Checking for existing fish shell installation..."
if command_exists fish; then
    echo "Fish shell is already installed."
    FISH_PATH=$(command -v fish)
else
    echo "Fish shell not found. Installing fish..."
    if [ "$PACKAGE_MANAGER" = "apt" ]; then
        echo "Adding fish-shell PPA..."
        sudo apt-add-repository ppa:fish-shell/release-3 -y
        if [ $? -ne 0 ]; then
            echo "Error adding PPA. Aborting installation."
            exit 1
        fi
        echo "Updating apt package list..."
        sudo apt update
        if [ $? -ne 0 ]; then
            echo "Error updating apt package list. Aborting installation."
            exit 1
        fi
        echo "Installing fish..."
        sudo apt install fish -y
        if [ $? -ne 0 ]; then
            echo "Error installing fish via apt. Aborting installation."
            exit 1
        fi
    elif [ "$PACKAGE_MANAGER" = "brew" ]; then
        echo "Installing fish via Homebrew..."
        brew install fish
        if [ $? -ne 0 ]; then
            echo "Error installing fish via Homebrew. Aborting installation."
            exit 1
        fi
    fi

    # Verify installation after attempting to install
    if command_exists fish; then
        echo "Fish shell installed successfully."
        FISH_PATH=$(command -v fish)
    else
        echo "Error: Fish shell installation failed."
        exit 1
    fi
fi

# Check current default shell
CURRENT_SHELL=$(echo $SHELL)
echo "Your current default shell is: $CURRENT_SHELL"

# Ask to set fish as default shell
if [ "$FISH_PATH" != "$CURRENT_SHELL" ]; then
    read -r -p "Do you want to set fish as your default shell? (yes/no): " SET_DEFAULT_SHELL
    if [[ "$SET_DEFAULT_SHELL" =~ ^[Yy][Ee][Ss]$ ]]; then
        echo "Setting fish as the default shell..."
        # Add fish path to /etc/shells if not already present (primarily for macOS)
        if [ "$OS" = "Darwin" ]; then
            if ! grep -q "$FISH_PATH" /etc/shells; then
                echo "Adding $FISH_PATH to /etc/shells (requires sudo)..."
                echo "$FISH_PATH" | sudo tee -a /etc/shells > /dev/null
                if [ $? -ne 0 ]; then
                    echo "Warning: Could not add fish path to /etc/shells. You might need to do this manually before setting fish as default."
                fi
            fi
        fi

        chsh -s "$FISH_PATH"
        if [ $? -eq 0 ]; then
            echo "Default shell changed to fish successfully."
            echo "Please log out and log back in for the changes to take effect."
        else
            echo "Error: Could not change default shell using chsh."
            echo "You may need to change it manually. The fish path is: $FISH_PATH"
        fi
    else
        echo "Fish shell will not be set as your default shell."
    fi
else
    echo "Fish shell is already your default shell."
fi

echo "Script finished."