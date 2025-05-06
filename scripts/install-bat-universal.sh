#!/bin/bash

# Function to check if a command exists
command_exists() {
  command -v "$1" >/dev/null 2>&1
}

echo "Checking for latest bat release..."

# Get the download URL for the latest bat amd64 .deb package for standard Linux (glibc)
BAT_DEB_URL=$(curl -s https://api.github.com/repos/sharkdp/bat/releases/latest \
  | grep "browser_download_url" \
  | grep 'bat_.*_amd64\.deb"' \
  | cut -d '"' -f 4)


echo "BAT_DEB_URL: " $BAT_DEB_URL

if [ -z "$BAT_DEB_URL" ]; then
  echo "Error: Could not find the latest amd64.deb download URL for bat."
  echo "Please check the GitHub releases page manually: https://github.com/sharkdp/bat/releases"
  exit 1
fi

echo "Found download URL: $BAT_DEB_URL"
echo "Downloading bat .deb package..."

# Define the local download filename
DOWNLOAD_FILE="bat-latest-amd64.deb"

# Download the package
wget "$BAT_DEB_URL" -O "$DOWNLOAD_FILE"

if [ $? -ne 0 ]; then
  echo "Error: Download failed."
  exit 1
fi

echo "Installing bat .deb package..."

# Install the package using dpkg
# Use -y or --yes with apt-get to automatically confirm dependency resolution
sudo apt-get update # Ensure package list is up-to-date for dependency resolution
sudo dpkg -i "$DOWNLOAD_FILE"

if [ $? -ne 0 ]; then
  echo "Error: dpkg installation failed. Attempting to fix broken dependencies..."
  # Attempt to fix broken dependencies and finish the installation
  sudo apt --fix-broken install -y
  # Try installing the package again in case fix-broken didn't complete it
  if ! command_exists bat && ! command_exists batcat; then
      echo "Attempting dpkg install again after fixing dependencies..."
      sudo dpkg -i "$DOWNLOAD_FILE"
  fi

  # Final check after attempting fix
  if [ $? -ne 0 ] && ! command_exists bat && ! command_exists batcat; then
     echo "Error: Installation failed even after attempting to fix dependencies."
     echo "Please investigate the dpkg errors manually."
     # Clean up before exiting on error
     if [ -f "$DOWNLOAD_FILE" ]; then
       rm "$DOWNLOAD_FILE"
     fi
     exit 1
  fi
fi

echo "Bat package installation finished."

# Check if bat is installed as batcat and handle symlink
echo "Checking installed bat executable name..."

if command_exists bat; then
  echo "Bat executable found directly as 'bat'."
elif command_exists batcat; then
  BATCAT_PATH=$(command -v batcat)
  if [ -n "$BATCAT_PATH" ]; then
      read -r -p "Bat executable found as 'batcat' at $BATCAT_PATH. Do you want to create a symlink 'bat' in ~/.local/bin for easier access? (yes/no): " CREATE_SYMLINK
      if [[ "$CREATE_SYMLINK" =~ ^[Yy][Ee][Ss]$ ]]; then
          echo "Creating symlink 'bat' in ~/.local/bin..."
          mkdir -p "$HOME/.local/bin"
          ln -s "$BATCAT_PATH" "$HOME/.local/bin/bat"
          echo "Symlink created: $HOME/.local/bin/bat -> $BATCAT_PATH"
          echo "Ensure $HOME/.local/bin is in your PATH environment variable."
          echo "You might need to add 'export PATH=\$HOME/.local/bin:\$PATH' to your shell configuration file (e.g., ~/.bashrc, ~/.zshrc) and restart your terminal."
      else
          echo "Symlink will not be created."
          echo "You can use 'batcat' directly or create the symlink manually later."
      fi
  else
      echo "Error: 'batcat' command exists but its path could not be found. Cannot create symlink automatically."
      echo "You may need to use 'batcat' directly."
  fi
else
  echo "Neither 'bat' nor 'batcat' command was found after installation attempt."
fi

# Clean up the downloaded file
if [ -f "$DOWNLOAD_FILE" ]; then
  echo "Cleaning up downloaded file: $DOWNLOAD_FILE"
  rm "$DOWNLOAD_FILE"
fi

echo "Script finished."
