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
  --name "StoryWeaverUpdater" \
  --icon "$ICON" \
  "$ROOT_DIR/updater/updater.py"

mkdir -p "$OUT_DIR"
rm -rf "$OUT_DIR/StoryWeaverUpdater.app"
cp -R "$ROOT_DIR/dist/StoryWeaverUpdater.app" "$OUT_DIR/StoryWeaverUpdater.app"

echo "Updater app -> $OUT_DIR/StoryWeaverUpdater.app"
