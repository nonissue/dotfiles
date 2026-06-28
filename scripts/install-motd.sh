#!/usr/bin/env bash
# install-motd.sh — symlink MOTD scripts into /etc/update-motd.d (Linux only).
# Idempotent: safe to re-run on every dotbot bootstrap. Needs sudo to write /etc.
set -e

# No-op on non-Linux (e.g. macOS) — /etc/update-motd.d is Ubuntu-specific.
[ "$(uname)" = "Linux" ] || { echo "Not Linux, skipping MOTD symlinks"; exit 0; }

MOTD_SRC="$HOME/.dotfiles/motd"
MOTD_DST="/etc/update-motd.d"

# Archive distro defaults once (anything not already our symlink).
if [ ! -d "$MOTD_DST/archive" ]; then
    sudo mkdir -p "$MOTD_DST/archive"
    sudo find "$MOTD_DST" -maxdepth 1 -type f -exec mv -t "$MOTD_DST/archive" {} +
fi

# Link only the numbered scripts (skip README.md, preview.sh, new-preview.sh).
for script in "$MOTD_SRC"/[0-9]*; do
    sudo ln -sfn "$script" "$MOTD_DST/$(basename "$script")"
done
