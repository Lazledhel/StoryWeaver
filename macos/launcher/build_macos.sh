#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
MAC_DIR="$ROOT_DIR/macos"
OUT_DIR="$MAC_DIR/release"

ICON="$MAC_DIR/assets/storyweaver.icns"
if [ ! -f "$ICON" ]; then
  echo "Missing icon: $ICON"
  exit 1
fi

python3 -m PyInstaller \
  --noconfirm --clean --windowed \
  --name "StoryWeaverLauncher" \
  --icon "$ICON" \
  --add-data "$ROOT_DIR/storyweaver.ico:." \
  "$ROOT_DIR/Launcher/launcher.py"

mkdir -p "$OUT_DIR"
rm -rf "$OUT_DIR/StoryWeaverLauncher.app"
cp -R "$ROOT_DIR/dist/StoryWeaverLauncher.app" "$OUT_DIR/StoryWeaverLauncher.app"

echo "Launcher app -> $OUT_DIR/StoryWeaverLauncher.app"
