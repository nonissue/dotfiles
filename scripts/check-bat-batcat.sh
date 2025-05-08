#!/bin/bash

command_exists() {
  command -v "$1" >/dev/null 2>&1
}


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

