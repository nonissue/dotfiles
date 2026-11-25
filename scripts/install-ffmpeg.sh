#!/usr/bin/env bash
#
# Install the latest static ffmpeg/ffprobe build from johnvansickle.com
# into /usr/local/bin, shadowing any distro-packaged version.
#
# Why: Ubuntu 24.04 ships ffmpeg 6.1, which can't decode xHE-AAC (AOT 42).
# This is the build Audiobookshelf's docs recommend.

set -euo pipefail

ARCH="$(uname -m)"
case "$ARCH" in
x86_64) PKG="amd64-static" ;;
aarch64) PKG="arm64-static" ;;
*)
  echo "Unsupported architecture: $ARCH" >&2
  exit 1
  ;;
esac

URL="https://johnvansickle.com/ffmpeg/releases/ffmpeg-release-${PKG}.tar.xz"
TMPDIR="$(mktemp -d)"
trap 'rm -rf "$TMPDIR"' EXIT

echo "→ Downloading $URL"
curl -fsSL "$URL" -o "$TMPDIR/ffmpeg.tar.xz"

echo "→ Extracting"
tar -xf "$TMPDIR/ffmpeg.tar.xz" -C "$TMPDIR"

SRCDIR="$(find "$TMPDIR" -maxdepth 1 -type d -name "ffmpeg-*-${PKG}" | head -1)"
if [[ -z "$SRCDIR" ]]; then
  echo "Could not find extracted ffmpeg directory" >&2
  exit 1
fi

echo "→ Installing ffmpeg and ffprobe to /usr/local/bin"
sudo install -m 0755 "$SRCDIR/ffmpeg" /usr/local/bin/ffmpeg
sudo install -m 0755 "$SRCDIR/ffprobe" /usr/local/bin/ffprobe

echo
echo "✓ Installed:"
/usr/local/bin/ffmpeg -version | head -1
/usr/local/bin/ffprobe -version | head -1