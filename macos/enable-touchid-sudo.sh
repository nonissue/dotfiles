#!/bin/bash

# Script to create /etc/pam.d/sudo_local from its template

TEMPLATE="/etc/pam.d/sudo_local.template"
TARGET="/etc/pam.d/sudo_local"

# Function to print errors
error_exit() {
  echo "Error: $1" >&2
  exit 1
}

echo "Checking preconditions..."

if [[ "$(uname -s)" != "Darwin" ]]; then
  error_exit "This script should only be run on macOS 14.0 or newer"
fi

# Check if the template exists
if [ ! -f "$TEMPLATE" ]; then
  error_exit "Template file '$TEMPLATE' does not exist."
fi

# Check if the target already exists
if [ -e "$TARGET" ]; then
  error_exit "Target file '$TARGET' already exists. Aborting to avoid overwrite."
fi

echo "Creating '$TARGET' from template..."

# Use sed to modify and tee to write with sudo
if sed "s/^#auth/auth/" "$TEMPLATE" | sudo tee "$TARGET" > /dev/null; then
  echo "Successfully created '$TARGET'."
else
  error_exit "Failed to create '$TARGET'."
fi
