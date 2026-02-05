#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
MAC_DIR="$ROOT_DIR/macos"
OUT_DIR="$MAC_DIR/release"
APP_NAME="StoryWeaver"

INSTALLER_APP="$OUT_DIR/StoryWeaverInstaller.app"
DMG_ROOT="$MAC_DIR/installer/dmg_root"
DMG_PATH="$OUT_DIR/StoryWeaver.dmg"

if [ ! -d "$INSTALLER_APP" ]; then
  echo "Missing installer app: $INSTALLER_APP"
  exit 1
fi

rm -rf "$DMG_ROOT"
mkdir -p "$DMG_ROOT"

cp -R "$INSTALLER_APP" "$DMG_ROOT/StoryWeaverInstaller.app"
ln -s /Applications "$DMG_ROOT/Applications"

rm -f "$DMG_PATH"
hdiutil create -volname "$APP_NAME" -srcfolder "$DMG_ROOT" -ov -format UDZO "$DMG_PATH"

echo "DMG created: $DMG_PATH"
