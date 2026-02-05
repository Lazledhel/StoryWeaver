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

# Bundle apps as resources inside installer
RES_DIR="$MAC_DIR/installer/resources/apps"
rm -rf "$RES_DIR"
mkdir -p "$RES_DIR"

cp -R "$OUT_DIR/StoryWeaverLauncher.app" "$RES_DIR/StoryWeaverLauncher.app"
cp -R "$OUT_DIR/StoryWeaverEditor.app" "$RES_DIR/StoryWeaverEditor.app"
cp -R "$OUT_DIR/StoryWeaverUpdater.app" "$RES_DIR/StoryWeaverUpdater.app"

python3 -m PyInstaller \
  --noconfirm --clean --windowed \
  --name "StoryWeaverInstaller" \
  --icon "$ICON" \
  --add-data "$MAC_DIR/installer/resources:resources" \
  "$MAC_DIR/installer/installer.py"

rm -rf "$OUT_DIR/StoryWeaverInstaller.app"
cp -R "$ROOT_DIR/dist/StoryWeaverInstaller.app" "$OUT_DIR/StoryWeaverInstaller.app"

echo "Installer app -> $OUT_DIR/StoryWeaverInstaller.app"
