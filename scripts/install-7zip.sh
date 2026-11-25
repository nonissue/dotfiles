#!/bin/sh
# Install the latest official 7-Zip Linux build into ~/.local/bin (no sudo)
# and link 7z -> 7zz, shadowing Ubuntu's older 7zip package (23.01 on 24.04).
# Re-run to upgrade. On macOS, use `brew install sevenzip` instead.
set -eu

case "$(uname -s)-$(uname -m)" in
    Linux-x86_64) arch=x64 ;;
    Linux-aarch64) arch=arm64 ;;
    *) echo "Unsupported platform: $(uname -s) $(uname -m)" >&2; exit 1 ;;
esac

bin="$HOME/.local/bin"
tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT

# Official builds are published as GitHub releases (linked from 7-zip.org).
curl -fsSL https://api.github.com/repos/ip7z/7zip/releases/latest |
    python3 -c '
import json, sys
for a in json.load(sys.stdin)["assets"]:
    if a["name"].endswith("-linux-" + sys.argv[1] + ".tar.xz"):
        print(a["browser_download_url"], a["digest"].removeprefix("sha256:"))
        break
' "$arch" >"$tmp/release"
read -r url sha <"$tmp/release" || { echo "No linux-$arch build in latest release" >&2; exit 1; }

echo "Downloading $url"
curl -fsSL -o "$tmp/7z.tar.xz" "$url"
echo "$sha  $tmp/7z.tar.xz" | sha256sum -c --quiet
tar -xJf "$tmp/7z.tar.xz" -C "$tmp" 7zz

mkdir -p "$bin"
install -m 755 "$tmp/7zz" "$bin/7zz"
ln -sf 7zz "$bin/7z"
"$bin/7z" | sed -n 2p
