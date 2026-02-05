#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
ASSETS="$ROOT_DIR/macos/assets"
PNG="$ASSETS/storyweaver.png"
ICONSET="$ASSETS/storyweaver.iconset"
ICNS="$ASSETS/storyweaver.icns"

if [ ! -f "$PNG" ]; then
  echo "Missing $PNG"
  echo "Place a 1024x1024 PNG at macos/assets/storyweaver.png"
  exit 1
fi

rm -rf "$ICONSET"
mkdir -p "$ICONSET"

function make_size() {
  local size="$1"
  local out="$2"
  sips -z "$size" "$size" "$PNG" --out "$ICONSET/$out" >/dev/null
}

make_size 16  icon_16x16.png
make_size 32  icon_16x16@2x.png
make_size 32  icon_32x32.png
make_size 64  icon_32x32@2x.png
make_size 128 icon_128x128.png
make_size 256 icon_128x128@2x.png
make_size 256 icon_256x256.png
make_size 512 icon_256x256@2x.png
make_size 512 icon_512x512.png
make_size 1024 icon_512x512@2x.png

iconutil -c icns "$ICONSET" -o "$ICNS"
rm -rf "$ICONSET"

echo "Created $ICNS"
